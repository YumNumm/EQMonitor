// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'text_color_theme_extension.tailor.dart';

@tailorMixinComponent
class TextColorThemeExtension extends ThemeExtension<TextColorThemeExtension>
    with _$TextColorThemeExtensionTailorMixin {
  const TextColorThemeExtension({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.inverse,
    required this.onBrand,
  });

  factory TextColorThemeExtension.light() => const TextColorThemeExtension(
    primary: Color(0xFF10151C),
    secondary: Color(0xFF4A5A6D),
    tertiary: Color(0xFF738294),
    inverse: Color(0xFFF5F8FC),
    onBrand: Color(0xFFFFFFFF),
  );

  factory TextColorThemeExtension.dark() => const TextColorThemeExtension(
    primary: Color(0xFFF3F6FA),
    secondary: Color(0xFFC4CCD7),
    tertiary: Color(0xFF98A5B5),
    inverse: Color(0xFF0F141A),
    onBrand: Color(0xFF07121F),
  );

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color inverse;
  final Color onBrand;
}
