import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/shape_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/spacing_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';

ThemeData buildTheme({
  required ThemeColorSet colorSet,
  required Brightness brightness,
}) {
  final colorScheme = colorSet.toColorScheme(brightness);
  final spacing = SpacingThemeExtension.standard();
  final shape = ShapeThemeExtension.standard();
  final typography = TypographyThemeExtension.fromColorTheme(colorSet);

  final designSystem = DesignSystemThemeExtension(
    colorTheme: colorSet,
    spacing: spacing,
    shape: shape,
    typography: typography,
  );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorSet.surfaceContainerLow,
    cardColor: colorSet.surface,
    dialogTheme: DialogThemeData(
      backgroundColor: colorSet.surface,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: colorSet.surfaceContainerHigh,
      surfaceTintColor: Colors.transparent,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
      ),
    ),
    extensions: [designSystem],
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
      brightness: brightness,
      applyThemeToAll: true,
      primaryColor: colorSet.primary,
      scaffoldBackgroundColor: colorSet.surface,
      barBackgroundColor: colorSet.surface,
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      backgroundColor: colorSet.surfaceContainerLow,
      foregroundColor: colorSet.onSurface,
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
          RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(shape.sm),
          ),
        ),
      ),
    ),
  );
}
