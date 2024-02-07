// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swype/pages/components/attendance_container.dart';
import 'package:swype/pages/components/new_text.dart';
import 'package:swype/pages/components/secondary_container.dart';
import 'package:swype/util/permision_denied_dialog.dart';
import 'package:swype/views/app_drawer.dart';

class NewHomeView extends StatefulWidget {
  bool? isGranted;
  bool serviceEnabled;
  NewHomeView({
    super.key,
    this.isGranted,
    this.serviceEnabled = false,
  });

  @override
  State<NewHomeView> createState() => _NewHomeViewState();
}

class _NewHomeViewState extends State<NewHomeView> {
  bool isChekin = false;
  String? lat;
  String? long;

  Future<Position> _getCurrentLocation() async {
    widget.serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (widget.serviceEnabled == false) {
      return Future.error("Enable Location");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permisiion denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return NewHomeView();
      }));
      return Future.error("Permission denied forever");
    }
    // get current position
    Position position = await Geolocator.getCurrentPosition();

    double distanceInMeters = Geolocator.distanceBetween(
      // startLatitude,
      position.latitude,
      // startLongitude,
      position.longitude,
      // endLatitude,
      18.9546034,
      // endLongitude,
      72.8165149,
    );
    print("Distance in meters : $distanceInMeters");
    return position;
    // return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.outline, size: 25),
        // leadingWidth: 0,

        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.report,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.notifications_active,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppUText(
                  text: "Tue, ",
                ),
                AppUText(
                  text: "7 Feb",
                ),
              ],
            ),
            Row(
              children: [
                AppUText(
                  text: "Good Afternoon, ",
                ),
                AppUText(
                  text: "Ammar",
                  color: Theme.of(context).colorScheme.outline,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 231, 235, 239),
                border: const GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 85, 138, 182),
                      Colors.white,
                    ],
                  ),
                  width: 2.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/emptyprofile.png",
                    height: 80,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "00:00",
                              style: GoogleFonts.openSans(
                                fontSize: 50,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                "Hrs",
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppUText(
                          text: "Check-In to start your day",
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                // itemCount: 10, // Replace with your actual list length
                children: [
                  AttendanceContinaer(
                    headerIconPath: "assets/icons/calendar.png",
                    headerText: "Attendance for this Month",
                    presentDays: "02",
                    leaves: "4.0",
                    totalDays: "28",
                  ),
                  SizedBox(height: 10),
                  SecondaryContainer(
                    headerIconPath: "assets/icons/summer-holidays.png",
                    headerText: "Upcoming Holidays",
                    rowText1: "Wed, ",
                    rowText2: "10 Feb 2023",
                    imagePath: "assets/icons/prefixCalender.png",
                    heading1: "Holi (Rang Panchmi)",
                  ),
                  SizedBox(height: 10),
                  SecondaryContainer(
                    headerIconPath: "assets/icons/birthday-cake.png",
                    headerText: "Upcoming Birthday's",
                    rowText1: "Fri,",
                    rowText2: "10 Feb 2023",
                    imagePath: "assets/icons/emptyprofile.png",
                    heading1: "Ajay Maurya",
                  ),
                  SizedBox(height: 10),
                  AttendanceContinaer(
                    headerIconPath: "assets/icons/calendar.png",
                    headerText: "Attendance for this Month",
                    presentDays: "02",
                    leaves: "4.0",
                    totalDays: "28",
                  ),
                  SizedBox(height: 10),
                  SecondaryContainer(
                    headerIconPath: "assets/icons/summer-holidays.png",
                    headerText: "Upcoming Holidays",
                    rowText1: "Wed, ",
                    rowText2: "10 Feb 2023",
                    imagePath: "assets/icons/prefixCalender.png",
                    heading1: "Holi (Rang Panchmi)",
                  ),
                  SizedBox(height: 10),
                  SecondaryContainer(
                    headerIconPath: "assets/icons/birthday-cake.png",
                    headerText: "Upcoming Birthday's",
                    rowText1: "Fri,",
                    rowText2: "10 Feb 2023",
                    imagePath: "assets/icons/emptyprofile.png",
                    heading1: "Ajay Maurya",
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isChekin
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Theme.of(context).colorScheme.inverseSurface,
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                ),
                onPressed: () async {
                  var location = await Permission.location.request();

                  if (location.isGranted) {
                    _getCurrentLocation();

                    // _getCurrentLocation().then(
                    //   (value) {
                    //     lat = '${value.latitude}';
                    //     long = '${value.longitude}';
                    //     setState(() {
                    //       print("Lattitude value : $lat");

                    //       print("Lattitude value : $long");
                    //     });
                    //   },
                    // );
                    setState(() {
                      isChekin = !isChekin;
                    });
                  } else if (location.isDenied) {
                    print("Denied");
                  } else {
                    DialogUtils.showPermissionDeniedDialog(context, "Location");
                  }
                  // setState(() {
                  //   isChekin = !isChekin;
                  // });
                  // Handle button press...
                },
                child: AppUText(
                  text: isChekin ? 'Check Out' : 'Check In',
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
