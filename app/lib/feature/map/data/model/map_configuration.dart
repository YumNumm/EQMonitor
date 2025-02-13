import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_configuration.freezed.dart';
part 'map_configuration.g.dart';

@freezed
class MapConfiguration with _$MapConfiguration {
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

Color colorFromJson(String json) => Color(int.parse(json));
String colorToJson(Color color) => color.hex.toRadixString(16);

@freezed
class MapColorScheme with _$MapColorScheme {
  const factory MapColorScheme({
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color backgroundColor,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color worldLandColor,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color worldLineColor,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color japanLandColor,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color japanLineColor,
  }) = _MapColorScheme;

  factory MapColorScheme.fromJson(Map<String, dynamic> json) =>
      _$MapColorSchemeFromJson(json);

  factory MapColorScheme.light() {
    const colorScheme = ColorScheme.light();
    return MapColorScheme(
      backgroundColor: colorScheme.surface,
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
