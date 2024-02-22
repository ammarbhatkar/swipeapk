// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print, empty_catches, unnecessary_brace_in_string_interps, unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype/constants/color_file.dart';
import 'package:swype/isar_services/isar_service.dart';
import 'package:swype/models/geo_fence_model.dart';
import 'package:swype/models/login_api_model.dart';
import 'package:swype/models/show_activity_model.dart';
import 'package:swype/pages/configuration_view.dart';
import 'package:swype/services/api_services.dart';
import 'package:swype/views/home_view.dart';
import 'package:swype/views/new_home.dart';
import 'package:swype/widgets/app_large_text.dart';
import 'package:swype/widgets/app_text.dart';
import 'package:swype/widgets/credentials_text_field.dart';
import 'package:swype/widgets/login_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final ApiServices loginService = ApiServices();
  bool isLoading = false;
  bool isGranted = false;
  String acessToken = "";

  //create insatmce of sharedprefrence
  // SharedPreferences? loginData;

  // //create bool to check if the user is new
  // bool? newUser;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    log("new swipe apk");
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void login() async {
    setState(() {
      isLoading = true;
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
    print("login called");
    String email = _email.text;
    String password = _password.text;
    try {
      LoginApiModel response = await loginService.loginApi(email, password);
      print("the email is $email");
      print("the password is $password");

      print("the reponse of api is $response");

      // if login is sucessfull call teh api fetch activities.
      if (response.success == 'true') {
        String accessToken = response.accessToken ?? "";
        await fetchActivities(accessToken, email);
        setState(() {
          if (isLoading) {
            Navigator.pop(context);
            setState(() {
              isLoading = false;
            });
          }
        });
        setState(() {
          acessToken = accessToken;
        });

        if (email != "" && password != "") {
          print("Email and password are not null");
          print("The acess token is $acessToken");
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('email', email);
          sharedPreferences.setString('acessToken', accessToken);

          // loginData?.setBool('login', false);
          // loginData?.setString('acessToken', accessToken);
          // loginData?.setString('email', email);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NewHomeView(),
            ),
          );
        }
        // await saveLoginInfo(email, accessToken);
        // await printLoginInfo();

        // Save the access token for future use
        // Navigate to the next screen
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ConfigurationView(
        //       acessToken: accessToken,
        //     ),
        //   ),
        // );

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => NewHomeView(
        //       email: email,
        //       // acessToken: accessToken,
        //     ),
        //   ),
        // );
      } else {
        print("Invalid credentials");
        print(response);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text("Login failed. Please check your credentials."),
        //     duration: Duration(seconds: 2),
        //   ),
        // );

        // Handle login failure
      }
    } catch (e) {
      print("the error is $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryBlueColor,
          content: Text(
            "Login failed. Please check your credentials !",
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 0.03893 * MediaQuery.of(context).size.width,
            ),
          ),
          duration: Duration(seconds: 2),
        ),
      );

      // Handle error
    } finally {
      if (isLoading) {
        Navigator.pop(context);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Future<void> saveLoginInfo(String email, String acessToken) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('email', email);
  //   await prefs.setString('acessToken', acessToken);
  // }

  // Future<void> printLoginInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String? accessToken = prefs.getString('acessToken');
  //   String? email = prefs.getString('email');
  //   print('Email from sppp: $email');
  //   print('Access Tokenfrom sppp: $accessToken');
  // }
  Future<void> fetchActivities(String acessToken, String email) async {
    ApiServices apiService = ApiServices();
    IsarService isarService = IsarService();
    print("fetch activities from home callled");
    DateTime now = DateTime.now();
    DateTime monthDate = DateTime(now.year, now.month - 1, now.day);
    String endDate = DateFormat('yyyy-MM-dd').format(now);
    String startDate = DateFormat('yyyy-MM-dd').format(monthDate);

    ShowActivityModel response =
        await apiService.fetchActivities(acessToken, startDate, endDate);
    if (response.activities != null) {
      print("the response of fetch activity is :${response.activities}");
      print(response.activities?.length);
      // print(response.activities?[0].locationId);
      for (var obj in response.activities!) {
        await isarService.addActivityToIsar(
          // userId,
          email,
          // locationName,
          obj.locationName ?? "",
          obj.locationId.toString(),
          obj.type!,
          obj.timestamp!,
        );
      }
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NewHomeView(),
      ),
    );
  }

  Future<void> getUserInfoApi(String accessToken) async {
    print("calling  user info api from fiel ");
    ApiServices apiServices = ApiServices();
    try {
      GeoFenceModel response = await apiServices.fetchUserInfo(acessToken);
      if (response != null) {
        print("the response of fetch user info is :${response}");
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print("height: $height");
    print("width: $width");
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(
            // 19,
            0.04623 * width,
            // 20,
            0.0273 * height,
            0,
            0,
          ),
          // color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.amber,
                child: Row(
                  //  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/fng.svg",
                      height: 0.0681 * height,
                      width: 0.01217 * width,
                    ),
                    AppLargeText(text: "Swype")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: AppText(text: "Seamless Attendance Management"),
              ),
              SizedBox(
                // height: 67,
                height: 0.0913 * height,
              ),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                // color: Colors.red,
                margin: EdgeInsets.only(
                  // left: 5,
                  // right:20,
                  left: 0.0122 * width,
                  right: 0.0487 * height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppLargeText(text: "Login..."),
                    SizedBox(
                      // height: 44,
                      height: 0.06 * height,
                    ),
                    CustomCredentialTextField(
                        controller: _email, hintText: "Email"),
                    SizedBox(
                      // height: 24,
                      height: 0.0327 * height,
                    ),
                    CustomCredentialTextField(
                      controller: _password,
                      hintText: "Password",
                      obsecureText: true,
                    ),
                    SizedBox(
                      // height: 44,
                      height: 0.06 * height,
                    ),
                    InkWell(
                      onTap: () async {
                        login();

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const ConfigurationView(),
                        //   ),
                        // );
                      },
                      child: LoginButton(
                        text: "SIGN IN",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
