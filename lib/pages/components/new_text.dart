import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;

  const AppText(
      {super.key,
      required this.text,
      this.color = Colors.black,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: 18,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}

// thi is for third 