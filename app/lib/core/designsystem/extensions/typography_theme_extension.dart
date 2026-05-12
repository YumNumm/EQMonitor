// ignore_for_file: annotate_overrides

import 'package:eqmonitor/core/designsystem/extensions/text_color_theme_extension.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
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

  factory TypographyThemeExtension.light(TextColorThemeExtension textColor) =>
      TypographyThemeExtension._base(textColor);

  factory TypographyThemeExtension.dark(TextColorThemeExtension textColor) =>
      TypographyThemeExtension._base(textColor);

  factory TypographyThemeExtension._base(TextColorThemeExtension textColor) {
    return TypographyThemeExtension(
      displayLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 40,
        height: 48 / 40,
        fontWeight: FontWeight.w600,
        color: textColor.primary,
      ),
      displayMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 36,
        height: 44 / 36,
        fontWeight: FontWeight.w600,
        color: textColor.primary,
      ),
      headlineLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 32,
        height: 40 / 32,
        fontWeight: FontWeight.w600,
        color: textColor.primary,
      ),
      headlineMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 28,
        height: 36 / 28,
        fontWeight: FontWeight.w600,
        color: textColor.primary,
      ),
      headlineSmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 24,
        height: 30 / 24,
        fontWeight: FontWeight.w600,
        color: textColor.primary,
      ),
      titleLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 22,
        height: 28 / 22,
        fontWeight: FontWeight.w600,
        color: textColor.primary,
      ),
      titleMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 18,
        height: 24 / 18,
        fontWeight: FontWeight.w600,
        color: textColor.primary,
      ),
      titleSmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 16,
        height: 22 / 16,
        fontWeight: FontWeight.w600,
        color: textColor.primary,
      ),
      bodyLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
        color: textColor.primary,
      ),
      bodyMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        color: textColor.secondary,
      ),
      bodySmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 13,
        height: 18 / 13,
        fontWeight: FontWeight.w400,
        color: textColor.secondary,
      ),
      labelLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        color: textColor.primary,
      ),
      labelMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        color: textColor.secondary,
      ),
      labelSmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 11,
        height: 14 / 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        color: textColor.tertiary,
      ),
      monoLarge: TextStyle(
        fontFamily: codeFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 16,
        height: 22 / 16,
        fontWeight: FontWeight.w500,
        color: textColor.primary,
      ),
      monoMedium: TextStyle(
        fontFamily: codeFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        color: textColor.primary,
      ),
      monoSmall: TextStyle(
        fontFamily: codeFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
        color: textColor.secondary,
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
