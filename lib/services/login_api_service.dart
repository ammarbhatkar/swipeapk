import 'dart:convert';
import 'dart:math';

import 'package:swype/isar_collections/location_collection.dart';
import 'package:swype/isar_services/isar_service.dart';
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
        Uri.parse('$baseUrl/api/login'),
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
    final response = await http
        .post(Uri.parse('$baseUrl/api/location/fetch_mobile'), headers: {
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
      String acessToken, String locationId, String base64ImageString) async {
    print("Chekin Api Called");
    final response = await http.post(
      Uri.parse("$baseUrl/api/front/staff_via_image"),
      headers: {
        'Authorization': 'Bearer $acessToken',
      },
      body: {
        'locationId': locationId,
        'image': base64ImageString,
      },
    );
    print("the response code for checkin api is :${response.statusCode}");
    if (response.statusCode == 200) {
      return CheckInApiModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<CheckoutApiModel> checkoutApi(
      String userId, String locationId, String exitReason) async {
    print("checkoutApi called");
    final response = await http.post(
      Uri.parse(
          'https://af66-2402-3a80-10c4-d748-4401-ad5f-f7ed-f0a8.ngrok-free.app/api/front/staff_check_out_via_face'),
      body: {
        'user_id': userId,
        'location_id': locationId,
        'exit_reason': exitReason,
      },
    );
    print("the response code for checkout api is :${response.statusCode}");
    if (response.statusCode == 200) {
      return CheckoutApiModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }
}
