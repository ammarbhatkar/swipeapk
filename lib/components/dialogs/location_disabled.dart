// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swype/components/new_text.dart';

class LocationDisabledDialog extends StatelessWidget {
  const LocationDisabledDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          CardDialog(),
          // Positioned(
          //   top: 0,
          //   right: 0,
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: Image.asset(
          //       "assets/icons/failed.png",
          //       width: 28,
          //       height: 28,
          //     ),
          //   ),
          // ),
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
      // margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SizedBox(height: 20),
          AppUText(
            text: "Enable Location",
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 25),
          Center(
            child: Image.asset(
              "assets/icons/location_error.png",
              width: 72,
            ),
          ),
          SizedBox(height: 20),
          // Center(
          //   child: AppUText(
          //     text: "Location services are disabled",
          //     color: Colors.black,
          //   ),
          // ),
          // SizedBox(height: 5),
          AppUText(
            textAlign: TextAlign.center,
            text: "Please enable location  to continue",
            fontSize: 16,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // color: const Color.fromARGB(255, 255, 254, 254),
                    color: Colors.white,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      // color: Colors.grey[200]!,
                    ),
                  ),
                  child: AppUText(
                    text: "Cancel",

                    color: Theme.of(context).colorScheme.inverseSurface,
                    // color: Color.fromARGB(255, 215, 214, 214),
                    fontSize: 16,
                  ),
                ),
              ),
              // Spacer(),
              InkWell(
                onTap: () async {
                  Navigator.of(context).pop(); // Close the dialog
                  openAppSettings();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  child: AppUText(
                    text: "Settings",
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 10),
        ],
      ),
    );
  }
}
