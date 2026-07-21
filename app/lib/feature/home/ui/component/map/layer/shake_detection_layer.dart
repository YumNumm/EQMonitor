// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class ShakeDetectionLayer extends ConsumerWidget {
  const ShakeDetectionLayer({required this.events, super.key});

  final List<ShakeDetectionEvent> events;

  static const sourceId = 'shake-detection';
  static const _fillLayerId = 'shake-detection-fill';
  static const _lineLayerId = 'shake-detection-line';
  static const _centerLayerId = 'shake-detection-center';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(
      homeConfigurationProvider.select(
        (a) => a.value?.shakeDetection ?? const HomeShakeDetectionSettings(),
      ),
    );
    if (!settings.show) {
      return const SizedBox.shrink();
    }
    return _ShakeDetectionLayerBody(events: events, settings: settings);
  }
}

class _ShakeDetectionLayerBody extends HookConsumerWidget {
  const _ShakeDetectionLayerBody({
    required this.events,
    required this.settings,
  });

  final List<ShakeDetectionEvent> events;
  final HomeShakeDetectionSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final isInitialized = useRef(false);
    final initFuture = useRef<Future<void>?>(null);
    // 破棄開始後は毎フレームの更新(updateGeoJsonSource)を実行しないためのガード。
    // enqueue にすべての更新を積むとチェーンが肥大化するため、更新自体は
    // enqueue を経由させず、このフラグで破棄後の実行のみを止める。
    final disposed = useRef(false);
    final latestGeoJson = useRef<String?>(null);
    final wasActive = useRef(false);
    final enqueue = useMapOperationQueue();

    // レイヤー初期化
    useEffect(() {
      if (styleController == null) {
        return null;
      }

      disposed.value = false;
      initFuture.value = enqueue(() async {
        await styleController.addSource(
          const GeoJsonSource(
            id: ShakeDetectionLayer.sourceId,
            data: _emptyGeoJson,
          ),
        );

        await (
          styleController.addLayer(
            const FillStyleLayer(
              id: ShakeDetectionLayer._fillLayerId,
              sourceId: ShakeDetectionLayer.sourceId,
              paint: {
                'fill-color': ['get', 'fillColor'],
                'fill-opacity': 1,
              },
            ),
          ),
          styleController.addLayer(
            const LineStyleLayer(
              id: ShakeDetectionLayer._lineLayerId,
              sourceId: ShakeDetectionLayer.sourceId,
              paint: {
                'line-color': ['get', 'lineColor'],
                'line-width': 2,
                'line-opacity': 1,
              },
            ),
          ),
          styleController.addLayer(
            const CircleStyleLayer(
              id: ShakeDetectionLayer._centerLayerId,
              sourceId: ShakeDetectionLayer.sourceId,
              paint: {
                'circle-radius': [
                  'interpolate',
                  ['linear'],
                  ['zoom'],
                  3,
                  5,
                  7,
                  10,
                  10,
                  14,
                ],
                'circle-color': ['get', 'centerColor'],
                'circle-opacity': 1,
                'circle-stroke-color': ['get', 'strokeColor'],
                'circle-stroke-width': 2,
                'circle-stroke-opacity': 1,
              },
            ),
          ),
        ).wait;

        isInitialized.value = true;
      });

      return () {
        disposed.value = true;
        isInitialized.value = false;
        unawaited(
          enqueue(
            () => removeMapStyleResources(
              styleController: styleController,
              layerIds: const [
                ShakeDetectionLayer._centerLayerId,
                ShakeDetectionLayer._fillLayerId,
                ShakeDetectionLayer._lineLayerId,
              ],
              sourceIds: const [ShakeDetectionLayer.sourceId],
            ),
          ),
        );
      };
    }, [styleController]);

    final animationController = useAnimationController(
      duration: const Duration(seconds: 2),
    );

    // eventsRef / settingsRef: listener内で常に最新値を参照するためのRef
    final eventsRef = useRef(events);
    final settingsRef = useRef(settings);
    useEffect(() {
      eventsRef.value = events;
      settingsRef.value = settings;
      return null;
    }, [events, settings]);

    // アニメーション制御
    // events.isNotEmpty (bool) を deps にすることで、リスト参照が毎秒変わっても
    // repeat() が不必要にリセットされるのを防ぐ
    useEffect(
      () {
        if (styleController == null) {
          return null;
        }
        if (events.isNotEmpty) {
          if (settings.animationMode != HomeShakeDetectionAnimationMode.solid) {
            unawaited(animationController.repeat());
          } else {
            animationController.stop();
          }
          wasActive.value = true;
        } else {
          animationController.stop();
          if (wasActive.value && isInitialized.value) {
            unawaited(
              enqueue(
                () => _updateGeoJsonIfChanged(
                  styleController,
                  geoJson: _emptyGeoJson,
                  latestGeoJson: latestGeoJson,
                  initFuture: initFuture,
                  disposed: disposed,
                ),
              ),
            );
          }
          wasActive.value = false;
        }
        return null;
      },
      // events.isNotEmpty を使い、リスト参照の変化で毎秒リセットされるのを防ぐ
      [
        styleController,
        events.isNotEmpty,
        settings.animationMode,
        animationController,
      ],
    );

    // データ更新
    // eventsRef / settingsRef 経由で最新値を読むことで events をdepsから外し、
    // 毎秒リスナーが再登録されるのを防ぐ
    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        // このリスナー自体の有効期間は `settings.animationMode`/
        // `animationController` の変化にも連動する
        // （[styleController] のみに連動する [disposed] とは別軸）。
        var listenerDisposed = false;

