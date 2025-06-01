import 'package:eqmonitor/core/util/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_configuration.freezed.dart';
part 'map_configuration.g.dart';

@freezed
abstract class MapConfiguration with _$MapConfiguration {
  const factory MapConfiguration({
    required MapTheme theme,
    @JsonKey(includeToJson: false, includeFromJson: false)
    MapColorScheme? colorScheme,
    @JsonKey(includeToJson: false, includeFromJson: false) String? styleString,
  }) = _MapConfiguration;

  factory MapConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MapConfigurationFromJson(json);
}

enum MapTheme { light, dark, system }

@freezed
abstract class MapColorScheme with _$MapColorScheme {
  const factory MapColorScheme({
    @ColorConverter() required Color backgroundColor,
    @ColorConverter() required Color worldLandColor,
    @ColorConverter() required Color worldLineColor,
    @ColorConverter() required Color japanLandColor,
    @ColorConverter() required Color japanLineColor,
  }) = _MapColorScheme;

  factory MapColorScheme.fromJson(Map<String, dynamic> json) =>
      _$MapColorSchemeFromJson(json);

  factory MapColorScheme.light() {
    const colorScheme = ColorScheme.light();
    return MapColorScheme(
      backgroundColor:
          Color.lerp(colorScheme.surface, Colors.blue.shade900, 0.1)!,
      worldLandColor: colorScheme.surfaceContainerLowest,
      worldLineColor: colorScheme.onSurfaceVariant,
      japanLandColor: colorScheme.surfaceContainerLowest,
      japanLineColor: colorScheme.onSurfaceVariant,
    );
  }

  factory MapColorScheme.dark() {
    const colorScheme = ColorScheme.dark();
    return MapColorScheme(
      backgroundColor:
          Color.lerp(
            colorScheme.surfaceContainerLowest,
            Colors.blue.shade900,
            0.1,
          )!,
      worldLandColor: colorScheme.surfaceContainerHighest,
      worldLineColor: colorScheme.onSurfaceVariant,
      japanLandColor: colorScheme.surfaceContainerHighest,
      japanLineColor: colorScheme.onSurface,
    );
  }
}
