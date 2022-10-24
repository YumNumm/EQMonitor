import 'package:flutter/material.dart';

ThemeData darkTheme(ColorScheme? darkColorScheme) => ThemeData.dark().copyWith(
      scaffoldBackgroundColor: darkColorScheme?.background ?? Colors.grey[900],
      useMaterial3: true,
      canvasColor: darkColorScheme?.background ?? Colors.grey[900],
      toggleableActiveColor: darkColorScheme?.primary,
      colorScheme: darkColorScheme ??
          ColorScheme.fromSeed(
            seedColor: Colors.blueAccent,
            brightness: Brightness.dark,
          ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
    );

ThemeData lightTheme(ColorScheme? lightColorScheme) =>
    ThemeData.light().copyWith(
      scaffoldBackgroundColor: lightColorScheme?.background ?? Colors.white,
      useMaterial3: true,
      canvasColor: lightColorScheme?.background ?? Colors.white,
      toggleableActiveColor: lightColorScheme?.primary,
      colorScheme: lightColorScheme ??
          ColorScheme.fromSeed(
            seedColor: Colors.blueAccent,
          ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
    );
