// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shape_theme_extension.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ShapeThemeExtensionTailorMixin on ThemeExtension<ShapeThemeExtension> {
  double get xs;
  double get sm;
  double get md;
  double get lg;
  double get xl;
  double get button;
  double get card;
  double get sheet;
  double get pill;

  @override
  ShapeThemeExtension copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? button,
    double? card,
    double? sheet,
    double? pill,
  }) {
    return ShapeThemeExtension(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      button: button ?? this.button,
      card: card ?? this.card,
      sheet: sheet ?? this.sheet,
      pill: pill ?? this.pill,
    );
  }

  @override
  ShapeThemeExtension lerp(
    covariant ThemeExtension<ShapeThemeExtension>? other,
    double t,
  ) {
    if (other is! ShapeThemeExtension) return this as ShapeThemeExtension;
    return ShapeThemeExtension(
      xs: doubleThemeEncoder.lerp(xs, other.xs, t),
      sm: doubleThemeEncoder.lerp(sm, other.sm, t),
      md: doubleThemeEncoder.lerp(md, other.md, t),
      lg: doubleThemeEncoder.lerp(lg, other.lg, t),
      xl: doubleThemeEncoder.lerp(xl, other.xl, t),
      button: doubleThemeEncoder.lerp(button, other.button, t),
      card: doubleThemeEncoder.lerp(card, other.card, t),
      sheet: doubleThemeEncoder.lerp(sheet, other.sheet, t),
      pill: doubleThemeEncoder.lerp(pill, other.pill, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShapeThemeExtension &&
            const DeepCollectionEquality().equals(xs, other.xs) &&
            const DeepCollectionEquality().equals(sm, other.sm) &&
            const DeepCollectionEquality().equals(md, other.md) &&
            const DeepCollectionEquality().equals(lg, other.lg) &&
            const DeepCollectionEquality().equals(xl, other.xl) &&
            const DeepCollectionEquality().equals(button, other.button) &&
            const DeepCollectionEquality().equals(card, other.card) &&
            const DeepCollectionEquality().equals(sheet, other.sheet) &&
            const DeepCollectionEquality().equals(pill, other.pill));
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
      const DeepCollectionEquality().hash(button),
      const DeepCollectionEquality().hash(card),
      const DeepCollectionEquality().hash(sheet),
      const DeepCollectionEquality().hash(pill),
    );
  }
}
