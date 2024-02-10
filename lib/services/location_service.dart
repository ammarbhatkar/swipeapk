import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:swype/isar_services/isar_service.dart';
import 'package:swype/views/new_home.dart';

// Future<dynamic?> getCurrentLocation(BuildContext context) async {
Future<Map<String, dynamic>?> getCurrentLocation(BuildContext context) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (serviceEnabled == false) {
    return Future.error("Enable Location");
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
      // return location.id;

      print('Location ID: ${location.id}, Location Name: ${location.name}');
      return {'id': location.id, 'name': location.name};

      // print('Getting current location...');
      // // ...
      // // print('Got current position: $position');
      // // ...
      // // print('Got locations from database: $locations');
      // // ...
      // // print('Checking location: ${location.id}');

      // print('Distance to location: $distanceInMeters');
    }
  }

  // double distanceInMeters = Geolocator.distanceBetween(
  //     position.latitude, position.longitude, 18.9545289, 72.8164965);
  // print("Distance in meters : ${distanceInMeters}");
  // print("Latitude value : ${position.latitude}");
  // print("Longitude value : ${position.longitude}");
  // print("the current position is : $position  ");
  // return position;?
  return null;
}
