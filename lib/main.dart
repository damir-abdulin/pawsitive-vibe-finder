import 'package:flutter/material.dart';
import 'package:pawsitive_vibe_finder/app.dart';
import 'package:pawsitive_vibe_finder/src/di/service_locator.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.configureDependencies(); // Initialize GetIt
  runApp(const MyApp());
}
