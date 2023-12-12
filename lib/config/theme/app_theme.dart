import 'package:flutter/material.dart';

List<Color> colorsList = [
  Colors.blue,
  Colors.pink,
  Colors.green,
  Colors.yellow,
  Colors.tealAccent
];

class AppTheme {
  AppTheme();

  ThemeData getTheme({int colorIndex = 0, bool darkMode = false}) {
    return ThemeData(
        useMaterial3: true,
        brightness: darkMode ? Brightness.dark : Brightness.light,
        colorScheme:
            ColorScheme.fromSeed(seedColor: colorsList[colorIndex]));
  }
}
