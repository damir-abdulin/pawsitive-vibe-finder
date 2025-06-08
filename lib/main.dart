import 'package:flutter/material.dart';
import 'app.dart';
import 'src/di/service_locator.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.configureDependencies(); // Initialize GetIt
  runApp(const MyApp());
}
