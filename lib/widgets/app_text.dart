import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swype/constants/color_file.dart';

class AppText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight fontWeight;

  const AppText({
    super.key,
    // this.size = 16,
    this.size = 0.03893,
    required this.text,
    this.color = appTextColor,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: size * screenWidth,
        // fontSize: size,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
