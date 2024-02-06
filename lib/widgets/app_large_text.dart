import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swype/constants/color_file.dart';

class AppLargeText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight fontWeight;
  const AppLargeText({
    super.key,
    // this.size = 32,
    this.size = 0.078,
    required this.text,
    this.color = appLargeTextColor,
    this.fontWeight = FontWeight.w800,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: size * screenWidth,
        // fontSize: 32,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
