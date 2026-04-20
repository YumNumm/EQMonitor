// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_theme_extension.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ColorThemeExtensionTailorMixin on ThemeExtension<ColorThemeExtension> {
  Color get backgroundDefault;
  Color get backgroundSubtle;
  Color get surfaceDefault;
  Color get surfaceRaised;
  Color get surfaceCard;
  Color get surfaceEmphasis;
  Color get outlineSoft;
  Color get outlineStrong;

  @override
  ColorThemeExtension copyWith({
    Color? backgroundDefault,
    Color? backgroundSubtle,
    Color? surfaceDefault,
    Color? surfaceRaised,
    Color? surfaceCard,
    Color? surfaceEmphasis,
    Color? outlineSoft,
    Color? outlineStrong,
  }) {
    return ColorThemeExtension(
      backgroundDefault: backgroundDefault ?? this.backgroundDefault,
      backgroundSubtle: backgroundSubtle ?? this.backgroundSubtle,
      surfaceDefault: surfaceDefault ?? this.surfaceDefault,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      surfaceCard: surfaceCard ?? this.surfaceCard,
      surfaceEmphasis: surfaceEmphasis ?? this.surfaceEmphasis,
      outlineSoft: outlineSoft ?? this.outlineSoft,
      outlineStrong: outlineStrong ?? this.outlineStrong,
    );
  }

  @override
  ColorThemeExtension lerp(
    covariant ThemeExtension<ColorThemeExtension>? other,
    double t,
  ) {
    if (other is! ColorThemeExtension) return this as ColorThemeExtension;
    return ColorThemeExtension(
      backgroundDefault: Color.lerp(
        backgroundDefault,
        other.backgroundDefault,
        t,
      )!,
      backgroundSubtle: Color.lerp(
        backgroundSubtle,
        other.backgroundSubtle,
        t,
      )!,
      surfaceDefault: Color.lerp(surfaceDefault, other.surfaceDefault, t)!,
      surfaceRaised: Color.lerp(surfaceRaised, other.surfaceRaised, t)!,
      surfaceCard: Color.lerp(surfaceCard, other.surfaceCard, t)!,
      surfaceEmphasis: Color.lerp(surfaceEmphasis, other.surfaceEmphasis, t)!,
      outlineSoft: Color.lerp(outlineSoft, other.outlineSoft, t)!,
      outlineStrong: Color.lerp(outlineStrong, other.outlineStrong, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ColorThemeExtension &&
            const DeepCollectionEquality().equals(
              backgroundDefault,
              other.backgroundDefault,
            ) &&
            const DeepCollectionEquality().equals(
              backgroundSubtle,
              other.backgroundSubtle,
            ) &&
            const DeepCollectionEquality().equals(
              surfaceDefault,
              other.surfaceDefault,
            ) &&
            const DeepCollectionEquality().equals(
              surfaceRaised,
              other.surfaceRaised,
            ) &&
            const DeepCollectionEquality().equals(
              surfaceCard,
              other.surfaceCard,
            ) &&
            const DeepCollectionEquality().equals(
              surfaceEmphasis,
              other.surfaceEmphasis,
            ) &&
            const DeepCollectionEquality().equals(
              outlineSoft,
              other.outlineSoft,
            ) &&
            const DeepCollectionEquality().equals(
              outlineStrong,
              other.outlineStrong,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundDefault),
      const DeepCollectionEquality().hash(backgroundSubtle),
      const DeepCollectionEquality().hash(surfaceDefault),
      const DeepCollectionEquality().hash(surfaceRaised),
      const DeepCollectionEquality().hash(surfaceCard),
      const DeepCollectionEquality().hash(surfaceEmphasis),
      const DeepCollectionEquality().hash(outlineSoft),
      const DeepCollectionEquality().hash(outlineStrong),
    );
  }
}
