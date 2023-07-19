import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_config.freezed.dart';
part 'map_config.g.dart';

@freezed
class MapConfig with _$MapConfig {
  const factory MapConfig({
    @Default(0.8) double minScale,
    @Default(20) double maxScale,
    required MapColorScheme colorScheme,
  }) = _MapConfig;

  factory MapConfig.fromJson(Map<String, dynamic> json) =>
      _$MapConfigFromJson(json);
}

String colorToJson(Color color) => '#${color.value.toRadixString(16)}';
Color colorFromJson(String color) =>
    Color(int.parse(color.substring(1), radix: 16));

@freezed
class MapColorScheme with _$MapColorScheme {
  const factory MapColorScheme({
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color backgroundColor,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color worldLandColor,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color worldCoastlineColor,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color worldBorderLineColor,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color japanLandColor,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color japanCoastlineColor,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color japanBorderLineColor,
  }) = _MapColorScheme;

  factory MapColorScheme.fromJson(Map<String, dynamic> json) =>
      _$MapColorSchemeFromJson(json);

  factory MapColorScheme.light() => MapColorScheme(
        backgroundColor: Color.lerp(
          const Color.fromARGB(255, 253, 252, 255),
          Colors.blueAccent,
          0.3,
        )!,
        worldLandColor: Colors.white.withOpacity(0.8),
        worldCoastlineColor: Colors.black.withOpacity(0.15),
        worldBorderLineColor: Colors.black.withOpacity(0.3),
        japanLandColor: Colors.white,
        japanCoastlineColor: Colors.grey.withOpacity(0.5),
        japanBorderLineColor: Colors.grey,
      );

  factory MapColorScheme.dark() => MapColorScheme(
        backgroundColor: Color.lerp(
          const Color(0xff0a0a0a),
          Colors.blueAccent,
          0.3,
        )!,
        worldLandColor: Colors.blueGrey.shade900.withOpacity(0.9),
        worldCoastlineColor: Colors.white.withOpacity(0.3),
        worldBorderLineColor: Colors.white.withOpacity(0.3),
        japanLandColor: const Color(0xFF1a1c1e),
        japanCoastlineColor: Colors.white.withOpacity(0.4),
        japanBorderLineColor: Colors.grey.withOpacity(0.6),
      );
}
