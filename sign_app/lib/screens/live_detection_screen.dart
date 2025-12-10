part of '../app.dart';

// 4) LIVE DETECTION SCREEN
//

class LiveDetectionScreen extends StatefulWidget {
  const LiveDetectionScreen({super.key});

  @override
  State<LiveDetectionScreen> createState() => _LiveDetectionScreenState();
}

class _LiveDetectionScreenState extends State<LiveDetectionScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  bool isDetecting = false;
  String? currentSignLabel;
  String? currentSignName;
  double? confidence;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      _initializeControllerFuture = _controller!.initialize();
      setState(() {});
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _toggleDetection() {
    setState(() {
      isDetecting = !isDetecting;
      if (!isDetecting) {
        currentSignLabel = null;
        currentSignName = null;
        confidence = null;
      } else {
        // Dummy recognition
        currentSignLabel = 'حرف الألف';
        currentSignName = 'Letter Alef';
        confidence = 0.92;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultCard = Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: currentSignLabel == null
            ? Text(
                tr(
                  context,
                  'لا توجد نتيجة بعد.\nضع يدك أمام الكاميرا لبدء التعرف على الإشارة.',
                  'No result yet.\nPlace your hand in front of the camera to start recognition.',
                ),
              )
            : Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.teal.withValues(alpha: 0.12),
                    child: Text(
                      currentSignLabel!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSignName ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (confidence != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            tr(
                              context,
                              'الدقة التقريبية: ${(confidence! * 100).toStringAsFixed(1)}٪',
                              'Approx. confidence: ${(confidence! * 100).toStringAsFixed(1)}%',
                            ),
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: confidence!.clamp(0, 1),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr(context, 'التعرف الحي على الإشارة', 'Live sign detection'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: _controller == null
                    ? const Center(child: CircularProgressIndicator())
                    : FutureBuilder(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                CameraPreview(_controller!),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: CustomPaint(
                                    painter: _CornersPainter(),
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                tr(
                                  context,
                                  'حدث خطأ في تشغيل الكاميرا:\n${snapshot.error}',
                                  'An error occurred while starting the camera:\n${snapshot.error}',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
              ),
            ),
          ),
          resultCard,
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    tr(
                      context,
                      'تأكد من وجود إضاءة جيدة، وأن اليد ظاهرة بوضوح داخل إطار الكاميرا.',
                      'Make sure there is good lighting and your hand is clearly visible within the frame.',
                    ),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _controller == null ? null : _toggleDetection,
                icon: Icon(
                  isDetecting
                      ? Icons.stop_circle_outlined
                      : Icons.play_arrow_rounded,
                ),
                label: Text(
                  tr(
                    context,
                    isDetecting ? 'إيقاف التعرف' : 'بدء التعرف',
                    isDetecting ? 'Stop detection' : 'Start detection',
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CornersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.tealAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    const cornerLength = 24.0;

    // top-left
    canvas.drawLine(
      const Offset(0, 0),
      const Offset(cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      const Offset(0, 0),
      const Offset(0, cornerLength),
      paint,
    );

    // top-right
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, cornerLength),
      paint,
    );

    // bottom-left
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - cornerLength),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(cornerLength, size.height),
      paint,
    );

    // bottom-right
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

//

