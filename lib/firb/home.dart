import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:swype/views/face_detecttor.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isWorkng = false;
  CameraController? cameraController;
  FaceDetector? faceDetector;
  Size? size;
  List<Face>? faceList;
  CameraDescription? description;
  CameraLensDirection? cameraDirection = CameraLensDirection.front;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
