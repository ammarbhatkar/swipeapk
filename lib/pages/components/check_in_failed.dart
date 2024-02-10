// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:swype/pages/components/new_text.dart';

class CustomFailedDialog extends StatelessWidget {
  const CustomFailedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          CardDialog(),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/icons/failed.png",
                width: 28,
                height: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardDialog extends StatelessWidget {
  const CardDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Center(
            child: Image.asset(
              "assets/icons/exclamation.png",
              width: 72,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: AppUText(
              text: "Check in failed!",
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
