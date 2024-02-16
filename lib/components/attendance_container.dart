// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:swype/components/new_text.dart';

class AttendanceContinaer extends StatelessWidget {
  final String headerIconPath;
  final String headerText;
  final String presentDays;
  final String leaves;
  final String totalDays;
  AttendanceContinaer({
    super.key,
    required this.headerIconPath,
    required this.headerText,
    required this.presentDays,
    required this.leaves,
    required this.totalDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  headerIconPath,
                  height: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                AppUText(
                  text: headerText,
                  color: Theme.of(context).colorScheme.outline,
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ],
            ),
            Divider(
              indent: 2,
              endIndent: 2,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppUText(
                      text: presentDays,
                      color: Colors.black,
                    ),
                    AppUText(
                      text: "Present",
                      fontSize: 14,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppUText(
                      text: leaves,
                      color: Colors.black,
                    ),
                    AppUText(
                      text: "Leaves",
                      fontSize: 14,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppUText(
                      text: totalDays,
                      color: Colors.black,
                    ),
                    AppUText(
                      text: "Total Days",
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
