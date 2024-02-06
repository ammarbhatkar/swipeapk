// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swype/constants/color_file.dart';

class CustomCredentialTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double size;
  final FontWeight fontWeight;
  final IconData? suffixIcon;
  final bool? obsecureText;
  const CustomCredentialTextField({
    super.key,
    required this.controller,
    required this.hintText,
    // this.size = 16,
    this.size = 0.0389,
    this.fontWeight = FontWeight.w600,
    this.suffixIcon,
    this.obsecureText,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(
          // horizontal: 20,
          // vertical: 10,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: primaryBlueColor,
          width: 1,
        ),
      ),
      child: TextField(
        obscureText: obsecureText ?? false,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 0.0486 * screenWidth, // 5% of screen width
            vertical: 0.0136 * screenHeight, // 2% of screen height
            // horizontal: 20,
            // vertical: 10,
          ),
          isDense: true,
          hintText: hintText,
          hintStyle: GoogleFonts.openSans(
            fontSize: size * screenWidth,
            fontWeight: fontWeight,
            color: textFieldColor,
          ),
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: EdgeInsets.only(
                    // right: 20,
                    right: 0.0486 * screenWidth,
                  ),
                  child: Icon(
                    suffixIcon,
                    color: textFieldColor,
                  ),
                )
              : null,
          suffixIconConstraints: BoxConstraints(maxHeight: 20),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
