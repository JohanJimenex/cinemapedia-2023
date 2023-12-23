import 'package:flutter/material.dart';

List<Color> colorsList = [
  Colors.blue,
  Colors.pink,
  Colors.green,
  Colors.yellow,
  Colors.tealAccent,
  Colors.deepPurple
];

class AppTheme {
  AppTheme();

  ThemeData getTheme({int colorIndex = 4, bool darkMode = true}) {
    return ThemeData(
      useMaterial3: true,
      brightness: darkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colorsList[colorIndex],
      // colorScheme: ColorScheme.fromSeed(
      //   seedColor: colorsList[colorIndex],
      //   brightness: darkMode ? Brightness.dark : Brightness.light,
      //   primary: colorsList[colorIndex],
      //   onPrimary: Colors.white,
      //   // secondary: Colors.blue,
      //   onSecondary: Colors.blue,
      // ),
    );
  }
}
