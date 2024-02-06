// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swype/constants/color_file.dart';
import 'package:swype/views/home_view.dart';
import 'package:swype/widgets/app_large_text.dart';
import 'package:swype/widgets/app_text.dart';
import 'package:swype/widgets/credentials_text_field.dart';
import 'package:swype/widgets/login_button.dart';

class RawLogin extends StatefulWidget {
  const RawLogin({super.key});

  @override
  State<RawLogin> createState() => _RawLoginState();
}

class _RawLoginState extends State<RawLogin> {
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
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(19, 20, 0, 0),
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
                      height: 50,
                      width: 50,
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
                height: 67,
              ),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                // color: Colors.red,
                margin: EdgeInsets.only(left: 5, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppLargeText(text: "Login..."),
                    SizedBox(
                      height: 44,
                    ),
                    CustomCredentialTextField(
                        controller: _email, hintText: "Email"),
                    SizedBox(height: 24),
                    CustomCredentialTextField(
                        controller: _password, hintText: "Password"),
                    SizedBox(height: 44),
                    LoginButton(text: "Sigin"),
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




// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:swype/constants/color_file.dart';
// import 'package:swype/pages/configuration_view.dart';
// import 'package:swype/views/home_view.dart';
// import 'package:swype/widgets/app_large_text.dart';
// import 'package:swype/widgets/app_text.dart';
// import 'package:swype/widgets/credentials_text_field.dart';
// import 'package:swype/widgets/login_button.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   late final TextEditingController _email;
//   late final TextEditingController _password;

//   @override
//   void initState() {
//     _email = TextEditingController();
//     _password = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _email.dispose();
//     _password.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.fromLTRB(
//             // 19, 20, 0, 0,
//             0.04 * screenWidth,
//             0.02 * screenHeight,
//             0,
//             0,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SvgPicture.asset(
//                       "assets/icons/fng.svg",
//                       height: 0.09 * screenHeight,
//                       width: 0.09 * screenWidth,
//                     ),
//                     AppLargeText(
//                       text: "Swype",
//                     )
//                   ],
//                 ),
//               ),
//               // SizedBox(height: 0.003 * screenHeight),
//               SizedBox(height: 3),
//               Padding(
//                 padding: EdgeInsets.only(left: 0.025 * screenWidth),
//                 child: AppText(text: "Seamless Attendance Management"),
//               ),
//               SizedBox(
//                 height: 0.1 * screenHeight,
//               ),
//               Container(
//                 margin: EdgeInsets.only(
//                     left: 0.025 * screenWidth, right: 0.05 * screenWidth),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AppLargeText(text: "Login..."),
//                     SizedBox(
//                       height: 0.052 * screenHeight,
//                     ),
//                     CustomCredentialTextField(
//                         controller: _email, hintText: "Email"),
//                     SizedBox(height: 0.03 * screenHeight),
//                     CustomCredentialTextField(
//                         controller: _password, hintText: "Password"),
//                     SizedBox(height: 0.05 * screenHeight),
//                     InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ConfigurationView()));
//                         },
//                         child: LoginButton(text: "Sigin")),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// =============================================================================================================


// Gesture detctor dropdown of country 

// =============================================================================================================


     // GestureDetector(
                      //   onTap: () async {
                      //     print("textfield tapped");
                      //     final locationApiModel =
                      //         await apiService.locationApi(widget.acessToken);
                      //     showDialog(
                      //       context: context,
                      //       builder: (context) {
                      //         return AlertDialog(
                      //           content: Container(
                      //             width: double.maxFinite,
                      //             child: ListView.builder(
                      //               shrinkWrap: true,
                      //               itemCount:
                      //                   locationApiModel.locations?.length ?? 0,
                      //               itemBuilder: (context, index) {
                      //                 var locationId =
                      //                     locationApiModel.locations![index].id;
                      //                 print("the location id is $locationId");
                      //                 return ListTile(
                      //                   title: Text(locationApiModel
                      //                       .locations![index].name!),
                      //                   onTap: () {
                      //                     setState(() {
                      //                       _selectedLocation = locationApiModel
                      //                           .locations![index].name!;
                      //                       print(
                      //                           "the selected location is $locationId");
                      //                     });
                      //                     Navigator.of(context).pop();
                      //                   },
                      //                 );
                      //               },
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //     );
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(
                      //       horizontal: 0.0486 * width, // 5% of screen width
                      //       vertical: 0.0136 * height,
                      //     ),
                      //     // padding: EdgeInsets.all(8.0),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: primaryBlueColor,
                      //         width: 1,
                      //       ),
                      //       borderRadius: BorderRadius.circular(5.0),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           _selectedLocation ?? "Select Location",
                      //           style: GoogleFonts.openSans(
                      //             fontSize: 0.0389 * width,
                      //             fontWeight: FontWeight.w600,
                      //             color: textFieldColor,
                      //           ),
                      //         ),
                      //         Icon(
                      //           Icons.arrow_drop_down,
                      //           size: 0.0389 * width,
                      //           color: textFieldColor,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),