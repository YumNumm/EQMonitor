import 'dart:async';
import 'dart:convert';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/color_extension.dart';
import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/feature/shake_detection/model/shake_detection_kmoni_merged_event.dart';
import 'package:eqmonitor/feature/shake_detection/provider/shake_detection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:synchronized/extension.dart';

/// 揺れ検知枠を表示するレイヤー
class ShakeDetectionLayer extends HookConsumerWidget implements MapLayer {
  const ShakeDetectionLayer({super.key});

  static const _baseLayerId = 'areaForecastLocalELine';
  static const _sourceId = 'shake_detection_grid_source';

  @override
  String get layerId => _baseLayerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final controller = MapController.of(context);
    final shakeDetectionEvents = ref.watch(
      shakeDetectionKmoniPointsMergedProvider,
    );

    // 点滅のためのタイマー状態
    final isVisible = useState(true);
    final timer = useRef<Timer?>(null);

    // 点滅タイマーの設定
    useEffect(() {
      timer.value = Timer.periodic(const Duration(milliseconds: 500), (_) {
        isVisible.value = !isVisible.value;
      });

      return () {
        timer.value?.cancel();
        timer.value = null;
      };
    }, const []);

    // レイヤーの初期化
    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async => controller.synchronized(() async {
            // GeoJSONソースを追加
            await controller.style!.addSource(
              GeoJsonSource(id: _sourceId, data: _createEmptyGeoJson()),
            );

            // 各レベルごとにLine Layerを追加
            for (final level in ShakeDetectionLevel.values) {
              final layerId = _getLayerId(level);
              await controller.style!.addLayer(
                LineStyleLayer(
                  id: layerId,
                  sourceId: _sourceId,
                  paint: {
                    'line-color': level.color.toHexStringRGB(),
                    'line-width': 2.0,
                  },
                  layout: {
                    'visibility': 'visible',
                    'filter': [
                      '==',
                      ['get', 'level'],
                      level.index.toString(),
                    ],
                  },
                ),
                belowLayerId: _baseLayerId,
              );
            }
            isInitialized.value = true;
          }),
        ),
      );
      return () {
        isInitialized.value = false;
      };
    }, []);

    // 揺れ検知データが変更されたときの処理
    useEffect(() {
      if (!isInitialized.value ||
          shakeDetectionEvents is AsyncLoading ||
          shakeDetectionEvents is AsyncError) {
        return;
      }

      final events = shakeDetectionEvents.valueOrNull ?? [];
      final gridAreas = _createDetectionGridGeoJson(events);

      unawaited(
        controller.synchronized(() async {
          // ソースデータを更新
          await controller.style!.updateGeoJsonSource(
            id: _sourceId,
            data: gridAreas,
          );

          // 点滅制御 - 表示/非表示を切り替え
          final visibility = isVisible.value ? 'visible' : 'none';

          // 各レベルのレイヤーを更新
          for (final level in ShakeDetectionLevel.values) {
            final layerId = _getLayerId(level);
            await controller.style!.updateLayer(
              LineStyleLayer(
                id: layerId,
                sourceId: _sourceId,
                paint: {
                  'line-color': level.color.toHexStringRGB(),
                  'line-width': 2.0,
                },
                layout: {
                  'visibility': visibility,
                  // 'filter': [
                  //   '==',
                  //   ['get', 'level'],
                  //   level.index.toString(),
                  // ],
                },
              ),
            );
          }
        }),
      );

      return null;
    }, [shakeDetectionEvents, isVisible.value]);

    return const SizedBox.shrink();
  }

  // 各レベルごとのレイヤーID
  static String _getLayerId(ShakeDetectionLevel level) {
    return 'shake-detection-grid-${level.name}';
  }

  // 空のGeoJSONを作成
  static String _createEmptyGeoJson() {
    return jsonEncode({'type': 'FeatureCollection', 'features': <void>[]});
  }

  // 揺れ検知イベントからグリッドデータを作成してGeoJSONに変換
  static String _createDetectionGridGeoJson(
    List<ShakeDetectionKmoniMergedEvent> events,
  ) {
    final gridMap = <String, _GridInfo>{};

    // すべてのイベントから点を収集し、0.25度ごとのグリッドに配置
    for (final event in events) {
      for (final region in event.regions) {
        for (final point in region.points) {
          final intensity = point.intensity;
          final lat = (point.point.location.latitude / 0.25).floor() * 0.25;
          final lon = (point.point.location.longitude / 0.25).floor() * 0.25;
          final gridId = '${lat}_$lon';

          // すでに同じグリッドに高い震度が設定されている場合はスキップ
          final existing = gridMap[gridId];
          if (existing != null && existing.intensity.index > intensity.index) {
            continue;
          }

          gridMap[gridId] = _GridInfo(intensity: intensity, lat: lat, lon: lon);
        }
      }
    }

    // GeoJSONのフィーチャーに変換
    final features = <Map<String, dynamic>>[];

    for (final entry in gridMap.entries) {
      final intensity = entry.value.intensity;
      ShakeDetectionLevel level;

      if (intensity == JmaForecastIntensity.zero) {
        level = ShakeDetectionLevel.low;
      } else if (intensity.index >= JmaForecastIntensity.four.index) {
        level = ShakeDetectionLevel.high;
      } else {
        level = ShakeDetectionLevel.middle;
      }

      // 矩形の枠線を追加
      features.add({
        'type': 'Feature',
        'geometry': {
          'type': 'LineString',
          'coordinates': [
            [entry.value.lon, entry.value.lat],
            [entry.value.lon + 0.25, entry.value.lat],
            [entry.value.lon + 0.25, entry.value.lat + 0.25],
            [entry.value.lon, entry.value.lat + 0.25],
            [entry.value.lon, entry.value.lat], // 閉じるために最初の点を繰り返す
          ],
        },
        'properties': {
          'grid_id': entry.key,
          'level': level.index.toString(),
          'intensity': intensity.type,
        },
      });
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }
}

/// グリッド情報を保持するヘルパークラス
class _GridInfo {
  _GridInfo({required this.intensity, required this.lat, required this.lon});

  final JmaForecastIntensity intensity;
  final double lat;
  final double lon;
}
