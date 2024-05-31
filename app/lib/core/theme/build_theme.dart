import 'package:eqmonitor/core/theme/custom_colors.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme({
  ColorScheme? colorScheme,
  CustomColors? customColors,
}) {
  return ThemeData(
    colorScheme: colorScheme,
    extensions: [if (customColors != null) customColors],
    useMaterial3: true,
    fontFamily: FontFamily.notoSansJP,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        // MEMO(YumNumm): PredictiveBackを使うと、MediaQuery.sizeOf(context)の値が変わるので無効
        // TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),
  );
}

final monoFont = GoogleFonts.fragmentMono().fontFamily;
