// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:swype/constants/color_file.dart';
import 'package:swype/widgets/app_text.dart';

class LoginButton extends StatelessWidget {
  final String text;
  const LoginButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
        // horizontal: 0.045 * screenWidth, // 5% of screen width
        // vertical: 0.015 * screenHeight,
        // horizontal: 0.05 * screenWidth, // 5% of screen width
        // vertical: 0.02 * screenHeight,
        // horizontal: 20,
        // vertical: 10,
        horizontal: screenWidth * 0.0487,
        vertical: screenHeight * 0.0136,
      ),
      decoration: BoxDecoration(
        color: primaryBlueColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            text: text,
            fontWeight: FontWeight.w600,
            color: buttonTextWhiteColor,
          ),
          Icon(
            Icons.arrow_forward,
            color: buttonTextWhiteColor,
            // size: 20,
            size: 0.0487 * screenWidth,
          )
        ],
      ),
    );
  }
}
