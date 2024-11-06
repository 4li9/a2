import 'package:a2/%D8%A7%D9%84%D8%B5%D9%81%D8%AD%D8%A7%D8%AA/home.dart';
import 'package:a2/routes.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Currency Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home(),
      routes: routes,
    );
  }
}
