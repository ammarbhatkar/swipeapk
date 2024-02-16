// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:swype/components/new_text.dart';

class CheckInContainer extends StatelessWidget {
  final String time;
  // final String timeMeridem;
  final String status;
  final String location;
  final Color? indicatorColor;
  bool? usedInMyActivities = false;
  String? activityDate;
  String? activityMonth;
  CheckInContainer({
    super.key,
    required this.time,
    // required this.timeMeridem,
    required this.status,
    required this.location,
    this.usedInMyActivities,
    this.indicatorColor,
    this.activityDate,
    this.activityMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        // color: Color.fromARGB(255, 228, 247, 230),
        // gradient: LinearGradient(
        //   colors: [Colors.green[50]!, Colors.green[100]!],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        // border: Border.all(color: borderColor),
      ),
      child: Container(
        // color: Colors.amber,
        // color: Colors.white,
        // height: 50,
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: usedInMyActivities == false
                      ? const EdgeInsets.only(top: 4)
                      : const EdgeInsets.only(top: 0),
                  child: usedInMyActivities == false
                      ? Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: indicatorColor,
                          ),
                        )
                      : Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              )),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppUText(
                                  text: activityDate.toString(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  lineHeight: 0.8,
                                ),
                                SizedBox(height: 2),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: AppUText(
                                    text: activityMonth.toString(),
                                    // text: "Jan",
                                    fontSize: 12,
                                    lineHeight: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),

                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppUText(
                      text: time,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    SizedBox(height: 4),
                    AppUText(
                      text: location,
                      fontSize: 13,
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                // AppUText(
                //   text: timeMeridem,
                //   color: Theme.of(context).colorScheme.outline,
                //   fontWeight: FontWeight.w700,
                // ),
                // SizedBox(
                //   width: 10,
                // ),
                // VerticalDivider(
                //   color: Theme.of(context).colorScheme.outline,
                //   thickness: 1,
                // ),
                // SizedBox(
                //   width: 10,
                // ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                      decoration: BoxDecoration(
                        color: indicatorColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: AppUText(
                          text: status,
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: Theme.of(context).colorScheme.outline,
              thickness: 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
