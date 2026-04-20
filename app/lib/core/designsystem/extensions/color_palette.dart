// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'color_palette.tailor.dart';

@tailorMixinComponent
class ColorPalette extends ThemeExtension<ColorPalette>
    with _$ColorPaletteTailorMixin {
  const ColorPalette({
    required this.brandPrimary,
    required this.brandPrimaryContainer,
    required this.brandSecondary,
    required this.brandTertiary,
    required this.statusSuccess,
    required this.statusWarning,
    required this.statusDanger,
    required this.statusInfo,
  });

  factory ColorPalette.light() => const ColorPalette(
    brandPrimary: Color(0xFF2F6FE4),
    brandPrimaryContainer: Color(0xFFDCE8FF),
    brandSecondary: Color(0xFF5E86D6),
    brandTertiary: Color(0xFF2D8A78),
    statusSuccess: Color(0xFF248A5A),
    statusWarning: Color(0xFFB57900),
    statusDanger: Color(0xFFC54C4C),
    statusInfo: Color(0xFF1D73D8),
  );

  factory ColorPalette.dark() => const ColorPalette(
    brandPrimary: Color(0xFF4D8DFF),
    brandPrimaryContainer: Color(0xFF24344A),
    brandSecondary: Color(0xFF8FB7FF),
    brandTertiary: Color(0xFF91D4C8),
    statusSuccess: Color(0xFF63D39B),
    statusWarning: Color(0xFFF4C75E),
    statusDanger: Color(0xFFFF7A7A),
    statusInfo: Color(0xFF78B8FF),
  );

  final Color brandPrimary;
  final Color brandPrimaryContainer;
  final Color brandSecondary;
  final Color brandTertiary;
  final Color statusSuccess;
  final Color statusWarning;
  final Color statusDanger;
  final Color statusInfo;
}
