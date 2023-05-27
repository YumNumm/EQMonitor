import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_config.freezed.dart';
part 'map_config.g.dart';

@freezed
class MapConfig with _$MapConfig {
  const factory MapConfig({
    @Default(0.8) double minScale,
    @Default(20) double maxScale,
    @JsonKey(toJson: colorToJson, fromJson: colorFromJson)
    @Default(Color.fromARGB(255, 203, 211, 255))
    Color backgroundColor,
    @Default([
      LatLng(45.3, 145.1),
      LatLng(30, 128.8),
    ])
    List<LatLng> initialBounds,
  }) = _MapConfig;

  factory MapConfig.fromJson(Map<String, dynamic> json) =>
      _$MapConfigFromJson(json);
}

String colorToJson(Color color) => '#${color.value.toRadixString(16)}';
Color colorFromJson(String color) =>
    Color(int.parse(color.substring(1), radix: 16));
