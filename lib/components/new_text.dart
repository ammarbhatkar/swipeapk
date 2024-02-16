import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppUText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight fontWeight;
  final double fontSize;
  double? lineHeight;
  AppUText(
      {Key? key,
      required this.text,
      this.color,
      this.fontWeight = FontWeight.w600,
      this.fontSize = 18,
      this.lineHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: fontSize,
        color: color ?? Theme.of(context).colorScheme.scrim,
        fontWeight: fontWeight,
        height: lineHeight,
      ),
    );
  }
}
// this is for new ui
// thi is for third 
/// this is the code fo ammar+
/// okkkkkkk