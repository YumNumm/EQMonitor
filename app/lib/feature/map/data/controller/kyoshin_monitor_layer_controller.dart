import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/map/data/layer/base/i_map_layer.dart';
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
      ..listen(
        kyoshinMonitorNotifierProvider,
        (prev, next) {
          final previousPoints = prev?.valueOrNull?.analyzedPoints;
          final nextPoints = next.valueOrNull?.analyzedPoints;
          if (previousPoints != nextPoints) {
            _updateLayer(nextPoints ?? []);
          }
        },
      )
      ..listen(
        kyoshinMonitorSettingsProvider,
        (prev, next) {
          if (prev?.realtimeDataType != next.realtimeDataType ||
              prev?.realtimeLayer != next.realtimeLayer) {
            state = state.copyWith(
              points: [],
              realtimeDataType: next.realtimeDataType,
              markerType: next.kmoniMarkerType,
            );
          }
        },
      )
      ..listen(
        eewAliveTelegramProvider,
        (_, next) {
          final isInEew = next?.isNotEmpty ?? false;
          state = state.copyWith(
            isInEew: isInEew,
          );
        },
      );
    return KyoshinMonitorObservationLayer(
      id: 'kyoshin-monitor-points',
      sourceId: 'kyoshin-monitor-points',
      visible: true,
      points: [],
      isInEew: false,
      markerType: ref.read(kyoshinMonitorSettingsProvider).kmoniMarkerType,
      realtimeDataType:
          ref.read(kyoshinMonitorSettingsProvider).realtimeDataType,
    );
  }

  /// レイヤーを更新
  void _updateLayer(List<KyoshinMonitorImageParseObservationPoint> points) {
    if (points.isEmpty) {
      state = state.copyWith(
        points: [],
      );
      return;
    }

    state = KyoshinMonitorObservationLayer(
      id: 'kyoshin-monitor-points',
      sourceId: 'kyoshin-monitor-points',
      visible: true,
      points: points,
      isInEew: false,
      markerType: KyoshinMonitorMarkerType.always,
      realtimeDataType: RealtimeDataType.shindo,
    );
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
class KyoshinMonitorObservationLayer extends IMapLayer
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
  }) = _KyoshinMonitorObservationLayer;

  const KyoshinMonitorObservationLayer._();

  @override
  Map<String, dynamic> toGeoJsonSource() {
    return {
      'type': 'FeatureCollection',
      'features': points
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
                'intensity': e.observation.scaleToIntensity,
                'name': e.point.code,
                'strokeOpacity': switch (markerType) {
                  KyoshinMonitorMarkerType.always => 1.0,
                  KyoshinMonitorMarkerType.onlyEew when isInEew => 1.0,
                  _ => 0.0,
                },
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
      circleColor: [
        'get',
        'color',
      ],
      circleStrokeColor:
          "#${Colors.grey.hex.toRadixString(16).padLeft(6, '0')}",
      circleStrokeOpacity: [
        'get',
        'strokeOpacity',
      ],
      circleStrokeWidth: [
        'interpolate',
        ['linear'],
        ['zoom'],
        3,
        0.2,
        10,
        1,
      ],
      circleSortKey: [
        'get',
        'intensity',
      ],
    );
  }

  @override
  String get layerPropertiesHash => '${markerType.index}';
}
