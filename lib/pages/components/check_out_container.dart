import 'package:flutter/material.dart';
import 'package:swype/pages/components/new_text.dart';

class CheckOutContainer extends StatelessWidget {
  final String time;
  final String timeMeridem;
  final String status;
  final String location;
  const CheckOutContainer({
    super.key,
    required this.time,
    required this.timeMeridem,
    required this.status,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        // gradient: LinearGradient(
        //   colors: [Colors.red[50]!, Colors.red[100]!],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        border: Border.all(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
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
