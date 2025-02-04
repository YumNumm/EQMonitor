import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

part 'map_layer.freezed.dart';

/// マップレイヤーの基底クラス
@freezed
sealed class MapLayer with _$MapLayer {
  const MapLayer._();

  /// 円レイヤー
  const factory MapLayer.circle({
    required String id,
    required String sourceId,
    required List<Map<String, dynamic>> circles,
    @Default(true) bool visible,
    double? minZoom,
    double? maxZoom,
    @Default(10.0) double circleRadius,
    @Default(Colors.blue) Color circleColor,
    @Default(1.0) double circleOpacity,
    @Default(0.0) double circleStrokeWidth,
    @Default(Colors.black) Color circleStrokeColor,
    @Default(0.0) double circleBlur,
  }) = CircleMapLayer;

  /// シンボルレイヤー
  const factory MapLayer.symbol({
    required String id,
    required String sourceId,
    required List<Map<String, dynamic>> symbols,
    @Default(true) bool visible,
    double? minZoom,
    double? maxZoom,
    String? iconImage,
    @Default(1.0) double iconSize,
    @Default(true) bool iconAllowOverlap,
    String? textField,
    @Default(16.0) double textSize,
    @Default(Colors.black) Color textColor,
    Offset? textOffset,
  }) = SymbolMapLayer;

  /// ヒートマップレイヤー
  const factory MapLayer.heatmap({
    required String id,
    required String sourceId,
    required List<Map<String, dynamic>> points,
    required List<Map<String, dynamic>> colorStops,
    @Default(true) bool visible,
    double? minZoom,
    double? maxZoom,
    String? weightProperty,
    @Default(1.0) double intensity,
    @Default(30.0) double radius,
  }) = HeatmapMapLayer;

  /// ラインレイヤー
  const factory MapLayer.line({
    required String id,
    required String sourceId,
    required List<Map<String, dynamic>> lines,
    @Default(true) bool visible,
    double? minZoom,
    double? maxZoom,
    @Default(Colors.blue) Color lineColor,
    @Default(1.0) double lineWidth,
    @Default(1.0) double lineOpacity,
    List<double>? lineDasharray,
  }) = LineMapLayer;

  /// レイヤーのソースデータを生成
  Map<String, dynamic> toSource() {
    return switch (this) {
      CircleMapLayer(:final circles) => {
          'type': 'geojson',
          'data': {
            'type': 'FeatureCollection',
            'features': circles,
          },
        },
      SymbolMapLayer(:final symbols) => {
          'type': 'geojson',
          'data': {
            'type': 'FeatureCollection',
            'features': symbols,
          },
        },
      HeatmapMapLayer(:final points) => {
          'type': 'geojson',
          'data': {
            'type': 'FeatureCollection',
            'features': points,
          },
        },
      LineMapLayer(:final lines) => {
          'type': 'geojson',
          'data': {
            'type': 'FeatureCollection',
            'features': lines,
          },
        },
    };
  }

  /// レイヤーのスタイルを生成
  LayerProperties toLayer() {
    return switch (this) {
      CircleMapLayer(
        :final circleRadius,
        :final circleColor,
        :final circleOpacity,
        :final circleStrokeWidth,
        :final circleStrokeColor,
        :final circleBlur,
        :final visible,
        :final minZoom,
        :final maxZoom,
      ) =>
        CircleLayerProperties(
          visibility: [
            'step',
            ['zoom'],
            'none',
            minZoom ?? 0,
            if (visible) 'visible' else 'none',
            maxZoom ?? 24,
            'none',
          ],
          circleRadius: circleRadius,
          circleColor: _colorToHex(circleColor),
          circleOpacity: circleOpacity,
          circleStrokeWidth: circleStrokeWidth,
          circleStrokeColor: _colorToHex(circleStrokeColor),
          circleBlur: circleBlur,
        ),
      SymbolMapLayer(
        :final iconImage,
        :final iconSize,
        :final iconAllowOverlap,
        :final textField,
        :final textSize,
        :final textColor,
        :final textOffset,
        :final visible,
        :final minZoom,
        :final maxZoom,
      ) =>
        SymbolLayerProperties(
          visibility: [
            'step',
            ['zoom'],
            'none',
            minZoom ?? 0,
            if (visible) 'visible' else 'none',
            maxZoom ?? 24,
            'none',
          ],
          iconImage: iconImage,
          iconSize: iconSize,
          iconAllowOverlap: iconAllowOverlap,
          textField: textField,
          textSize: textSize,
          textColor: _colorToHex(textColor),
          textOffset:
              textOffset != null ? [textOffset.dx, textOffset.dy] : null,
        ),
      HeatmapMapLayer(
        :final colorStops,
        :final weightProperty,
        :final intensity,
        :final radius,
        :final visible,
        :final minZoom,
        :final maxZoom,
      ) =>
        HeatmapLayerProperties(
          visibility: [
            'step',
            ['zoom'],
            'none',
            minZoom ?? 0,
            if (visible) 'visible' else 'none',
            maxZoom ?? 24,
            'none',
          ],
          heatmapWeight: weightProperty != null ? ['get', weightProperty] : 1,
          heatmapIntensity: intensity,
          heatmapRadius: radius,
          heatmapColor: [
            'interpolate',
            ['linear'],
            ['heatmap-density'],
            ...colorStops.expand(
              (stop) => [
                stop['density'],
                stop['color'],
              ],
            ),
          ],
        ),
      LineMapLayer(
        :final lineColor,
        :final lineWidth,
        :final lineOpacity,
        :final lineDasharray,
        :final visible,
        :final minZoom,
        :final maxZoom,
      ) =>
        LineLayerProperties(
          visibility: [
            'step',
            ['zoom'],
            'none',
            minZoom ?? 0,
            if (visible) 'visible' else 'none',
            maxZoom ?? 24,
            'none',
          ],
          lineColor: _colorToHex(lineColor),
          lineWidth: lineWidth,
          lineOpacity: lineOpacity,
          lineDasharray: lineDasharray,
        ),
    };
  }

  /// ColorをHex文字列に変換
  String _colorToHex(Color color) => '#${color.hex.toRadixString(16)}';
}
