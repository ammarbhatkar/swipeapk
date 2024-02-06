// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swype/widgets/app_large_text.dart';
import 'package:swype/widgets/app_text.dart';
import 'package:swype/widgets/credentials_text_field.dart';
import 'package:swype/widgets/login_button.dart';

class ConfigurationBottomSheet extends StatefulWidget {
  const ConfigurationBottomSheet({super.key});

  @override
  State<ConfigurationBottomSheet> createState() =>
      _ConfigurationBottomSheetState();
}

class _ConfigurationBottomSheetState extends State<ConfigurationBottomSheet> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          // color: Colors.amber,
          ),
      child: Padding(
        padding: EdgeInsets.only(
          // top: 40,
          top: screenHeight * 0.0545,
          // left: 24,
          left: screenWidth * 0.0584,
          // right: 23,
          right: screenWidth * 0.056,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppLargeText(text: "Authenticate"),
            SizedBox(
              // height: 8,
              height: screenHeight * 0.0109,
            ),
            AppText(
                text:
                    "Enter the password to authenticate and continue to settings page..."),
            SizedBox(
              // height: 24,

              height: 0.0327 * screenHeight,
            ),
            CustomCredentialTextField(
                controller: _password, hintText: "Password"),
            SizedBox(
              // height: 24,

              height: 0.0327 * screenHeight,
            ),
            LoginButton(text: "CONTINUE")
          ],
        ),
      ),
    );
  }
}
