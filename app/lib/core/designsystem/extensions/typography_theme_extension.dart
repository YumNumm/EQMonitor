// ignore_for_file: annotate_overrides

import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'typography_theme_extension.tailor.dart';

const String primaryFontFamily = FontFamily.googleSansFlex;
const String codeFontFamily = FontFamily.googleSansCode;
const japaneseFontFamilyFallback = <String>[FontFamily.notoSansJP];

@tailorMixinComponent
class TypographyThemeExtension extends ThemeExtension<TypographyThemeExtension>
    with _$TypographyThemeExtensionTailorMixin {
  const TypographyThemeExtension({
    required this.displayLarge,
    required this.displayMedium,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.monoLarge,
    required this.monoMedium,
    required this.monoSmall,
  });

  factory TypographyThemeExtension.fromColorTheme(ThemeColorSet colorTheme) =>
      TypographyThemeExtension._base(colorTheme);

  factory TypographyThemeExtension._base(ThemeColorSet colorTheme) {
    return TypographyThemeExtension(
      displayLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 40,
        height: 48 / 40,
        fontWeight: FontWeight.w600,
        color: colorTheme.onSurface,
      ),
      displayMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 36,
        height: 44 / 36,
        fontWeight: FontWeight.w600,
        color: colorTheme.onSurface,
      ),
      headlineLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 32,
        height: 40 / 32,
        fontWeight: FontWeight.w600,
        color: colorTheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 28,
        height: 36 / 28,
        fontWeight: FontWeight.w600,
        color: colorTheme.onSurface,
      ),
      headlineSmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 24,
        height: 30 / 24,
        fontWeight: FontWeight.w600,
        color: colorTheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 22,
        height: 28 / 22,
        fontWeight: FontWeight.w600,
        color: colorTheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 18,
        height: 24 / 18,
        fontWeight: FontWeight.w600,
        color: colorTheme.onSurface,
      ),
      titleSmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 16,
        height: 22 / 16,
        fontWeight: FontWeight.w600,
        color: colorTheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
        color: colorTheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        color: colorTheme.onSurfaceVariant,
      ),
      bodySmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 13,
        height: 18 / 13,
        fontWeight: FontWeight.w400,
        color: colorTheme.onSurfaceVariant,
      ),
      labelLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        color: colorTheme.onSurface,
      ),
      labelMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        color: colorTheme.onSurfaceVariant,
      ),
      labelSmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 11,
        height: 14 / 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        color: colorTheme.outline,
      ),
      monoLarge: TextStyle(
        fontFamily: codeFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 16,
        height: 22 / 16,
        fontWeight: FontWeight.w500,
        color: colorTheme.onSurface,
      ),
      monoMedium: TextStyle(
        fontFamily: codeFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        color: colorTheme.onSurface,
      ),
      monoSmall: TextStyle(
        fontFamily: codeFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
        color: colorTheme.onSurfaceVariant,
      ),
    );
  }

  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;
  final TextStyle monoLarge;
  final TextStyle monoMedium;
  final TextStyle monoSmall;
}
