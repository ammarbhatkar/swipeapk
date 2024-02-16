// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, prefer_conditional_assignment

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype/components/out_of_radius.dart';
import 'package:swype/constants/color_file.dart';
import 'package:swype/isar_collections/activity_collection.dart';
import 'package:swype/isar_services/isar_service.dart';
import 'package:swype/models/location_api_model.dart';
import 'package:swype/components/check_in_container.dart';
import 'package:swype/components/check_in_failed.dart';
import 'package:swype/components/new_text.dart';
import 'package:swype/components/sucess_dialog.dart';
import 'package:swype/services/location_service.dart';
import 'package:swype/services/login_api_service.dart';
import 'package:swype/util/permision_denied_dialog.dart';
import 'package:swype/drawerpages/app_drawer.dart';
import 'package:swype/views/home_view.dart';

class NewHomeView extends StatefulWidget {
  bool? isGranted;
  bool serviceEnabled;
  String? email;
  bool? isActivityAdded = false;

  // creat a falg to start and stop the timer
  bool? isCheckingIn = false;
  bool? isCheckingOut = false;
  NewHomeView({
    super.key,
    this.isGranted,
    this.serviceEnabled = false,
    this.email,
    this.isActivityAdded,
    this.isCheckingIn,
    this.isCheckingOut,
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
  List<ActivityCollecion> checkEvents = [];

  //Declare durationinstance to keep track of time elapsed
  Duration elapsedTime = Duration();
  // variable to store the first check-in time
  DateTime? firstCheckInTime;
  DateTime _currentDate = DateTime.now();
// instance of locationapi model
  LocationApiModel? locationApiModel;
  String currentDay = "";

  final ApiServices apiService = ApiServices();
  int lastActivity = 0;
  int checkInType = 1;
  // final isarService = IsarService();

  //create instance of shared prefrence to get loginuser
  SharedPreferences? loginData;
  //get aceesstoken from SPrefre
  String? getAccessToken;
  //get email form Sprefre
  String? getEmail;

  @override
  void initState() {
    print("teh email of user after log i is :${widget.email}");

    super.initState();
    getLoginInfo();
    _getActivities();

    currentDate();
    // if (widget.isCheckingIn == true) {
    //   startTimer();
    // } else if (widget.isCheckingOut == true) {
    //   resetTimer();
    // }
    print("the check events are :${checkEvents}");
    print("the check events are :${checkEvents.length}");
    print("widget.isCheckingIn is :${widget.isCheckingIn}");
    print("widget.isCheckingOut is :${widget.isCheckingOut}");
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
      print("the current date is :${_currentDate}");
      currentDay = DateFormat('yyyy-MM-dd').format(_currentDate);
      print("the current day is :${currentDay}");
    });
  }

