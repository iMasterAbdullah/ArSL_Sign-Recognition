import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class MLService {
  static Interpreter? _interpreter;
  static List<String> _labels = [];

  /// Call this once in main():
  ///   await MLService.initialize();
  static Future<void> initialize() async {
    try {
      // Your classifier model:
      // pubspec.yaml:
      //   assets:
      //     - assets/models/sign_classifier.tflite
      _interpreter = await Interpreter.fromAsset(
        'models/sign_classifier.tflite',
      );

      // Load labels:
      //   assets/labels/labels.txt
      final labelsString =
          await rootBundle.loadString('assets/labels/labels.txt');

      _labels = labelsString
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    } catch (e) {
      // So you see it in debug console if something fails
      // (e.g. wrong asset path)
      // ignore: avoid_print
      print('Error initializing MLService: $e');
    }
  }

  /// features63: List<double> length = 63
  /// returns: { 'label': String, 'confidence': double }
  static Future<Map<String, dynamic>> predict(List<double> features63) async {
    if (_interpreter == null || _labels.isEmpty) {
      throw Exception('MLService not initialized or labels missing');
    }
    if (features63.length != 63) {
      throw Exception(
        'Expected 63 features, but got ${features63.length}.',
      );
    }

    // Input [1, 63]
    final input = [features63];

    // Output [1, numClasses=30]
    final output = [
      List<double>.filled(_labels.length, 0.0),
    ];

    _interpreter!.run(input, output);

    final probs = List<double>.from(output[0]);

    int bestIndex = 0;
    double bestProb = probs[0];

    for (int i = 1; i < probs.length; i++) {
      if (probs[i] > bestProb) {
        bestProb = probs[i];
        bestIndex = i;
      }
    }

    final label = _labels[bestIndex];

    return {
      'label': label,
      'confidence': bestProb,
    };
  }
}
