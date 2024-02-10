// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, prefer_conditional_assignment

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype/constants/color_file.dart';
import 'package:swype/isar_services/isar_service.dart';
import 'package:swype/models/check_in_event_model.dart';
import 'package:swype/models/location_api_model.dart';
import 'package:swype/pages/components/attendance_container.dart';
import 'package:swype/pages/components/check_in_container.dart';
import 'package:swype/pages/components/check_in_failed.dart';
import 'package:swype/pages/components/check_out_container.dart';
import 'package:swype/pages/components/new_text.dart';
import 'package:swype/pages/components/secondary_container.dart';
import 'package:swype/pages/components/sucess_dialog.dart';
import 'package:swype/services/location_service.dart';
import 'package:swype/services/login_api_service.dart';
import 'package:swype/util/permision_denied_dialog.dart';
import 'package:swype/views/app_drawer.dart';

class NewHomeView extends StatefulWidget {
  bool? isGranted;
  bool serviceEnabled;
  String? email;

  NewHomeView({
    super.key,
    this.isGranted,
    this.serviceEnabled = false,
    this.email,
  });

  @override
  State<NewHomeView> createState() => _NewHomeViewState();
}

class _NewHomeViewState extends State<NewHomeView> {
  bool isChekin = false;
  String? lat;
  String? long;
  bool isLoading = false;

  // Declare timer instance
  Timer? timer;
  double opacityLevel = 1.0;
  List<CheckEvent> checkEvents = [];

  //Declare durationinstance to keep track of time elapsed
  Duration elapsedTime = Duration();
  // variable to store the first check-in time
  DateTime? firstCheckInTime;
  DateTime _currentDate = DateTime.now();
// instance of locationapi model
  LocationApiModel? locationApiModel;

  final ApiServices apiService = ApiServices();

  // final isarService = IsarService();

  String? accessToken;
  @override
  void initState() {
    print("teh email of user after log i is :${widget.email}");
    getLoginInfo();
    super.initState();

    currentDate();
    // _checkPermision();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer?.cancel();
    super.dispose();
  }

  void currentDate() {
    setState(() {
      _currentDate = DateTime.now();
    });
  }

  void startTimer() {
    DateTime currentTime = DateTime.now();
    if (checkEvents.isEmpty) {
      firstCheckInTime = DateTime.now();
      print('First check-in time: $firstCheckInTime');
    } else {
      elapsedTime = currentTime.difference(firstCheckInTime ?? currentTime);
    }
    // Start the timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Update the elapsed time every second
      setState(() {
        elapsedTime += Duration(seconds: 1);
        opacityLevel =
            opacityLevel == 0 ? 1.0 : 0.0; // Toggle the opacity level
      });
    });
  }

  void resetTimer() {
    // Cancel the timer
    timer?.cancel();

    // Reset the elapsed time
    setState(() {
      if (firstCheckInTime != null) {
        elapsedTime = DateTime.now().difference(firstCheckInTime!);
      }
      // elapsedTime = Duration();
      opacityLevel = 1.0; // Reset the opacity level
    });
  }

  String getGreeting() {
    var hour = _currentDate.hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  Future<void> getLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = await prefs.getString('email');
    var accessToken = await prefs.getString('acessToken');
    setState(() {
      widget.email = email;
      accessToken = accessToken;
    });
    var locations = await fetchLocations(accessToken!);
    // locations
    // if (locationApiModel != null) {
    //   fetchLocations(accessToken!);
    // }
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
        actions: [],
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width *
            0.8, // This line controls the width of the drawer
        child: MyDrawer(
          email: widget.email ?? "",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppUText(
                  text: "${DateFormat('EEE, ').format(_currentDate)}",
                ),
                AppUText(
                  text: "${DateFormat('d MMM').format(_currentDate)}",
                ),
              ],
            ),
            Row(
              children: [
                AppUText(
                  text: "${getGreeting()}, ",
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
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AnimatedOpacity(
                              opacity: opacityLevel,
                              duration: Duration(seconds: 1),
                              child: Text(
                                "${elapsedTime.inHours.toString().padLeft(2, '0')}:${(elapsedTime.inMinutes % 60).toString().padLeft(2, '0')}",
                                style: GoogleFonts.openSans(
                                  fontSize: 50,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inverseSurface,
                                  fontWeight: FontWeight.w700,
                                ),
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
              child: checkEvents.isEmpty
                  ? Container(
                      child: Center(
                        child: Text(
                          "No activity for today",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: checkEvents.length,
                      itemBuilder: (context, index) {
                        final event = checkEvents[index];
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CheckInContainer(
                              borderColor: event.status == "Check In"
                                  ? Colors.green
                                  : Colors.red,
                              time: "${event.time.hour}:${event.time.minute} ",
                              timeMeridem: event.time.hour >= 12 ? "PM" : "AM",
                              status: event.status,
                              location: event.location,
                            ));
                      },
                    ),
            ), //
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
                  // showDialog(
                  //     context: context,
                  //     builder: (context) => CustomFailedDialog());

                  var location = await Permission.location.request();

                  if (location.isGranted) {
                    setState(() {
                      isLoading = true; // Start loading
                    });
                    if (isLoading == true) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return
                              //  Dialog(
                              //   child:
                              SpinKitSpinningLines(color: primaryBlueColor);
                          // child: new Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     new CircularProgressIndicator(),
                          //     new Text("Loading"),
                          //   ],
                          // ),
                          // );
                        },
                      );
                    }

                    try {
                      // Position position = await getCurrentLocation(context);

                      Map<String, dynamic>? position =
                          await getCurrentLocation(context);
                      setState(() {
                        isChekin = !isChekin;
                        // print(position.latitude);
                        // print(position.speed);
                        // Start or reset the timer depending on the check-in status
                        if (isChekin) {
                          // print('First check-in time: $firstCheckInTime');
                          startTimer();
                          checkEvents.add(
                            CheckEvent(
                              time: DateTime.now(),
                              status: "Check In",
                              location: "${position?['name']}",
                            ),
                          );
                        } else {
                          resetTimer();
                          checkEvents.add(CheckEvent(
                            time: DateTime.now(),
                            status: "Check Out",
                            location:
                                // "${position.latitude}, ${position.longitude}",
                                "${position?['name']}",
                          ));
                        }
                      });
                    } catch (e) {
                      print(e);
                    } finally {
                      if (isLoading) {
                        setState(() {
                          isLoading = false; // End loading
                        });
                        Navigator.of(context).pop(); // Dismiss the dialog
                      }
                    }
                  } else if (location.isDenied) {
                    print("Denied");
                  } else {
                    DialogUtils.showPermissionDeniedDialog(context, "Location");
                  }
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

// Create a global IsarService instance
  IsarService isarService = IsarService();

  Future<void> fetchLocations(String acessToken) async {
    print("fetching locations");
    setState(() {
      isLoading = true;
    });
    LocationApiModel response = await apiService.locationApi(acessToken);

    if (response.locations != null) {
      for (var obj in response.locations!) {
        isarService.addLocation(
          obj.id ?? 0,
          obj.name ?? "",
          obj.lat ?? 0.0,
          obj.long ?? 0.0,
          obj.radius ?? 0,
        );
      }
    }

    print("teh respomse is ${response}");

    setState(() {
      locationApiModel = response;
      isLoading = false;
    });
  }
}
