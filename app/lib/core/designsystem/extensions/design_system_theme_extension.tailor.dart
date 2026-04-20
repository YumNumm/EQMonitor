// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'design_system_theme_extension.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$DesignSystemThemeExtensionTailorMixin
    on ThemeExtension<DesignSystemThemeExtension> {
  ColorPalette get palette;
  ColorThemeExtension get color;
  TextColorThemeExtension get textColor;
  SpacingThemeExtension get spacing;
  ShapeThemeExtension get shape;
  TypographyThemeExtension get typography;

  @override
  DesignSystemThemeExtension copyWith({
    ColorPalette? palette,
    ColorThemeExtension? color,
    TextColorThemeExtension? textColor,
    SpacingThemeExtension? spacing,
    ShapeThemeExtension? shape,
    TypographyThemeExtension? typography,
  }) {
    return DesignSystemThemeExtension(
      palette: palette ?? this.palette,
      color: color ?? this.color,
      textColor: textColor ?? this.textColor,
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
    if (other is! DesignSystemThemeExtension)
      return this as DesignSystemThemeExtension;
    return DesignSystemThemeExtension(
      palette: palette.lerp(other.palette, t),
      color: color.lerp(other.color, t),
      textColor: textColor.lerp(other.textColor, t),
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
            const DeepCollectionEquality().equals(palette, other.palette) &&
            const DeepCollectionEquality().equals(color, other.color) &&
            const DeepCollectionEquality().equals(textColor, other.textColor) &&
            const DeepCollectionEquality().equals(spacing, other.spacing) &&
            const DeepCollectionEquality().equals(shape, other.shape) &&
            const DeepCollectionEquality().equals(
              typography,
              other.typography,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(palette),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(textColor),
      const DeepCollectionEquality().hash(spacing),
      const DeepCollectionEquality().hash(shape),
      const DeepCollectionEquality().hash(typography),
    );
  }
}

extension DesignSystemThemeExtensionThemeData on ThemeData {
  DesignSystemThemeExtension get designSystemThemeExtension =>
      extension<DesignSystemThemeExtension>()!;
}
