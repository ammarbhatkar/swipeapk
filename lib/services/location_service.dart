import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:swype/isar_services/isar_service.dart';
import 'package:swype/views/new_home.dart';

class LocationService {
  Future<Map<String, dynamic>?> getCurrentLocation(
      BuildContext context, int? isGeoFencingEnabled) async {
    print("locatipn service started");
    log("is geo enabled value from location service : $isGeoFencingEnabled");
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled == false) {
      // return Future.error("Enable Location");
      await Geolocator.openLocationSettings();
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return NewHomeView();
      }));
      return Future.error("Permission denied forever");
    }
    // get current position
    Position position = await Geolocator.getCurrentPosition();

    // get iar instance
    IsarService isarService = await IsarService();

    var locations = await isarService.getLocations();
    Map<String, dynamic>? result;
    for (var location in locations) {
      // Calculate the distance in meters
      double distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        location.lat,
        location.long,
      );

      // If the distance is less than 50 meters, print the location name and id
      if (distanceInMeters < location.radius) {
        print(
            'Location ID wdis less: ${location.locationId}, Location Name: ${location.name}');
        result = {
          'id': location.locationId,
          'name': location.name,
          'lat': location.lat,
          'long': location.long
        };
        break;
      }
    }

    // If no location found within the radius and isGeoFencingEnabled is 0
    if (result == null && isGeoFencingEnabled == 0) {
      var location =
          await isarService.getUnrecogniedLocationFromIsar("unrecognized");
      if (location != null) {
        result = {
          'id': location.locationId,
          'name': location.name,
          'lat': position.latitude,
          'long': position.longitude
        };
      }
      log("teh location is ${location?.locationId}");

      log("teh location is ${location?.name}");

      log("teh location is ${position.latitude}");
      log("teh location is ${position.longitude}");
    }

    return result;
  }
}
// Future<dynamic?> getCurrentLocation(BuildContext context) async {
