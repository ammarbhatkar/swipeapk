import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade200,
    primaryContainer: Colors.grey.shade600,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Color(0xFF212121),
    outline: Colors.black,
    scrim: Colors.black54,
    inverseSurface: const Color.fromARGB(255, 15, 79, 132),
    onPrimary: Color.fromARGB(255, 40, 113, 173),
    secondaryContainer: Color.fromARGB(255, 190, 36, 25),
  ),
);
