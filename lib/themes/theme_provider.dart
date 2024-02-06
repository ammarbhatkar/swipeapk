import 'package:flutter/material.dart';
import 'package:swype/themes/light.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  // bool get isDarkMode => _themeData == darkMode;

  setThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData == lightMode;
      // setThemeData(darkMode);
    } else {
      themeData == lightMode;
    }
  }
}
