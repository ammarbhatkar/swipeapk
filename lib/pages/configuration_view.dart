// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, sort_child_properties_last, avoid_unnecessary_containers, avoid_print, avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swype/constants/color_file.dart';
import 'package:swype/models/location_api_model.dart';
import 'package:swype/services/login_api_service.dart';
import 'package:swype/views/home_view.dart';
import 'package:swype/widgets/app_large_text.dart';
import 'package:swype/widgets/app_text.dart';
import 'package:swype/widgets/credentials_text_field.dart';
import 'package:swype/widgets/login_button.dart';

class ConfigurationView extends StatefulWidget {
  final String acessToken;

  const ConfigurationView({super.key, required this.acessToken});

  @override
  State<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends State<ConfigurationView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  String? _selectedLocation = null;
  bool isLoading = false;
  List listItem = ["one", "two", "three"];
  LocationApiModel? locationApiModel;
  String locationId = "";
  final ApiServices apiService = ApiServices();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
    fetchLocations();
    // fetchAndStoreLocations();
    print("the acess token fromcvfg is ${widget.acessToken}");
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: isLoading
            ? Center(
                child: SpinKitSpinningLines(
                color: primaryBlueColor,
              ))
            : Container(
                padding: EdgeInsets.fromLTRB(
                  // 19,
                  // 20,

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
                            // height: 50,
                            // width: 50,
                          ),
                          AppLargeText(text: "Swype")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        // left: 5,

                        left: 0.0122 * width,
                      ),
                      child: AppText(text: "Seamless Attendance Management"),
                    ),
                    SizedBox(
                      height: 0.0913 * height,
                    ),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      // color: Colors.red,
                      margin: EdgeInsets.only(
                        // left: 5,
                        // right: 20,

                        left: 0.0122 * width,

                        right: 0.0487 * height,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppLargeText(text: "Configure"),
                          SizedBox(
                            // height: 44,

                            height: 0.06 * height,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              // horizontal: 20, vertical: 5,
                              horizontal: 0.0486 * width, // 5% of screen width
                              vertical: 0.0136 * height,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: primaryBlueColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: DropdownButton(
                              padding: EdgeInsets.zero,
                              underline: SizedBox(),
                              isDense: true,
                              hint: Text(
                                'Select Location',
                                style: GoogleFonts.openSans(
                                  fontSize: 0.0389 * width,
                                  fontWeight: FontWeight.w600,
                                  color: textFieldColor,
                                ),
                              ),
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              iconSize: 0.0389 * width,
                              iconDisabledColor: textFieldColor,
                              iconEnabledColor: textFieldColor,
                              value: _selectedLocation,
                              style: GoogleFonts.openSans(
                                fontSize: 0.0389 * width,
                                fontWeight: FontWeight.w600,
                                color: textFieldColor,
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedLocation = newValue.toString();
                                  print(
                                      "the selected location is ${newValue.toString()}");
                                });
                              },

                              items:
                                  locationApiModel?.locations?.map((location) {
                                print("the location is ${location.id}");
                                return DropdownMenuItem(
                                  onTap: () {
                                    setState(() {
                                      locationId = location.id.toString();
                                      print("the location id is $locationId");
                                    });
                                  },
                                  value: location.name,
                                  child: Text(location.name ?? ''),
                                );
                              }).toList(),
                              // items: listItem.map((valueItem) {
                              //   return DropdownMenuItem(
                              //     value: valueItem,
                              //     child: Text(valueItem),
                              //   );
                              // }).toList(),
                            ),
                          ),
                          SizedBox(
                            // height: 24,

                            height: 0.0327 * height,
                          ),
                          CustomCredentialTextField(
                              controller: _password,
                              hintText: "Camera Capture Time"),
                          SizedBox(
                            // height: 44,

                            height: 0.06 * height,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeView(
                                            locationId: locationId,
                                            acessToken: widget.acessToken,
                                          )));
                            },
                            child: LoginButton(text: "SAVE"),
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

  Future<void> fetchLocations() async {
    print("fetching locations");
    setState(() {
      isLoading = true;
    });
    LocationApiModel response = await apiService.locationApi(widget.acessToken);
    // print("teh respomse is ${response.}");
    setState(() {
      locationApiModel = response;
      isLoading = false;
    });
  }
}
