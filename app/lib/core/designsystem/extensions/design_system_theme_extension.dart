import 'package:eqmonitor/core/designsystem/extensions/shape_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/spacing_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:flutter/material.dart';

@immutable
class DesignSystemThemeExtension
    extends ThemeExtension<DesignSystemThemeExtension> {
  const DesignSystemThemeExtension({
    required this.colorTheme,
    required this.spacing,
    required this.shape,
    required this.typography,
  });

  final ThemeColorSet colorTheme;
  final SpacingThemeExtension spacing;
  final ShapeThemeExtension shape;
  final TypographyThemeExtension typography;

  @override
  DesignSystemThemeExtension copyWith({
    ThemeColorSet? colorTheme,
    SpacingThemeExtension? spacing,
    ShapeThemeExtension? shape,
    TypographyThemeExtension? typography,
  }) {
    return DesignSystemThemeExtension(
      colorTheme: colorTheme ?? this.colorTheme,
      spacing: spacing ?? this.spacing,
      shape: shape ?? this.shape,
      typography: typography ?? this.typography,
    );
  }

  @override
  DesignSystemThemeExtension lerp(
    covariant ThemeExtension<DesignSystemThemeExtension>? other,
    double t,
  ) {
    if (other is! DesignSystemThemeExtension) {
      return this;
    }
    return DesignSystemThemeExtension(
      // ThemeColorSet is a Freezed class with no lerp — snap to target
      colorTheme: t < 0.5 ? colorTheme : other.colorTheme,
      spacing: spacing.lerp(other.spacing, t),
      shape: shape.lerp(other.shape, t),
      typography: typography.lerp(other.typography, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DesignSystemThemeExtension &&
            colorTheme == other.colorTheme &&
            spacing == other.spacing &&
            shape == other.shape &&
            typography == other.typography);
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        colorTheme,
        spacing,
        shape,
        typography,
      );

  static DesignSystemThemeExtension? of(BuildContext context) {
    return Theme.of(context).extension<DesignSystemThemeExtension>();
  }
}