  void startTimer() {
    DateTime currentTime = DateTime.now();

    print("the first check in time from checck-- IN is :${firstCheckInTime}");
    if (firstCheckInTime != null) {
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
      print("the first check in time from checkout is :${firstCheckInTime}");
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
    loginData = await SharedPreferences.getInstance();
    setState(() {
      //assign acesstoken to getacestoken & email to get email
      getAccessToken = loginData?.getString('acessToken');
      getEmail = loginData?.getString('email');
    });
    var storedLocations = await isarService.getLocations();
    if (storedLocations.isEmpty) {
      // If not, fetch and store the locations
      await fetchLocations(getAccessToken!);
    }

    // var locations = await fetchLocations(accessToken!);
    // locations
    // if (locationApiModel != null) {
    //   fetchLocations(accessToken!);
    // }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
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
          email: getEmail ?? "",
          loginData: loginData,
        ),
      ),
      body: Stack(
        children: [
          Padding(
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
                      text: "user",
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
                    border: Border.all(
                      color: Color.fromARGB(255, 85, 138, 182),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/emptyprofile.png",
                          height: 80,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppUText(
                              text: firstCheckInTime == null
                                  ? "Check-In to start\n your day"
                                  : "",
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 10, left: 5),
                              child: Text(
                                "Today's Activities",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: checkEvents.length,
                                itemBuilder: (context, index) {
                                  final event = checkEvents[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: CheckInContainer(
                                      usedInMyActivities: false,
                                      indicatorColor: event.type == 1
                                          ? Color.fromARGB(255, 190, 235, 192)
                                          : const Color.fromARGB(
                                              255, 228, 168, 164),
                                      time: DateFormat('hh:mm a')
                                          .format(DateTime.parse(event.time)),
                                      status: event.type == 1
                                          ? "check-in"
                                          : "check-out",
                                      location: event.locationName,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lastActivity == 1
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
                          isLoading = true;
                        });
                        // var locationData = await getCurrentLocation(context);
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
                          lastActivity == 1
                              ? checkInType = 2
                              : checkInType =
                                  1; // Set checkInType based on isChekin
                          LocationService locationService = LocationService();

                          Map<String, dynamic>? positonData =
                              await locationService.getCurrentLocation(context);
                          if (positonData != null) {
                            Navigator.pop(context);
                            setState(() {
                              isLoading = false;
                            });
                            print("the position data is :${positonData}");
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeView(
                                locationId: positonData['id'],
                                locationName: positonData['name'],
                                lat: positonData['lat'],
                                long: positonData['long'],
                                acessToken: getAccessToken,
                                type: checkInType,
                              );
                            }));
                          } else {
                            print("the position data is :${positonData}");
                            OutOfRadiusDialog();
                          }
                        } catch (e) {
                          print("the error is :${e}");
                        }
                      } else if (location.isDenied) {
                        print("Denied");
                      } else {
                        DialogUtils.showPermissionDeniedDialog(
                            context, "Location");
                      }
                    },
                    child: AppUText(
                      text: lastActivity == 1 ? "Check Out" : "Check In",
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          if (widget.isActivityAdded == true)
            InkWell(
              onTap: () {
                setState(() {
                  widget.isActivityAdded = false;
                });
              },
              child: lastActivity == 1
                  ? CustomSucessDialog()
                  : CustomFailedDialog(),
            )
          else
            Container(),
        ],
      ),
    );
  }

// Create a global IsarService instance
  IsarService isarService = IsarService();

  Future<void> fetchLocations(String acessToken) async {
    print("fetching locations");

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
  }

  // _getActivities() {
  //   isarService.getActivities().listen((value) {
  //     setState(() {
  //       checkEvents = value;
  //       var lastActivityInfo = value.last;
  //       lastActivity = lastActivityInfo.type;
  //       var firstCheckIn = value.first;
  //       firstCheckInTime = DateTime.parse(firstCheckIn.time);
  //       print("the first check in time is nnnnnn :${firstCheckInTime}");

  //       // Start or reset the timer here
  //       if (widget.isCheckingIn == true) {
  //         startTimer();
  //       } else if (widget.isCheckingOut == true) {
  //         resetTimer();
  //       }
  //     });
  //   });
  // }
  _getActivities() {
    isarService.getActivities().listen((value) {
      setState(() {
        // Filter the activities by the specific date
        checkEvents = value.where((activity) {
          return activity.time.startsWith(currentDay) &&
              activity.userId == getEmail;
        }).toList();

        if (checkEvents.isNotEmpty) {
          var lastActivityInfo = checkEvents.last;
          lastActivity = lastActivityInfo.type;
          print("the last activity is from act :${lastActivityInfo.type}");
          var firstCheckIn = checkEvents.first;
          firstCheckInTime = DateTime.parse(firstCheckIn.time);
          print("the first check in time is nnnnnn :${firstCheckInTime}");

          // Start or reset the timer here
          if (widget.isCheckingIn == true || lastActivity == 1) {
            startTimer();
          } else if (widget.isCheckingOut == true || lastActivity == 2) {
            resetTimer();
          }
        }
      });
    });
  }
}
