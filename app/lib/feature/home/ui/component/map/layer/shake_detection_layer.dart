import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

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
    final latestGeoJson = useRef<String?>(null);
    final wasActive = useRef(false);

    // レイヤー初期化
    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
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
                  'fill-opacity': ['get', 'fillOpacity'],
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
                  'line-opacity': ['get', 'lineOpacity'],
                },
              ),
            ),
          ).wait;

          isInitialized.value = true;
        }());

        return () async {
          await styleController.removeLayer(ShakeDetectionLayer._fillLayerId);
          await styleController.removeLayer(ShakeDetectionLayer._lineLayerId);
          await styleController.removeSource(ShakeDetectionLayer.sourceId);
        };
      },
      [styleController],
    );

    final animationController = useAnimationController(
      duration: const Duration(seconds: 2),
    );

    // eventsRef / settingsRef: listener内で常に最新値を参照するためのRef
    final eventsRef = useRef(events);
    final settingsRef = useRef(settings);
    useEffect(
      () {
        eventsRef.value = events;
        settingsRef.value = settings;
        return null;
      },
      [events, settings],
    );

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
              _updateGeoJsonIfChanged(
                styleController,
                geoJson: _emptyGeoJson,
                latestGeoJson: latestGeoJson,
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

        void listener() {
          if (!isInitialized.value) {
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
      final color = _colorForLevel(event.level);
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
          'properties': {
            'lineColor': color,
            'fillColor': color,
            'fillOpacity': opacity * 0.25,
            'lineOpacity': opacity,
          },
        });
      }
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

  String _colorForLevel(ShakeDetectionLevel level) {
    return switch (level) {
      ShakeDetectionLevel.weaker => '#88CCFF',
      ShakeDetectionLevel.weak => '#44AAFF',
      ShakeDetectionLevel.medium => '#FFDD44',
      ShakeDetectionLevel.strong => '#FF8800',
      ShakeDetectionLevel.stronger => '#FF2200',
    };
  }
}

const _emptyGeoJson = '{"type":"FeatureCollection","features":[]}';

Future<void> _updateGeoJsonIfChanged(
  StyleController styleController, {
  required String geoJson,
  required ObjectRef<String?> latestGeoJson,
}) async {
  if (latestGeoJson.value == geoJson) {
    return;
  }
  await styleController.updateGeoJsonSource(
    id: ShakeDetectionLayer.sourceId,
    data: geoJson,
  );
  latestGeoJson.value = geoJson;
}
