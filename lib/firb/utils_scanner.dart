// import 'package:camera/camera.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:swype/main.dart';

// class UtilScanner {
//   UtilScanner._();
//   static Future<CameraDescription> getCamera(
//       CameraLensDirection cameraLensDirection) async {
//     return await availableCameras().then((List<CameraDescription> cameras) =>
//         cameras.firstWhere((CameraDescription cameraDescription) =>
//             cameraDescription.lensDirection == cameraLensDirection));
//   }

//   static InputImageRotation rotationToImageRotation(int rotation) {
//     switch (rotation) {
//       case 0:
//         return InputImageRotation.rotation0deg;

//       case 90:
//         return InputImageRotation.rotation90deg;

//       case 180:
//         return InputImageRotation.rotation180deg;
//       default:
//         assert(rotation == 270);
//         return InputImageRotation.rotation270deg;
//     }
//   }

//   static Uint8List concatenatePlanes(List<Plane> planes) {
//     final WriteBuffer allBytes = WriteBuffer();
//     for (Plane plane in planes) {
//       allBytes.putUint8List(plane.bytes);
//     }
//     return allBytes.done().buffer.asUint8List();
//   }

//   static InputImageMetadata buildMetadata(CameraImage image,InputImageRotation rotation)
//   {
//     return InputImageMetadata(size: Size(image.width.toDouble(), rotation: rotation, format: image.format.raw, bytesPerRow:))

//   }
// }
