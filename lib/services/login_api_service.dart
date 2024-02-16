// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:swype/isar_services/isar_service.dart';
import 'package:swype/models/add_activity.dart';
import 'package:swype/models/check_in_model.dart';
import 'package:swype/models/check_out_api_model.dart';
import 'package:swype/models/location_api_model.dart';
import 'package:swype/models/login_api_model.dart';

import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl = "https://ckfoods.swypeuat.co.uk";
  // LoginService({required this.baseUrl});

  Future<LoginApiModel> loginApi(String email, String password) async {
    print("loginApi called");
    print("the email is $email");
    print("the password is $password");
    final response = await http.post(
        // Uri.parse(
        //   'https://ckfoods.swypeuat.co.uk/api/login',
        // ),
        Uri.parse('https://ckfoods.swypeuat.co.uk/api/login'),
        body: {'email': email, 'password': password});
    print("${response.statusCode}");
    if (response.statusCode == 200) {
      print("the response is ${response.body}");
      print("the response status code is ${response.statusCode}");
      return LoginApiModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<LocationApiModel> locationApi(String acessToken) async {
    print("locationApi called");
    final response = await http.post(
        Uri.parse('https://ckfoods.swypeuat.co.uk/api/location/fetch_mobile'),
        headers: {
          'Authorization': 'Bearer $acessToken',
          'Content-Type': 'application/json',
        });

    print("the response code for location api is :${response.statusCode}");
    if (response.statusCode == 200) {
      return LocationApiModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<CheckInApiModel> checkinApi(
    String acessToken,
    int locationId,
    String locationName,
    num lat,
    num long,
    int checkinType,
    String userId,
    String base64ImageString,
  ) async {
    try {
      var params = {
        "locationId": locationId.toString(),
        "lat": lat.toString(),
        "long": long.toString(),
        "type": checkinType.toString(),
        "image": base64ImageString,
      };
      print("params");
      print(params);
      print("Chekin Api Called");
      final response = await http.post(
          Uri.parse("https://ckfoods.swypeuat.co.uk/api/activity/add_mobile"),
          headers: {
            'Authorization': 'Bearer $acessToken',
          },
          body: params);
      print("the response code for checkin api is :${response.statusCode}");
      if (response.statusCode == 200) {
        print("the response is ${response.body}");
        CheckInApiModel chekin = CheckInApiModel.fromJson(
          jsonDecode(response.body),
        );
        print("the checkin response time  is ${chekin.time}");

        var time = chekin.time;
        // Call the addActivityToIsar function
        await IsarService().addActivityToIsar(
          userId,
          locationName,
          locationId.toString(),
          checkinType,
          time!,
        );

        return chekin;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("An error occurred: $e");
      throw e;
    }
  }

  Future<CheckOutApiModel> checkoutApi(
    String acessToken,
    String userId,
    int locationId,
    int exitReason,
    String base64ImageString,
  ) async {
    print("checkoutApi called");
    final response = await http.post(
      Uri.parse(
          'https://ckfoods.swypeuat.co.ukapi/api/front/staff_check_out_via_face'),
      headers: {
        'Authorization': 'Bearer $acessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "userId": userId,
        "locationId": locationId,
        "exitReason": exitReason,
        "image": base64ImageString,
      }),
    );
    print("the response code for checkout api is :${response.statusCode}");
    if (response.statusCode == 200) {
      return CheckOutApiModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<AddActivityModel> addActivityApi(
    String acessToken,
    double userId,
    String date,
    String time,
    int location,
    int type,
  ) async {
    print("addActivityApi called");
    final response = await http.post(
        Uri.parse("https://ckfoods.swypeuat.co.uk/api/activity/add"),
        headers: {
          'Authorization': 'Bearer $acessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "userId": userId,
          "date": date,
          "time": time,
          "location": location,
          "type": type,
        }));
    print("the response code for add activity api is :${response.statusCode}");
    if (response.statusCode == 200) {
      return AddActivityModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
