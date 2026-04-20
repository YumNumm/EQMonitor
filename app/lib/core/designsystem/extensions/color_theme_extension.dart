// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'color_theme_extension.tailor.dart';

@tailorMixinComponent
class ColorThemeExtension extends ThemeExtension<ColorThemeExtension>
    with _$ColorThemeExtensionTailorMixin {
  const ColorThemeExtension({
    required this.backgroundDefault,
    required this.backgroundSubtle,
    required this.surfaceDefault,
    required this.surfaceRaised,
    required this.surfaceCard,
    required this.surfaceEmphasis,
    required this.outlineSoft,
    required this.outlineStrong,
  });

  factory ColorThemeExtension.light() => const ColorThemeExtension(
    backgroundDefault: Color(0xFFF5F8FC),
    backgroundSubtle: Color(0xFFEDF3F9),
    surfaceDefault: Color(0xFFFFFFFF),
    surfaceRaised: Color(0xFFF3F6FA),
    surfaceCard: Color(0xFFEAF0F7),
    surfaceEmphasis: Color(0xFFD9E6F7),
    outlineSoft: Color(0xFFD3DDE8),
    outlineStrong: Color(0xFF95A7BC),
  );

  factory ColorThemeExtension.dark() => const ColorThemeExtension(
    backgroundDefault: Color(0xFF0F141A),
    backgroundSubtle: Color(0xFF131A21),
    surfaceDefault: Color(0xFF171E26),
    surfaceRaised: Color(0xFF1D2630),
    surfaceCard: Color(0xFF232D38),
    surfaceEmphasis: Color(0xFF2B3744),
    outlineSoft: Color(0xFF3A4654),
    outlineStrong: Color(0xFF506073),
  );

  final Color backgroundDefault;
  final Color backgroundSubtle;
  final Color surfaceDefault;
  final Color surfaceRaised;
  final Color surfaceCard;
  final Color surfaceEmphasis;
  final Color outlineSoft;
  final Color outlineStrong;
}
