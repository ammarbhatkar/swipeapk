// FaceDetectorPainter class in face_detector_painter.dart
import 'package:flutter/material.dart';

class NewPainter extends CustomPainter {
  final Rect boundingBox;
  final double originalImageWidth;
  final double originalImageHeight;

  NewPainter(
      this.boundingBox, this.originalImageWidth, this.originalImageHeight);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red // Change the color as needed
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0; // Adjust the stroke width as needed

    // Calculate the scaling factor to map the original image dimensions to the displayed size
    final double scaleX = size.width / originalImageWidth;
    final double scaleY = size.height / originalImageHeight;

    // Apply scaling to the bounding box
    final Rect scaledBoundingBox = Rect.fromLTRB(
      boundingBox.left * scaleX,
      boundingBox.top * scaleY,
      boundingBox.right * scaleX,
      boundingBox.bottom * scaleY,
    );

    canvas.drawRect(scaledBoundingBox, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
