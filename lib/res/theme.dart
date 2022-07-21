import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'color.dart';

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.grey[900],
    useMaterial3: true,
    colorScheme: const ColorScheme.dark().copyWith(),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.blue,
      secondary: Colors.blue,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Colors.red,
      onError: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
    ),
    primaryColor: materialWhite,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );
}

bool isDarkmodeOnSystem() =>
    SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
