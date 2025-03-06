import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/component/map/map_layer.dart';
import 'package:eqmonitor/core/extension/color_extension.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class KyoshinMonitorObservationLayer extends HookConsumerWidget
    with
        MapLayer<
          List<KyoshinMonitorImageParseObservationPoint>?,
          KyoshinMonitorSettingsModel
        > {
  const KyoshinMonitorObservationLayer({super.key});

  @override
  List<KyoshinMonitorImageParseObservationPoint>? dataDependencies(
    WidgetRef ref,
  ) {
    final kyoshinMonitorAnalyzedPoints =
        ref.watch(kyoshinMonitorNotifierProvider).valueOrNull?.analyzedPoints;

    return kyoshinMonitorAnalyzedPoints;
  }

  @override
  KyoshinMonitorSettingsModel layerDependencies(WidgetRef ref) {
    final settings = ref.watch(kyoshinMonitorSettingsProvider);
    return settings;
  }

  @override
  Future<void> initialize(
    MapController controller,
    List<KyoshinMonitorImageParseObservationPoint>? data,
    KyoshinMonitorSettingsModel settings,
  ) async {
    final style = controller.style!;
    await style.addSource(
      GeoJsonSource(
        id: sourceId,
        data: '{"type":"FeatureCollection","features":[]}',
      ),
    );
    await style.addLayer(
      CircleStyleLayer(
        id: layerId,
        sourceId: sourceId,
        paint: {
          'circle-color': ['get', 'color'],
          'circle-radius': [
            'interpolate',
            ['linear'],
            ['zoom'],
            3,
            1,
            10,
            10,
          ],
          if (settings.kmoniMarkerType == KyoshinMonitorMarkerType.always) ...{
            'circle-stroke-color': Colors.grey.toHexStringRGB(),
            'circle-stroke-width': [
              'interpolate',
              ['linear'],
              ['zoom'],
              3,
              0.2,
              10,
              1,
            ],
          },
        },
      ),
    );
  }

  @override
  Future<void> dispose() async {
    final controller = MapController.maybeOf(useContext());
    if (controller == null) {
      return;
    }

    final style = controller.style;
    if (style == null) {
      return;
    }

    await style.removeLayer(layerId);
    await style.removeSource(sourceId);
  }

  @override
  String get layerId => 'kyoshin_monitor_observation';

  @override
  String get sourceId => 'kyoshin_monitor_observation';

  @override
  Future<void> onDataUpdated(
    MapController controller,
    List<KyoshinMonitorImageParseObservationPoint>? points,
  ) async {
    if (points == null || points.isEmpty) {
      // データがない場合は空のGeoJSONを設定
      await controller.style?.updateGeoJsonSource(
        id: sourceId,
        data: '{"type":"FeatureCollection","features":[]}',
      );
      return;
    }

    // GeoJSONデータを生成して更新
    final geoJson = createGeoJson(points);
    await controller.style?.updateGeoJsonSource(id: sourceId, data: geoJson);
  }

  @override
  Future<void> onLayerUpdated(
    MapController controller,
    KyoshinMonitorSettingsModel settings,
  ) async {
    await dispose();
  }

  /// 観測点データからGeoJSONを生成
  String createGeoJson(List<KyoshinMonitorImageParseObservationPoint> points) {
    final features =
        points.map((point) {
          final color =
              Color.fromARGB(
                255,
                point.observation.r,
                point.observation.g,
                point.observation.b,
              ).toHexStringRGB();
          return {
            'type': 'Feature',
            'geometry': {
              'type': 'Point',
              'coordinates': [
                point.point.location.longitude,
                point.point.location.latitude,
              ],
            },
            'properties': {
              'color': color,
              'scale': point.observation.scale,
              'name': point.point.name,
            },
          };
        }).toList();

    final geoJson = {'type': 'FeatureCollection', 'features': features};

    return jsonEncode(geoJson);
  }
}
