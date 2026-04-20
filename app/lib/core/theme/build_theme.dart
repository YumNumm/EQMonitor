import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:eqmonitor/core/theme/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData buildTheme({ColorScheme? colorScheme, CustomColors? customColors}) {
  final resolvedColorScheme =
      colorScheme ??
      const ColorScheme.light().copyWith(
        primary: const Color(0xFF2F6FE4),
      );
  final designSystem = resolvedColorScheme.brightness == Brightness.dark
      ? DesignSystemThemeExtension.dark()
      : DesignSystemThemeExtension.light();
  final color = designSystem.color;
  final textColor = designSystem.textColor;
  final typography = designSystem.typography;
  final shape = designSystem.shape;

  return ThemeData(
    colorScheme: resolvedColorScheme,
    scaffoldBackgroundColor: color.backgroundDefault,
    cardColor: color.surfaceDefault,
    dialogTheme: DialogThemeData(
      backgroundColor: color.surfaceDefault,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: color.surfaceCard,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(shape.card),
      ),
    ),
    extensions: [designSystem, ?customColors],
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: typography.displayLarge,
      displayMedium: typography.displayMedium,
      headlineLarge: typography.headlineLarge,
      headlineMedium: typography.headlineMedium,
      headlineSmall: typography.headlineSmall,
      titleLarge: typography.titleLarge,
      titleMedium: typography.titleMedium,
      titleSmall: typography.titleSmall,
      bodyLarge: typography.bodyLarge,
      bodyMedium: typography.bodyMedium,
      bodySmall: typography.bodySmall,
      labelLarge: typography.labelLarge,
      labelMedium: typography.labelMedium,
      labelSmall: typography.labelSmall,
    ),
    fontFamily: primaryFontFamily,
    fontFamilyFallback: japaneseFontFamilyFallback,
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: resolvedColorScheme.brightness,
      applyThemeToAll: true,
      primaryColor: resolvedColorScheme.primary,
      scaffoldBackgroundColor: color.surfaceDefault,
      barBackgroundColor: color.surfaceDefault,
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      backgroundColor: color.backgroundDefault,
      foregroundColor: textColor.primary,
    ),
    splashFactory: NoSplash.splashFactory,
    // ignore: deprecated_member_use
    sliderTheme: const SliderThemeData(year2023: false),
    // ignore: deprecated_member_use
    progressIndicatorTheme: const ProgressIndicatorThemeData(year2023: false),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(shape.sm),
          ),
        ),
      ),
    ),
  );
}

const String monoFont = codeFontFamily;
