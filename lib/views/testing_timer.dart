// import 'dart:async';

// import 'package:flutter/material.dart';

// class TestingTimer extends StatefulWidget {
//   @override
//   _TestingTimerState createState() => _TestingTimerState();
// }

// class _TestingTimerState extends State<TestingTimer> {
//   bool _isTimerRunning = false;
//   int _seconds = 0;
//   late Timer _timer;

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _seconds++;
//       });
//     });
//   }

//   void _pauseTimer() {
//     _timer.cancel();
//   }

//   void _toggleTimer() {
//     if (_isTimerRunning) {
//       _pauseTimer();
//     } else {
//       _startTimer();
//     }
//     setState(() {
//       _isTimerRunning = !_isTimerRunning;
//     });
//   }

//   String _formatTime(int seconds) {
//     int hours = seconds ~/ 3600;
//     int minutes = (seconds % 3600) ~/ 60;
//     int remainingSeconds = seconds % 60;
//     return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Testing Timer'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Time: ${_formatTime(_seconds)}',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _toggleTimer,
//               child: Text(_isTimerRunning ? 'Pause Timer' : 'Start Timer'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// _getActivities() {
//   isarService.getActivities().listen((value) {
//     if (mounted) {
//       setState(() {
//         // Filter the activities by the specific date
//         checkEvents = value.where((activity) {
//           return activity.time.startsWith(currentDay) &&
//               activity.userId == getEmail;
//         }).toList();

//         if (checkEvents.isNotEmpty) {
//           var lastActivityInfo = checkEvents.last;
//           lastActivity = lastActivityInfo.type;
//           print("the last activity is from act :${lastActivityInfo.type}");
//           var firstCheckIn = checkEvents.first;
//           firstCheckInTime = DateTime.parse(firstCheckIn.time);
//           print("the first check in time is nnnnnn :${firstCheckInTime}");

//           // Calculate the total check-in time
//           Duration totalCheckInTime = Duration();
//           DateTime? lastCheckInTime;
//           for (var activity in checkEvents) {
//             if (activity.type == 1) {
//               // Check-in
//               lastCheckInTime = DateTime.parse(activity.time);
//             } else if (activity.type == 2 && lastCheckInTime != null) {
//               // Check-out
//               totalCheckInTime +=
//                   DateTime.parse(activity.time).difference(lastCheckInTime);
//               lastCheckInTime = null;
//             }
//           }
//           setState(() {
//             getTotalCheckInTime = totalCheckInTime;
//           });
//           print(
//               "Total check-in time: ${totalCheckInTime.inHours} hours and ${totalCheckInTime.inMinutes % 60} minutes");

//           // Start or reset the timer here
//           if (widget.isCheckingIn == true || lastActivity == 1) {
//             startTimer();
//           } else if (widget.isCheckingOut == true || lastActivity == 2) {
//             resetTimer();
//           }
//         }
//       });
//     }
//   });
// }

// void startTimer() {
//   DateTime currentTime = DateTime.now();

//   print("the total check in time from check-- IN is :${getTotalCheckInTime}");
//   if (getTotalCheckInTime != null) {
//     elapsedTime = getTotalCheckInTime;
//   }
//   // Start the timer
//   timer = Timer.periodic(Duration(seconds: 1), (timer) {
//     // Update the elapsed time every second
//     if (mounted) {
//       setState(() {
//         elapsedTime += Duration(seconds: 1);
//         opacityLevel =
//             opacityLevel == 0 ? 1.0 : 0.0; // Toggle the opacity level
//       });
//     }
//   });
// }

// void resetTimer() {
//   // Cancel the timer
//   timer?.cancel();

//   // Reset the elapsed time
//   if (mounted) {
//     setState(() {
//       print("the total check in time from checkout is :${getTotalCheckInTime}");
//       if (getTotalCheckInTime != null) {
//         elapsedTime = getTotalCheckInTime;
//       }
//       opacityLevel = 1.0; // Reset the opacity level
//     });
//   }
// }
