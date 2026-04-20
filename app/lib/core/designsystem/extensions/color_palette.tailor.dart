// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_palette.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ColorPaletteTailorMixin on ThemeExtension<ColorPalette> {
  Color get brandPrimary;
  Color get brandPrimaryContainer;
  Color get brandSecondary;
  Color get brandTertiary;
  Color get statusSuccess;
  Color get statusWarning;
  Color get statusDanger;
  Color get statusInfo;

  @override
  ColorPalette copyWith({
    Color? brandPrimary,
    Color? brandPrimaryContainer,
    Color? brandSecondary,
    Color? brandTertiary,
    Color? statusSuccess,
    Color? statusWarning,
    Color? statusDanger,
    Color? statusInfo,
  }) {
    return ColorPalette(
      brandPrimary: brandPrimary ?? this.brandPrimary,
      brandPrimaryContainer:
          brandPrimaryContainer ?? this.brandPrimaryContainer,
      brandSecondary: brandSecondary ?? this.brandSecondary,
      brandTertiary: brandTertiary ?? this.brandTertiary,
      statusSuccess: statusSuccess ?? this.statusSuccess,
      statusWarning: statusWarning ?? this.statusWarning,
      statusDanger: statusDanger ?? this.statusDanger,
      statusInfo: statusInfo ?? this.statusInfo,
    );
  }

  @override
  ColorPalette lerp(covariant ThemeExtension<ColorPalette>? other, double t) {
    if (other is! ColorPalette) return this as ColorPalette;
    return ColorPalette(
      brandPrimary: Color.lerp(brandPrimary, other.brandPrimary, t)!,
      brandPrimaryContainer: Color.lerp(
        brandPrimaryContainer,
        other.brandPrimaryContainer,
        t,
      )!,
      brandSecondary: Color.lerp(brandSecondary, other.brandSecondary, t)!,
      brandTertiary: Color.lerp(brandTertiary, other.brandTertiary, t)!,
      statusSuccess: Color.lerp(statusSuccess, other.statusSuccess, t)!,
      statusWarning: Color.lerp(statusWarning, other.statusWarning, t)!,
      statusDanger: Color.lerp(statusDanger, other.statusDanger, t)!,
      statusInfo: Color.lerp(statusInfo, other.statusInfo, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ColorPalette &&
            const DeepCollectionEquality().equals(
              brandPrimary,
              other.brandPrimary,
            ) &&
            const DeepCollectionEquality().equals(
              brandPrimaryContainer,
              other.brandPrimaryContainer,
            ) &&
            const DeepCollectionEquality().equals(
              brandSecondary,
              other.brandSecondary,
            ) &&
            const DeepCollectionEquality().equals(
              brandTertiary,
              other.brandTertiary,
            ) &&
            const DeepCollectionEquality().equals(
              statusSuccess,
              other.statusSuccess,
            ) &&
            const DeepCollectionEquality().equals(
              statusWarning,
              other.statusWarning,
            ) &&
            const DeepCollectionEquality().equals(
              statusDanger,
              other.statusDanger,
            ) &&
            const DeepCollectionEquality().equals(
              statusInfo,
              other.statusInfo,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(brandPrimary),
      const DeepCollectionEquality().hash(brandPrimaryContainer),
      const DeepCollectionEquality().hash(brandSecondary),
      const DeepCollectionEquality().hash(brandTertiary),
      const DeepCollectionEquality().hash(statusSuccess),
      const DeepCollectionEquality().hash(statusWarning),
      const DeepCollectionEquality().hash(statusDanger),
      const DeepCollectionEquality().hash(statusInfo),
    );
  }
}
