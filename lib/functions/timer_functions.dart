// timer_service.dart

import 'dart:async';

class TimerService {
  DateTime _currentDate = DateTime.now();
  DateTime? firstCheckInTime;
  Duration elapsedTime = Duration();
  Timer? timer;
  double opacityLevel = 1.0;

  void currentDate() {
    _currentDate = DateTime.now();
  }

  void startTimer() {
    DateTime currentTime = DateTime.now();
    if (firstCheckInTime == null) {
      firstCheckInTime = DateTime.now();
      print('First check-in time: $firstCheckInTime');
    } else {
      elapsedTime = currentTime.difference(firstCheckInTime ?? currentTime);
    }
    // Start the timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Update the elapsed time every second
      elapsedTime += Duration(seconds: 1);
      opacityLevel = opacityLevel == 0 ? 1.0 : 0.0; // Toggle the opacity level
    });
  }

  void resetTimer() {
    // Cancel the timer
    timer?.cancel();

    // Reset the elapsed time
    if (firstCheckInTime != null) {
      elapsedTime = DateTime.now().difference(firstCheckInTime!);
    }
    // elapsedTime = Duration();
    opacityLevel = 1.0; // Reset the opacity level
  }

  String getGreeting() {
    var hour = _currentDate.hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
}
