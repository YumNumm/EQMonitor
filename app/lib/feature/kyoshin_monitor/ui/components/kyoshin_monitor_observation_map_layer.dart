import 'dart:convert';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/map/ui/components/map_layer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

/// 強震観測点マップレイヤー
class KyoshinMonitorObservationMapLayer extends HookConsumerWidget
    with
        MapLayer<
          List<KyoshinMonitorImageParseObservationPoint>?,
          KyoshinMonitorSettingsModel
        > {
  KyoshinMonitorObservationMapLayer({super.key});

  static const String _sourceId = 'kyoshin_monitor_observation_points';
  static const String _layerId = 'kyoshin_monitor_observation_points';

  bool _isInitialized = false;

  @override
  Future<void> initialize(
    MapLibreMapController controller,
    List<KyoshinMonitorImageParseObservationPoint>? data,
    KyoshinMonitorSettingsModel style,
  ) async {
    try {
      // 以前のレイヤーとソースを削除
      await dispose(controller);

      // GeoJSONソースを追加
      await controller.addGeoJsonSource(_sourceId, {
        'type': 'FeatureCollection',
        'features': <void>[],
      });

      // サークルレイヤーを追加
      await controller.addCircleLayer(
        _sourceId,
        _layerId,
        CircleLayerProperties(
          circleRadius: [
            'interpolate',
            ['linear'],
            ['zoom'],
            3, 1, // ズームレベル3で半径1px
            10, 10, // ズームレベル10で半径10px
          ],
          circleColor: ['get', 'color'],
          circleStrokeColor:
              Colors.grey.withValues(alpha: 0.8).toHexStringRGB(),
          circleStrokeWidth: [
            'interpolate',
            ['linear'],
            ['zoom'],
            3, 0.2, // ズームレベル3で幅0.2px
            10, 1, // ズームレベル10で幅1px
          ],
          circleSortKey: ['get', 'scale'],
        ),
      );

      _isInitialized = true;
    } on Exception catch (e) {
      debugPrint('強震観測点レイヤー初期化エラー: $e');
    }
  }

  @override
  Future<void> dispose(MapLibreMapController controller) async {
    try {
      if (_isInitialized) {
        await controller.removeLayer(_layerId);
        await controller.removeSource(_sourceId);
        _isInitialized = false;
      } else {
        // 初期化されていなくても、残っている可能性があるためクリーンアップ
        try {
          await controller.removeLayer(_layerId);
        } on Exception catch (_) {}
        try {
          await controller.removeSource(_sourceId);
        } on Exception catch (_) {}
      }
    } on Exception catch (e) {
      debugPrint('強震観測点レイヤー削除エラー: $e');
    }
  }

  @override
  List<KyoshinMonitorImageParseObservationPoint>? dataDependency(
    MapLibreMapController controller,
    WidgetRef ref,
  ) => ref.watch(
    kyoshinMonitorNotifierProvider.select((v) => v.valueOrNull?.analyzedPoints),
  );

  @override
  KyoshinMonitorSettingsModel styleDependency(
    MapLibreMapController controller,
    WidgetRef ref,
  ) => ref.watch(kyoshinMonitorSettingsProvider);

  @override
  Future<void> onDataUpdated(
    MapLibreMapController controller,
    List<KyoshinMonitorImageParseObservationPoint>? data,
  ) async {
    if (!_isInitialized) {
      return;
    }

    if (data == null || data.isEmpty) {
      // データがない場合は空のGeoJSONを設定
      await _updateGeoJson(controller, {
        'type': 'FeatureCollection',
        'features': <void>[],
      });
      return;
    }

    // 観測点データからGeoJSONを作成
    final features =
        data.map((point) {
          final location = point.point.location;
          final observation = point.observation;

          // RGB値から16進カラーコードを生成
          final colorCode =
              '#${observation.r.toRadixString(16).padLeft(2, '0')}${observation.g.toRadixString(16).padLeft(2, '0')}${observation.b.toRadixString(16).padLeft(2, '0')}';

          return {
            'type': 'Feature',
            'geometry': {
              'type': 'Point',
              'coordinates': [location.longitude, location.latitude],
            },
            'properties': {
              'code': point.point.code,
              'name': point.point.name,
              'color': colorCode,
            },
          };
        }).toList();

    await _updateGeoJson(controller, {
      'type': 'FeatureCollection',
      'features': features,
    });
  }

  Future<void> _updateGeoJson(
    MapLibreMapController controller,
    Map<String, dynamic> geoJson,
  ) async {
    print(
      'Updating GeoJSON: bytes: ${utf8.encode(geoJson.toString()).lengthInBytes / 1024}KB',
    );
    try {
      await controller.setGeoJsonSource(_sourceId, geoJson);
    } on Exception catch (e) {
      debugPrint('強震観測点GeoJSON更新エラー: $e');
    }
  }

  @override
  Future<void> onStyleUpdated(
    MapLibreMapController controller,
    KyoshinMonitorSettingsModel style,
  ) async {
    talker.error('onStyleUpdated');
  }
}
