// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:swype/pages/components/new_text.dart';

class SecondaryContainer extends StatelessWidget {
  final String headerIconPath;
  final String headerText;
  final String imagePath;
  final String rowText1;
  final String rowText2;
  final String heading1;
  SecondaryContainer({
    super.key,
    required this.headerIconPath,
    required this.headerText,
    required this.rowText1,
    required this.rowText2,
    required this.imagePath,
    required this.heading1,
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
                Image.asset(
                  imagePath,
                  height: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppUText(
                      text: heading1,
                      fontSize: 14,
                    ),
                    Row(
                      children: [
                        AppUText(
                          text: rowText1,
                          fontSize: 14,
                        ),
                        AppUText(
                          text: rowText2,
                          fontSize: 14,
                        ),
                      ],
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
