import 'package:flutter/material.dart';
import 'services/MLService.dart';
import 'services/user_db_service.dart';
import 'app.dart';
export 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserDatabaseService.instance.init();
  await MLService.initialize();
  runApp(const ArslApp());
}