        void listener() {
          if (listenerDisposed || disposed.value) {
            return;
          }
          final opacity = _computeOpacity(
            animationController.value,
            settingsRef.value.animationMode,
          );
          final geoJson = _buildGeoJson(
            eventsRef.value,
            settingsRef.value.displayMode,
            opacity,
          );
          unawaited(
            _updateGeoJsonIfChanged(
              styleController,
              geoJson: geoJson,
              latestGeoJson: latestGeoJson,
              initFuture: initFuture,
              disposed: disposed,
            ),
          );
        }

        Timer? timer;
        if (settingsRef.value.animationMode ==
            HomeShakeDetectionAnimationMode.solid) {
          listener();
          timer = Timer.periodic(const Duration(seconds: 1), (_) => listener());
        } else {
          animationController.addListener(listener);
        }

        return () {
          listenerDisposed = true;
          timer?.cancel();
          animationController.removeListener(listener);
        };
      },
      // animationMode が変わった時だけリスナーを再登録する
      [styleController, settings.animationMode, animationController],
    );

    return const SizedBox.shrink();
  }

  double _computeOpacity(double t, HomeShakeDetectionAnimationMode mode) {
    return switch (mode) {
      HomeShakeDetectionAnimationMode.solid => 1.0,
      // 0 → 1 → 0 のサイン波（周期 ~2秒）
      HomeShakeDetectionAnimationMode.fade =>
        (math.sin(t * math.pi * 2 * 0.5) + 1) / 2,
      // 周期的に 0/1 を切り替え（EEW と同周期感）
      HomeShakeDetectionAnimationMode.blink =>
        math.sin(t * math.pi * 2 * 0.5) > 0 ? 1.0 : 0.0,
    };
  }

  String _buildGeoJson(
    List<ShakeDetectionEvent> events,
    HomeShakeDetectionDisplayMode displayMode,
    double opacity,
  ) {
    final features = <Map<String, dynamic>>[];
    for (final event in events) {
      final (r, g, b) = _rgbForLevel(event.level);
      final fillColor =
          'rgba($r, $g, $b, ${(opacity * 0.3).toStringAsFixed(3)})';
      final lineColor = 'rgba($r, $g, $b, ${opacity.toStringAsFixed(3)})';
      final polygons = switch (displayMode) {
        HomeShakeDetectionDisplayMode.boundingBox => [
          _boundingBoxPolygon(event),
        ],
        HomeShakeDetectionDisplayMode.gridCell => _gridCellPolygons(event),
      };
      for (final coords in polygons) {
        features.add({
          'type': 'Feature',
          'geometry': {
            'type': 'Polygon',
            'coordinates': [coords],
          },
          'properties': {'fillColor': fillColor, 'lineColor': lineColor},
        });
      }
      final centerLat = (event.minLat + event.maxLat) / 2;
      final centerLng = (event.minLng + event.maxLng) / 2;
      features.add({
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [centerLng, centerLat],
        },
        'properties': {
          'centerColor':
              'rgba($r, $g, $b, ${(opacity * 0.8).toStringAsFixed(3)})',
          'strokeColor': 'rgba(255, 255, 255, ${opacity.toStringAsFixed(3)})',
        },
      });
    }
    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  List<List<double>> _boundingBoxPolygon(ShakeDetectionEvent e) {
    final tl = [e.minLng, e.maxLat];
    final tr = [e.maxLng, e.maxLat];
    final br = [e.maxLng, e.minLat];
    final bl = [e.minLng, e.minLat];
    return [tl, tr, br, bl, tl];
  }

  List<List<List<double>>> _gridCellPolygons(ShakeDetectionEvent e) {
    const step = 0.25;
    final polygons = <List<List<double>>>[];

    final startLat = (e.minLat / step).floor() * step;
    final startLng = (e.minLng / step).floor() * step;

    for (var lat = startLat; lat < e.maxLat; lat += step) {
      for (var lng = startLng; lng < e.maxLng; lng += step) {
        final tl = [lng, lat + step];
        final tr = [lng + step, lat + step];
        final br = [lng + step, lat];
        final bl = [lng, lat];
        polygons.add([tl, tr, br, bl, tl]);
      }
    }
    return polygons;
  }

  (int, int, int) _rgbForLevel(ShakeDetectionLevel level) => switch (level) {
    ShakeDetectionLevel.weaker => (136, 204, 255),
    ShakeDetectionLevel.weak => (68, 170, 255),
    ShakeDetectionLevel.medium => (255, 221, 68),
    ShakeDetectionLevel.strong => (255, 136, 0),
    ShakeDetectionLevel.stronger => (255, 34, 0),
  };
}

const _emptyGeoJson = '{"type":"FeatureCollection","features":[]}';

Future<void> _updateGeoJsonIfChanged(
  StyleController styleController, {
  required String geoJson,
  required ObjectRef<String?> latestGeoJson,
  required ObjectRef<Future<void>?> initFuture,
  required ObjectRef<bool> disposed,
}) async {
  // 初期化(source/layer 追加)の完了を待つ。この await 中に破棄処理
  // (source/layer 削除)が完了する可能性があるため、await 後に必ず
  // disposed を再チェックしてから styleController を操作する。
  await initFuture.value;
  if (disposed.value) {
    return;
  }
  if (latestGeoJson.value == geoJson) {
    return;
  }
  try {
    await styleController.updateGeoJsonSource(
      id: ShakeDetectionLayer.sourceId,
      data: geoJson,
    );
    latestGeoJson.value = geoJson;
  } catch (e, stackTrace) {
    talker.handle(e, stackTrace);
  }
}
