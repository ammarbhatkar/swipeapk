// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swype/isar_collections/activity_collection.dart';
import 'package:swype/isar_services/isar_service.dart';
import 'package:swype/components/check_in_container.dart';
import 'package:swype/components/new_text.dart';

class MyActivities extends StatefulWidget {
  const MyActivities({super.key});

  @override
  State<MyActivities> createState() => _MyActivitiesState();
}

class _MyActivitiesState extends State<MyActivities> {
// Create a global IsarService instance
  IsarService isarService = IsarService();

  //create a list of evenets

  List<ActivityCollecion> checkEvents = [];
  int lastActivity = 0;
  int checkInType = 1;
  StreamSubscription? _activitySubscription;

  _getActivities() {
    _activitySubscription = isarService.getActivities().listen((value) {
      if (mounted) {
        setState(() {
          checkEvents = value;
          var lastActivityInfo = value.last;
          lastActivity = lastActivityInfo.type;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getActivities();
  }

  @override
  void dispose() {
    _activitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppUText(
                text: "My Activities",
                color: Theme.of(context).colorScheme.outline,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: checkEvents.isEmpty
                    ? Container(
                        child: Center(
                          child: Text(
                            "No activity for today",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: checkEvents.length,
                        itemBuilder: (context, index) {
                          final event = checkEvents[index];
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: CheckInContainer(
                                usedInMyActivities: true,
                                activityDate: DateFormat("dd").format(
                                  DateTime.parse(checkEvents[index].time),
                                ),
                                activityMonth: DateFormat("MMM").format(
                                  DateTime.parse(checkEvents[index].time),
                                ),
                                // borderColor:

                                indicatorColor: event.type == 1
                                    ? Color.fromARGB(255, 190, 235, 192)
                                    : const Color.fromARGB(255, 228, 168, 164),
                                time: DateFormat('hh:mm a')
                                    .format(DateTime.parse(event.time)),
                                // timeMeridem: "am",
                                // timeMeridem: event.time >= 12 ? "PM" : "AM",
                                status:
                                    event.type == 1 ? "check-in" : "check-out",
                                location: event.locationName,
                              ));
                        },
                      ),
              ),
            ],
          ),
        ), //
      ),
    );
  }
}
