import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/theme/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme({ColorScheme? colorScheme, CustomColors? customColors}) {
  return ThemeData(
    colorScheme: colorScheme,
    extensions: [if (customColors != null) customColors],
    useMaterial3: true,
    fontFamily: FontFamily.notoSansJP,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        // TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: colorScheme?.brightness,
      applyThemeToAll: true,
      primaryColor: colorScheme?.primary,
      scaffoldBackgroundColor: colorScheme?.surface,
      barBackgroundColor: colorScheme?.surface,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
    ),
    splashFactory: NoSplash.splashFactory,
  );
}

final monoFont = GoogleFonts.fragmentMono().fontFamily;
