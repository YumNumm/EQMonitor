import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/core/util/nullable_value_requirement.dart';
import 'package:material_ui/material_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_style_config.freezed.dart';
part 'map_style_config.g.dart';

/// マップのスタイル設定
@freezed
abstract class MapStyleConfig with _$MapStyleConfig {
  const factory({
    required MapStyleTheme theme,
    @JsonKey(includeToJson: false, includeFromJson: false)
    MapStyleColorScheme? colorScheme,
    @JsonKey(includeToJson: false, includeFromJson: false) String? styleString,
  }) = _MapStyleConfig;

  factory fromJson(Map<String, dynamic> json) =>
      _$MapStyleConfigFromJson(json);
}

/// マップのスタイルテーマ
enum MapStyleTheme { light, dark, system }

/// マップのカラースキーム
@freezed
abstract class MapStyleColorScheme with _$MapStyleColorScheme {
  const factory({
    @ColorJsonConverter() required Color backgroundColor,
    @ColorJsonConverter() required Color landColor,
    @ColorJsonConverter() required Color lineColor,
    @ColorJsonConverter() required Color japanLandColor,
    @ColorJsonConverter() required Color japanLineColor,
  }) = _MapStyleColorScheme;

  factory fromJson(Map<String, dynamic> json) =>
      _$MapStyleColorSchemeFromJson(json);

  /// ライトテーマのカラースキーム
  factory light() {
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
  factory dark() {
    const colorScheme = ColorScheme.dark();
    return MapStyleColorScheme(
      backgroundColor: Color.lerp(
        colorScheme.surfaceContainerLowest,
        Colors.blue.shade900,
        0.1,
      ).orFailBecause('両引数が非nullのためColor.lerpは必ず非nullを返す'),
      landColor: colorScheme.surfaceContainerHighest,
      lineColor: colorScheme.onSurfaceVariant,
      japanLandColor: colorScheme.surfaceContainerHighest,
      japanLineColor: colorScheme.onSurface,
    );
  }
}
