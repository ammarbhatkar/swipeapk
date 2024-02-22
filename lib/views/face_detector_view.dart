import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:swype/views/face_detecttor.dart';
import 'package:swype/views/painters/detector_view.dart';

import 'painters/face_detector_painter.dart';

class FaceDetectorView extends StatefulWidget {
  FaceDetectorView({
    Key? key,
    this.serviceEnabled,
    this.locationId,
    this.acessToken,
    this.lat,
    this.long,
    this.type,
    this.locationName,
  }) : super(key: key);
  bool? serviceEnabled;
  int? locationId;
  String? acessToken;
  double? lat;
  double? long;
  int? type;
  String? locationName;
  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      //this is for drawing eyes ear dot maps on face
      enableContours: false,

      enableLandmarks: false,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      locationName: widget.locationName,
      acessToken: widget.acessToken,
      locationId: widget.locationId,
      lat: widget.lat,
      long: widget.long,
      type: widget.type,
      title: 'Face Detector',
      customPaint: _customPaint,
      //   text: _text,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
      serviceEnabled: widget.serviceEnabled,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final faces = await _faceDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';
      for (final face in faces) {
        text += 'face: ${face.boundingBox}\n\n';
      }
      _text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
