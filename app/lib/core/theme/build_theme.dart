import 'package:eqmonitor/core/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme({
  ColorScheme? colorScheme,
  CustomColors? customColors,
}) {
  final notoSansJp = GoogleFonts.notoSansJp().fontFamily;
  final robotoMono = GoogleFonts.robotoMono().fontFamily;
  return ThemeData(
    colorScheme: colorScheme,
    extensions: [if (customColors != null) customColors],
    useMaterial3: true,
    fontFamily: robotoMono,
    fontFamilyFallback: [
      if (notoSansJp != null) notoSansJp,
    ],
  );
}
