import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

import 'camera_view.dart';

enum DetectorViewMode { liveFeed }

class DetectorView extends StatefulWidget {
  DetectorView({
    Key? key,
    required this.title,
    required this.onImage,
    this.customPaint,
    this.initialCameraLensDirection = CameraLensDirection.back,
    this.onCameraFeedReady,
    this.onDetectorViewModeChanged,
    this.onCameraLensDirectionChanged,
    this.serviceEnabled,
    this.locationId,
    this.acessToken,
    this.lat,
    this.long,
    this.locationName,
    this.type,
  }) : super(key: key);

  final String title;
  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final Function()? onCameraFeedReady;
  final Function(DetectorViewMode mode)? onDetectorViewModeChanged;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;
  bool? serviceEnabled;
  int? locationId;
  String? acessToken;
  double? lat;
  double? long;
  int? type;
  String? locationName;
  @override
  State<DetectorView> createState() => _DetectorViewState();
}

class _DetectorViewState extends State<DetectorView> {
  @override
  Widget build(BuildContext context) {
    return CameraView(
      acessToken: widget.acessToken,
      locationId: widget.locationId,
      lat: widget.lat,
      long: widget.long,
      type: widget.type,
      customPaint: widget.customPaint,
      onImage: widget.onImage,
      onCameraFeedReady: widget.onCameraFeedReady,
      onDetectorViewModeChanged: _onDetectorViewModeChanged,
      initialCameraLensDirection: widget.initialCameraLensDirection,
      onCameraLensDirectionChanged: widget.onCameraLensDirectionChanged,
      serviceEnabled: widget.serviceEnabled,
      locationName: widget.locationName,
    );
  }

  void _onDetectorViewModeChanged() {
    // Since there is only one mode (liveFeed), there is no need for mode switching logic.
    // If you want to keep the logic for future modifications, you can add it here.
    if (widget.onDetectorViewModeChanged != null) {
      widget.onDetectorViewModeChanged!(DetectorViewMode.liveFeed);
    }
    setState(() {});
  }
}
