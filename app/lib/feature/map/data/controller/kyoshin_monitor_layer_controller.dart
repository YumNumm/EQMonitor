import 'dart:convert';
import 'dart:developer';

import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/map/data/layer/base/map_layer.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_layer_controller.freezed.dart';
part 'kyoshin_monitor_layer_controller.g.dart';

/// 強震モニタの観測点レイヤーを管理するコントローラー
@riverpod
class KyoshinMonitorLayerController extends _$KyoshinMonitorLayerController {
  @override
  KyoshinMonitorObservationLayer build() {
    // 強震モニタの状態を監視
    ref
      ..listen(kyoshinMonitorNotifierProvider, (prev, next) {
        // 現在の設定と違うLayerが来たらIgnore
        final nextLayer = (
          next.valueOrNull?.currentRealtimeDataType,
          next.valueOrNull?.currentRealtimeLayer,
        );
        final settingsLayer = (
          ref.read(kyoshinMonitorSettingsProvider).realtimeDataType,
          ref.read(kyoshinMonitorSettingsProvider).realtimeLayer,
        );
        if (nextLayer != settingsLayer) {
          _updateLayer([]);
          return;
        }
        final previousPoints = prev?.valueOrNull?.analyzedPoints;
        final nextPoints = next.valueOrNull?.analyzedPoints;
        if (previousPoints != nextPoints) {
          _updateLayer(nextPoints ?? []);
        }
      })
      ..listen(kyoshinMonitorSettingsProvider, (prev, next) {
        log('prev: ${jsonEncode(prev)}');
        log('next: ${jsonEncode(next)}');
        if (prev?.realtimeDataType != next.realtimeDataType ||
            prev?.realtimeLayer != next.realtimeLayer ||
            prev?.kmoniMarkerType != next.kmoniMarkerType) {
          state = state.copyWith(
            points: [],
            realtimeDataType: next.realtimeDataType,
            markerType: next.kmoniMarkerType,
          );
        }
      })
      ..listen(eewAliveTelegramProvider, (_, next) {
        final isInEew = next?.isNotEmpty ?? false;
        state = state.copyWith(isInEew: isInEew);
      });
    return KyoshinMonitorObservationLayer(
      id: 'kyoshin-monitor-points',
      sourceId: 'kyoshin-monitor-points',
      visible: true,
      points: [],
      isInEew: ref.read(eewAliveTelegramProvider)?.isNotEmpty ?? false,
      markerType: ref.read(kyoshinMonitorSettingsProvider).kmoniMarkerType,
      realtimeDataType:
          ref.read(kyoshinMonitorSettingsProvider).realtimeDataType,
    );
  }

  /// レイヤーを更新
  void _updateLayer(List<KyoshinMonitorImageParseObservationPoint> points) {
    if (points.isEmpty) {
      state = state.copyWith(points: []);
      return;
    }

    state = state.copyWith(points: points);
  }
}

extension KyoshinMonitorObservationAnalyzedPointEx
    on KyoshinMonitorObservationAnalyzedPoint {
  String get colorHex {
    return '#${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';
  }
}

@freezed
class KyoshinMonitorObservationLayer extends MapLayer
    with _$KyoshinMonitorObservationLayer {
  factory KyoshinMonitorObservationLayer({
    required String id,
    required String sourceId,
    required bool visible,
    required List<KyoshinMonitorImageParseObservationPoint> points,
    required bool isInEew,
    required KyoshinMonitorMarkerType markerType,
    required RealtimeDataType realtimeDataType,
    double? minZoom,
    double? maxZoom,
    dynamic filter,
  }) = _KyoshinMonitorObservationLayer;

  const KyoshinMonitorObservationLayer._();

  @override
  Map<String, dynamic> toGeoJsonSource() {
    return {
      'type': 'FeatureCollection',
      'features':
          points
              .map(
                (e) => {
                  'type': 'Feature',
                  'geometry': {
                    'type': 'Point',
                    'coordinates': [
                      e.point.location.longitude,
                      e.point.location.latitude,
                    ],
                  },
                  'properties': {
                    'color': e.observation.colorHex,
                    'name': e.point.code,
                    'zIndex': e.observation.scale,
                    'showStroke': markerType == KyoshinMonitorMarkerType.always,
                  },
                },
              )
              .toList(),
    };
  }

  @override
  String get geoJsonSourceHash => points.hashCode.toString();

  @override
  LayerProperties toLayerProperties() {
    final defaultStrokeWidthStatement = [
      'interpolate',
      ['linear'],
      ['zoom'],
      3,
      0.2,
      10,
      1,
    ];
    return CircleLayerProperties(
      circleRadius: [
        'interpolate',
        ['linear'],
        ['zoom'],
        3,
        1,
        10,
        10,
      ],
      circleColor: ['get', 'color'],
      circleStrokeColor:
          "#${Colors.grey.hex.toRadixString(16).padLeft(6, '0')}",
      circleStrokeOpacity: ['get', 'strokeOpacity'],
      circleStrokeWidth: switch (markerType) {
        KyoshinMonitorMarkerType.always => defaultStrokeWidthStatement,
        KyoshinMonitorMarkerType.onlyEew when isInEew =>
          defaultStrokeWidthStatement,
        _ => 0,
      },
      circleSortKey: ['get', 'zIndex'],
    );
  }

  @override
  String get layerPropertiesHash => '${markerType.name}-$isInEew';
}
