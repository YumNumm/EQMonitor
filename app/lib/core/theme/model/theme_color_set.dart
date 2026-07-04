import 'package:eqmonitor/core/theme/model/estimated_intensity_colors.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/model/map_colors.dart';
import 'package:eqmonitor/core/theme/model/status_colors.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_color_set.freezed.dart';
part 'theme_color_set.g.dart';

@freezed
abstract class ThemeColorSet with _$ThemeColorSet {
  const factory ThemeColorSet({
    @ColorJsonConverter() required Color primary,
    @ColorJsonConverter() required Color onPrimary,
    @ColorJsonConverter() required Color primaryContainer,
    @ColorJsonConverter() required Color onPrimaryContainer,
    @ColorJsonConverter() required Color secondary,
    @ColorJsonConverter() required Color onSecondary,
    @ColorJsonConverter() required Color secondaryContainer,
    @ColorJsonConverter() required Color onSecondaryContainer,
    @ColorJsonConverter() required Color tertiary,
    @ColorJsonConverter() required Color onTertiary,
    @ColorJsonConverter() required Color tertiaryContainer,
    @ColorJsonConverter() required Color onTertiaryContainer,
    @ColorJsonConverter() required Color error,
    @ColorJsonConverter() required Color onError,
    @ColorJsonConverter() required Color errorContainer,
    @ColorJsonConverter() required Color onErrorContainer,
    @ColorJsonConverter() required Color surface,
    @ColorJsonConverter() required Color onSurface,
    @ColorJsonConverter() required Color onSurfaceVariant,
    @ColorJsonConverter() required Color surfaceContainerLowest,
    @ColorJsonConverter() required Color surfaceContainerLow,
    @ColorJsonConverter() required Color surfaceContainer,
    @ColorJsonConverter() required Color surfaceContainerHigh,
    @ColorJsonConverter() required Color surfaceContainerHighest,
    @ColorJsonConverter() required Color outline,
    @ColorJsonConverter() required Color outlineVariant,
    @ColorJsonConverter() required Color inverseSurface,
    @ColorJsonConverter() required Color onInverseSurface,
    @ColorJsonConverter() required Color inversePrimary,
    @ColorJsonConverter() required Color shadow,
    @ColorJsonConverter() required Color scrim,
    required StatusColors status,
    required IntensityColors intensity,
    required EstimatedIntensityColors estimatedIntensity,
    @JsonKey(name: 'map') required MapColors mapColors,
  }) = _ThemeColorSet;

  factory ThemeColorSet.fromJson(Map<String, dynamic> json) =>
      _$ThemeColorSetFromJson(json);

  const ThemeColorSet._();

  ColorScheme toColorScheme(Brightness brightness) => ColorScheme(
    brightness: brightness,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    surface: surface,
    onSurface: onSurface,
    onSurfaceVariant: onSurfaceVariant,
    surfaceContainerLowest: surfaceContainerLowest,
    surfaceContainerLow: surfaceContainerLow,
    surfaceContainer: surfaceContainer,
    surfaceContainerHigh: surfaceContainerHigh,
    surfaceContainerHighest: surfaceContainerHighest,
    outline: outline,
    outlineVariant: outlineVariant,
    inverseSurface: inverseSurface,
    onInverseSurface: onInverseSurface,
    inversePrimary: inversePrimary,
    shadow: shadow,
    scrim: scrim,
  );
}
