// ignore_for_file: annotate_overrides

import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:material_ui/material_ui.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'typography_theme_extension.tailor.dart';

const String primaryFontFamily = FontFamily.googleSansFlex;
const String codeFontFamily = FontFamily.googleSansCode;
const japaneseFontFamilyFallback = <String>[FontFamily.notoSansJP];

@tailorMixinComponent
class const TypographyThemeExtension({
  required final TextStyle displayLarge,
  required final TextStyle displayMedium,
  required final TextStyle headlineLarge,
  required final TextStyle headlineMedium,
  required final TextStyle headlineSmall,
  required final TextStyle titleLarge,
  required final TextStyle titleMedium,
  required final TextStyle titleSmall,
  required final TextStyle bodyLarge,
  required final TextStyle bodyMedium,
  required final TextStyle bodySmall,
  required final TextStyle labelLarge,
  required final TextStyle labelMedium,
  required final TextStyle labelSmall,
  required final TextStyle monoLarge,
  required final TextStyle monoMedium,
  required final TextStyle monoSmall,
}) extends ThemeExtension<TypographyThemeExtension>
    with _$TypographyThemeExtensionTailorMixin {
  factory fromColorTheme(ThemeColorSet colorTheme) =>
      TypographyThemeExtension._base(colorTheme);

  factory _base(ThemeColorSet colorTheme) {
    return TypographyThemeExtension(
      displayLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 40,
        height: 48 / 40,
        fontWeight: .w600,
        color: colorTheme.onSurface,
      ),
      displayMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 36,
        height: 44 / 36,
        fontWeight: .w600,
        color: colorTheme.onSurface,
      ),
      headlineLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 32,
        height: 40 / 32,
        fontWeight: .w600,
        color: colorTheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 28,
        height: 36 / 28,
        fontWeight: .w600,
        color: colorTheme.onSurface,
      ),
      headlineSmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 24,
        height: 30 / 24,
        fontWeight: .w600,
        color: colorTheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 22,
        height: 28 / 22,
        fontWeight: .w600,
        color: colorTheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 18,
        height: 24 / 18,
        fontWeight: .w600,
        color: colorTheme.onSurface,
      ),
      titleSmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 16,
        height: 22 / 16,
        fontWeight: .w600,
        color: colorTheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 16,
        height: 24 / 16,
        fontWeight: .w400,
        color: colorTheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: .w400,
        color: colorTheme.onSurfaceVariant,
      ),
      bodySmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 13,
        height: 18 / 13,
        fontWeight: .w400,
        color: colorTheme.onSurfaceVariant,
      ),
      labelLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: .w500,
        color: colorTheme.onSurface,
      ),
      labelMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 12,
        height: 16 / 12,
        fontWeight: .w500,
        letterSpacing: 0.2,
        color: colorTheme.onSurfaceVariant,
      ),
      labelSmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 11,
        height: 14 / 11,
        fontWeight: .w500,
        letterSpacing: 0.2,
        color: colorTheme.outline,
      ),
      monoLarge: TextStyle(
        fontFamily: codeFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 16,
        height: 22 / 16,
        fontWeight: .w500,
        color: colorTheme.onSurface,
      ),
      monoMedium: TextStyle(
        fontFamily: codeFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: .w500,
        color: colorTheme.onSurface,
      ),
      monoSmall: TextStyle(
        fontFamily: codeFontFamily,
        fontFamilyFallback: japaneseFontFamilyFallback,
        fontSize: 12,
        height: 16 / 12,
        fontWeight: .w500,
        color: colorTheme.onSurfaceVariant,
      ),
    );
  }
}
