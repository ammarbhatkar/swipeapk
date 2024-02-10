// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:swype/pages/components/new_text.dart';

class CheckInContainer extends StatelessWidget {
  final String time;
  final String timeMeridem;
  final String status;
  final String location;
  final borderColor;
  const CheckInContainer({
    super.key,
    required this.time,
    required this.timeMeridem,
    required this.status,
    required this.location,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        // color: Color.fromARGB(255, 228, 247, 230),
        // gradient: LinearGradient(
        //   colors: [Colors.green[50]!, Colors.green[100]!],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        // color: Colors.white,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppUText(
              text: time,
              color: Theme.of(context).colorScheme.outline,
              fontWeight: FontWeight.w700,
            ),
            AppUText(
              text: timeMeridem,
              color: Theme.of(context).colorScheme.outline,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              width: 10,
            ),
            VerticalDivider(
              color: Theme.of(context).colorScheme.outline,
              thickness: 1,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppUText(
                  text: status,
                  color: Theme.of(context).colorScheme.outline,
                  fontWeight: FontWeight.w700,
                ),
                AppUText(
                  text: location,
                  fontSize: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
