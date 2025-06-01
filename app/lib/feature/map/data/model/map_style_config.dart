import 'package:eqmonitor/core/util/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_style_config.freezed.dart';
part 'map_style_config.g.dart';

/// マップのスタイル設定
@freezed
abstract class MapStyleConfig with _$MapStyleConfig {
  const factory MapStyleConfig({
    required MapStyleTheme theme,
    @JsonKey(includeToJson: false, includeFromJson: false)
    MapStyleColorScheme? colorScheme,
    @JsonKey(includeToJson: false, includeFromJson: false) String? styleString,
  }) = _MapStyleConfig;

  factory MapStyleConfig.fromJson(Map<String, dynamic> json) =>
      _$MapStyleConfigFromJson(json);
}

/// マップのスタイルテーマ
enum MapStyleTheme { light, dark, system }

/// マップのカラースキーム
@freezed
abstract class MapStyleColorScheme with _$MapStyleColorScheme {
  const factory MapStyleColorScheme({
    @ColorConverter() required Color backgroundColor,
    @ColorConverter() required Color landColor,
    @ColorConverter() required Color lineColor,
    @ColorConverter() required Color japanLandColor,
    @ColorConverter() required Color japanLineColor,
  }) = _MapStyleColorScheme;

  factory MapStyleColorScheme.fromJson(Map<String, dynamic> json) =>
      _$MapStyleColorSchemeFromJson(json);

  /// ライトテーマのカラースキーム
  factory MapStyleColorScheme.light() {
    const colorScheme = ColorScheme.light();
    return MapStyleColorScheme(
      backgroundColor: colorScheme.surface,
      landColor: colorScheme.surfaceContainer,
      lineColor: colorScheme.onSurfaceVariant,
      japanLandColor: colorScheme.surfaceContainer,
      japanLineColor: colorScheme.onSurfaceVariant,
    );
  }

  /// ダークテーマのカラースキーム
  factory MapStyleColorScheme.dark() {
    const colorScheme = ColorScheme.dark();
    return MapStyleColorScheme(
      backgroundColor:
          Color.lerp(
            colorScheme.surfaceContainerLowest,
            Colors.blue.shade900,
            0.1,
          )!,
      landColor: colorScheme.surfaceContainerHighest,
      lineColor: colorScheme.onSurfaceVariant,
      japanLandColor: colorScheme.surfaceContainerHighest,
      japanLineColor: colorScheme.onSurface,
    );
  }
}
