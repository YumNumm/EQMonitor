// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spacing_theme_extension.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SpacingThemeExtensionTailorMixin
    on ThemeExtension<SpacingThemeExtension> {
  double get xs;
  double get sm;
  double get md;
  double get lg;
  double get xl;
  double get xxl;
  double get xxxl;
  double get xxxxl;

  @override
  SpacingThemeExtension copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
    double? xxxxl,
  }) {
    return SpacingThemeExtension(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
      xxxxl: xxxxl ?? this.xxxxl,
    );
  }

  @override
  SpacingThemeExtension lerp(
    covariant ThemeExtension<SpacingThemeExtension>? other,
    double t,
  ) {
    if (other is! SpacingThemeExtension) return this as SpacingThemeExtension;
    return SpacingThemeExtension(
      xs: doubleThemeEncoder.lerp(xs, other.xs, t),
      sm: doubleThemeEncoder.lerp(sm, other.sm, t),
      md: doubleThemeEncoder.lerp(md, other.md, t),
      lg: doubleThemeEncoder.lerp(lg, other.lg, t),
      xl: doubleThemeEncoder.lerp(xl, other.xl, t),
      xxl: doubleThemeEncoder.lerp(xxl, other.xxl, t),
      xxxl: doubleThemeEncoder.lerp(xxxl, other.xxxl, t),
      xxxxl: doubleThemeEncoder.lerp(xxxxl, other.xxxxl, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SpacingThemeExtension &&
            const DeepCollectionEquality().equals(xs, other.xs) &&
            const DeepCollectionEquality().equals(sm, other.sm) &&
            const DeepCollectionEquality().equals(md, other.md) &&
            const DeepCollectionEquality().equals(lg, other.lg) &&
            const DeepCollectionEquality().equals(xl, other.xl) &&
            const DeepCollectionEquality().equals(xxl, other.xxl) &&
            const DeepCollectionEquality().equals(xxxl, other.xxxl) &&
            const DeepCollectionEquality().equals(xxxxl, other.xxxxl));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(xs),
      const DeepCollectionEquality().hash(sm),
      const DeepCollectionEquality().hash(md),
      const DeepCollectionEquality().hash(lg),
      const DeepCollectionEquality().hash(xl),
      const DeepCollectionEquality().hash(xxl),
      const DeepCollectionEquality().hash(xxxl),
      const DeepCollectionEquality().hash(xxxxl),
    );
  }
}
