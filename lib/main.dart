import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:swype/isar_collections/location_collection.dart';
import 'package:swype/services/auth_gate.dart';
import 'package:swype/themes/theme_provider.dart';
import 'package:swype/views/login_view.dart';

import 'package:swype/views/new_home.dart';
import 'package:swype/views/splash_scree.dart';
import 'package:swype/views/testing_timer.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  // final dir = await getApplicationDocumentsDirectory();
  // final isar = await Isar.open(
  //   [LocationCollectionSchema],
  //   directory: dir.path,
  // );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );

  // isar.clear();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      // home: SplashScreen(),
      home: SplashScreen(),
    );
  }
}
