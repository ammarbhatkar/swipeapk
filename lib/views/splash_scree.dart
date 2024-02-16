// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype/components/new_text.dart';
import 'package:swype/views/login_view.dart';
import 'package:swype/views/new_home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finalEmail;
  String? finalAcessToken;
  @override
  void initState() {
    super.initState();
    // Add any initialization logic here
    // For example, you can navigate to another screen after 2 seconds
    getValidationData().whenComplete(() async {
      Future.delayed(Duration(seconds: 2), () {
        // Navigate to another screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                finalEmail != null ? NewHomeView() : LoginView(),
          ),
        );
      });
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    var obtainedAcessToken = sharedPreferences.getString('acessToken');
    setState(() {
      finalEmail = obtainedEmail;
      finalAcessToken = obtainedAcessToken;
    });
    print("finalEmail: $finalEmail");
    print("finalAcessToken: $finalAcessToken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 246, 247, 247),
            ],
            stops: [0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/fng.svg',
                color: const Color.fromARGB(255, 15, 79, 132),
                height: 100,
                width: 100,
              ),
              AppUText(
                  text: "Swype",
                  color: const Color.fromARGB(255, 15, 79, 132),
                  fontSize: 40.0)
            ],
          ),
        ),
      ),
    );
  }
}
