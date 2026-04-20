// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_color_theme_extension.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$TextColorThemeExtensionTailorMixin
    on ThemeExtension<TextColorThemeExtension> {
  Color get primary;
  Color get secondary;
  Color get tertiary;
  Color get inverse;
  Color get onBrand;

  @override
  TextColorThemeExtension copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? inverse,
    Color? onBrand,
  }) {
    return TextColorThemeExtension(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      inverse: inverse ?? this.inverse,
      onBrand: onBrand ?? this.onBrand,
    );
  }

  @override
  TextColorThemeExtension lerp(
    covariant ThemeExtension<TextColorThemeExtension>? other,
    double t,
  ) {
    if (other is! TextColorThemeExtension)
      return this as TextColorThemeExtension;
    return TextColorThemeExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      inverse: Color.lerp(inverse, other.inverse, t)!,
      onBrand: Color.lerp(onBrand, other.onBrand, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextColorThemeExtension &&
            const DeepCollectionEquality().equals(primary, other.primary) &&
            const DeepCollectionEquality().equals(secondary, other.secondary) &&
            const DeepCollectionEquality().equals(tertiary, other.tertiary) &&
            const DeepCollectionEquality().equals(inverse, other.inverse) &&
            const DeepCollectionEquality().equals(onBrand, other.onBrand));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(primary),
      const DeepCollectionEquality().hash(secondary),
      const DeepCollectionEquality().hash(tertiary),
      const DeepCollectionEquality().hash(inverse),
      const DeepCollectionEquality().hash(onBrand),
    );
  }
}
