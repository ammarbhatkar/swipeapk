// import 'package:flutter/material.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:swype/views/camera_view.dart';

// class FaceDetectorPage extends StatefulWidget {
//   const FaceDetectorPage({super.key});

//   @override
//   State<FaceDetectorPage> createState() => _FaceDetectorPageState();
// }

// class _FaceDetectorPageState extends State<FaceDetectorPage> {
//   //create a facedtector object

//   final FaceDetector _faceDetector = FaceDetector(
//       options: FaceDetectorOptions(
//     enableContours: true,
//     enableClassification: true,
//   ));
//   bool _canProcess = true;
//   bool _isBusy = false;
//   CustomPaint? _customPaint;
//   String? _text;

//   void dispose() {
//     _canProcess = false;
//     _faceDetector.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const CameraView();
//   }
// }
