// ignore_for_file: annotate_overrides

import 'package:eqmonitor/core/designsystem/extensions/color_palette.dart';
import 'package:eqmonitor/core/designsystem/extensions/color_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/shape_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/spacing_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/text_color_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'design_system_theme_extension.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class DesignSystemThemeExtension
    extends ThemeExtension<DesignSystemThemeExtension>
    with _$DesignSystemThemeExtensionTailorMixin {
  const DesignSystemThemeExtension({
    required this.palette,
    required this.color,
    required this.textColor,
    required this.spacing,
    required this.shape,
    required this.typography,
  });

  factory DesignSystemThemeExtension.light() {
    final palette = ColorPalette.light();
    final textColor = TextColorThemeExtension.light();
    return DesignSystemThemeExtension(
      palette: palette,
      color: ColorThemeExtension.light(),
      textColor: textColor,
      spacing: SpacingThemeExtension.standard(),
      shape: ShapeThemeExtension.standard(),
      typography: TypographyThemeExtension.light(textColor),
    );
  }

  factory DesignSystemThemeExtension.dark() {
    final palette = ColorPalette.dark();
    final textColor = TextColorThemeExtension.dark();
    return DesignSystemThemeExtension(
      palette: palette,
      color: ColorThemeExtension.dark(),
      textColor: textColor,
      spacing: SpacingThemeExtension.standard(),
      shape: ShapeThemeExtension.standard(),
      typography: TypographyThemeExtension.dark(textColor),
    );
  }

  final ColorPalette palette;
  final ColorThemeExtension color;
  final TextColorThemeExtension textColor;
  final SpacingThemeExtension spacing;
  final ShapeThemeExtension shape;
  final TypographyThemeExtension typography;
}
