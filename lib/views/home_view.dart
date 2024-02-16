// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, must_be_immutable, avoid_print, annotate_overrides

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype/constants/color_file.dart';
import 'package:swype/pages/configuration_bottom_sheet.dart';
import 'package:swype/util/permision_denied_dialog.dart';
import 'package:swype/views/face_detector_view.dart';
import 'package:swype/views/painters/camera_view.dart';
import 'package:swype/widgets/app_large_text.dart';
import 'package:swype/widgets/app_text.dart';

class HomeView extends StatefulWidget {
  int? locationId;
  String? acessToken = "";
  double? lat;
  double? long;
  int? type;
  String? locationName;
  HomeView({
    this.locationId,
    this.lat,
    this.long,
    this.type,
    this.acessToken,
    this.locationName,
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool serviceEnabled = false;
  bool cameraPermissionDenied = false;
  bool cameraPermissionRequested = false;
  bool locationPermissionRequested = false;

  // void initState()  {
  //   // await getLoginInfo();
  //   print("the location id is ${widget.locationId}");
  //   print("the acess token is ${widget.acessToken}");

  //   super.initState();
  // }
  @override
  void initState() {
    super.initState();
    print("chlo");
    print("the location id is ${widget.locationId}");
    print("the acess token is ${widget.acessToken}");
    print("the lat is ${widget.lat}");
    print("the long is ${widget.long}");
    print("the type is ${widget.type}");
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      // backgroundColor: Colors.red,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(
            // 20,

            0.0487 * screenWidth,
            // 19,
            0.026 * screenHeight,
            // 20,
            0.0487 * screenWidth,
            0,
          ),
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/fng.svg",
                      // height: 50,
                      // width: 50,

                      height: 0.0681 * screenHeight,
                      width: 0.01217 * screenWidth,
                    ),
                    AppLargeText(
                      text: "Swype",
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        final result = showModalBottomSheet(
                            useSafeArea: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: ConfigurationBottomSheet(),
                              );
                            });
                      },
                      child: SvgPicture.asset(
                        "assets/icons/settings.svg",
                        // height: 24,

                        height: 0.0327 * screenHeight,
                        // width: 24,
                        width: 0.0584 * screenWidth,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 0.003 * screenHeight),
              SizedBox(
                // height: 3,
                height: 0.0041 * screenHeight,
              ),
              Padding(
                padding: EdgeInsets.only(
                  // left: 0.025 * screenWidth,
                  // left: 7,
                  left: 0.0171 * screenWidth,
                ),
                child: AppText(
                  text: "Seamless Attendance Management",
                  // style: TextStyle(
                  //   fontSize: 16,
                  //   fontWeight: FontWeight.w400,
                  // ),
                ),
              ),
              SizedBox(
                // height: 24,

                height: 0.0327 * screenHeight,
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    var status = await Permission.camera.request();
                    if (status.isGranted) {
                      print("Status of Camera is :$status");
                      var location = await Permission.location.request();
                      if (location.isGranted) {
                        setState(() {
                          serviceEnabled = true;

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return FaceDetectorView(
                              serviceEnabled: serviceEnabled,
                              locationId: widget.locationId,
                              acessToken: widget.acessToken,
                              locationName: widget.locationName,
                              lat: widget.lat,
                              long: widget.long,
                              type: widget.type,
                            );
                          }));
                        });
                        //     } else if (location.isDenied) {
                        print("Denied");
                      } else if (location.isPermanentlyDenied) {
                        DialogUtils.showPermissionDeniedDialog(
                            context, "Location");
                      }
                    } else if (status.isDenied) {
                      print("Status of Camera is :$status");
                    } else if (status.isPermanentlyDenied) {
                      DialogUtils.showPermissionDeniedDialog(context, "Camera");
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      // left: 4,
                      left: 0.0099 * screenWidth,
                    ),
                    decoration: BoxDecoration(
                      color: primaryBlueColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            // height: 24,

                            height: 0.0327 * screenHeight,
                          ),
                          AppText(
                            text: "MARK ATTENDANCE",
                            color: buttonTextWhiteColor,
                            // style: GoogleFonts.openSans(
                            //   color: buttonTextWhiteColor,
                            //   fontSize: 15,
                            //   fontWeight: FontWeight.w400,
                            // ),
                          ),
                          Spacer(),
                          // SizedBox(height: 130),

                          SvgPicture.asset(
                            "assets/icons/aronyou.svg",
                            // height: ,
                            height: 0.2 * screenHeight,
                            width: 0.2 * screenWidth,
                          ),

                          // SizedBox(height: 60),
                          Spacer(),
                          AppLargeText(
                            text: "Tap To Launch",
                            fontWeight: FontWeight.w600,
                            color: buttonTextWhiteColor,
                          ),
                          AppLargeText(
                            text: "The Camera",
                            fontWeight: FontWeight.w600,
                            color: buttonTextWhiteColor,
                            // style: GoogleFonts.openSans(
                            //   color: buttonTextWhiteColor,
                            //   fontSize: 32,
                            //   fontWeight: FontWeight.w600,
                            // ),
                          ),

                          SizedBox(
                            // height: 93,
                            height: 0.1268 * screenHeight,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.0327 * screenHeight,
                // height: 24,
              ),
            ],
          ),
        ),
      ),
      // body: Container(
      //   child: ElevatedButton(
      //     onPressed: () async {
      //       var status = await Permission.camera.request();
      //       if (status.isGranted) {
      //         var location = await Permission.location.request();
      //         if (location.isGranted) {
      //           setState(() {
      //             serviceEnabled = true;

      //             Navigator.push(context, MaterialPageRoute(builder: (context) {
      //               return FaceDetectorView(
      //                 serviceEnabled: serviceEnabled,
      //               );
      //             }));
      //           });
      //         } else if (location.isDenied) {
      //           print("Denied");
      //         } else if (location.isPermanentlyDenied) {
      //           DialogUtils.showPermissionDeniedDialog(context, "Location");
      //         }
      //       } else if (status.isDenied) {
      //         print("Status of Camera is :$status");
      //       } else if (status.isPermanentlyDenied) {
      //         DialogUtils.showPermissionDeniedDialog(context, "Camera");
      //       }
      //     },
      //     child: Text("Camera"),
      //   ),
      // ),
    );
  }
}
  // try {
  //                 var location = await Permission.location.request();
  //                 if (location.isGranted) {
  //                   setState(() {
  //                     serviceEnabled = true;
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) => FaceDetectorView(
  //                                 serviceEnabled: serviceEnabled,
  //                               )),
  //                     );

  //                     print(" Service enabled: $serviceEnabled");
  //                   });
  //                 } else if (location.isDenied) {
  //                   showDialog(
  //                     context: context,
  //                     builder: (BuildContext context) {
  //                       return AlertDialog(
  //                         title: Text("Permission Denied"),
  //                         content:
  //                             Text("Please allow to acess device location"),
  //                         actions: [
  //                           TextButton(
  //                             onPressed: () {
  //                               Navigator.of(context).pop(); // Close the dialog
  //                             },
  //                             child: Text("Cancel"),
  //                           ),
  //                           TextButton(
  //                             onPressed: () {
  //                               Navigator.of(context).pop(); // Close the dialog
  //                               openAppSettings(); // Open app settings to allow the user to grant permission
  //                             },
  //                             child: Text("Settings"),
  //                           ),
  //                         ],
  //                       );
  //                     },
  //                   );
  //                 }
  //               } catch (e) {}
  //             }



//  showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text("Permission Denied"),
//                             content:
//                                 Text("Please allow to acess device location"),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context)
//                                       .pop(); // Close the dialog
//                                 },
//                                 child: Text("Cancel"),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context)
//                                       .pop(); // Close the dialog
//                                   openAppSettings(); // Open app settings to allow the user to grant permission
//                                 },
//                                 child: Text("Settings"),
//                               ),
//                             ],
//                           );
//                         },
//                       );


//  try {
//                     if (cameraPermissionDenied == false &&
//                         locationPermissionRequested == false) {
//                       var location = await Permission.location.request();
//                       if (location.isGranted) {
//                         setState(() {
//                           serviceEnabled = true;
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => FaceDetectorView(
//                                       serviceEnabled: serviceEnabled,
//                                     )),
//                           );

//                           print(" Service enabled: $serviceEnabled");
//                         });
//                       } else {
//                         setState(() {
//                           locationPermissionRequested = true;
//                         });
//                       }
//                     } else if (locationPermissionRequested == true &&
//                         cameraPermissionDenied == false) {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text("Permission Denied"),
//                             content:
//                                 Text("Please allow to acess device location"),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context)
//                                       .pop(); // Close the dialog
//                                 },
//                                 child: Text("Cancel"),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context)
//                                       .pop(); // Close the dialog
//                                   openAppSettings(); // Open app settings to allow the user to grant permission
//                                 },
//                                 child: Text("Settings"),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     }
//                   } catch (e) {}
