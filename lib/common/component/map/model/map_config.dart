import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_config.freezed.dart';
part 'map_config.g.dart';

@freezed
class MapConfig with _$MapConfig {
  const factory MapConfig({
    @Default(0.8) double minScale,
    @Default(20) double maxScale,
  }) = _MapConfig;

  factory MapConfig.fromJson(Map<String, dynamic> json) =>
      _$MapConfigFromJson(json);
}

String colorToJson(Color color) => '#${color.value.toRadixString(16)}';
Color colorFromJson(String color) =>
    Color(int.parse(color.substring(1), radix: 16));
