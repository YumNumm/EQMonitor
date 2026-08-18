import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_ps_wave_layer_geojson_updater.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_offset_provider.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:maplibre/maplibre.dart';

class EewPsWaveLayer extends ConsumerWidget {
  const new({required this.eews, super.key});

  final List<EewTelegramItem> eews;

  static const ({String pWave, String sWave}) sourceId = (
    pWave: 'eew-p-wave',
    sWave: 'eew-s-wave',
  );
  static const ({String pWaveLine, String sWaveFill, String sWaveLine})
  layerId = (
    pWaveLine: 'eew-p-wave-line',
    sWaveLine: 'eew-s-wave-line',
    sWaveFill: 'eew-s-wave-fill',
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showCircles = ref.watch(
      homeConfigurationProvider.select(
        (a) => a.value?.eew.showPSWaveCircle ?? true,
      ),
    );
    if (!showCircles) {
      return const SizedBox.shrink();
    }
    return _EewPsWaveLayerBody(eews: eews);
  }
}

class _EewPsWaveLayerBody extends HookConsumerWidget {
  const new({required this.eews});

  final List<EewTelegramItem> eews;

  static const _geoJsonUpdater = EewPsWaveLayerGeoJsonUpdater();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;

    final animationRate = ref.watch(
      homeConfigurationProvider.select(
        (a) => a.value?.eew.animationRate ?? HomeEewAnimationRate.unlimited,
      ),
    );

    // 強震モニタの公開遅延に合わせるかどうか。
    // 既定は false = NTP 補正済みの正確な現在時刻を使う。
    final alignToKyoshinMonitor = ref.watch(
      homeConfigurationProvider.select(
        (a) => a.value?.eew.alignPSWaveCircleToKyoshinMonitor ?? false,
      ),
    );

    final showEews = useMemoized(
      () => eews.where((eew) {
        final hypo = eew.hypocenter;
        return hypo != null &&
            hypo.latitude != null &&
            hypo.longitude != null &&
            hypo.depth != null &&
            eew.originTime != null &&
            !eew.isCanceled &&
            // P波/S波レベル越え、IPF法(1点)、または「仮定震源要素」の場合 は除外
            !eew.isPlum;
      }).toList(),
      [eews],
    );

    final isInitialized = useRef(false);
    final initFuture = useRef<Future<void>?>(null);
    // 破棄開始後は毎フレームの更新(updateGeoJsonSource)を実行しないためのガード。
    // enqueue にすべての更新を積むとチェーンが肥大化するため、更新自体は
    // enqueue を経由させず、このフラグで破棄後の実行のみを止める。
    final disposed = useRef(false);
    final latestPWaveGeoJson = useRef<String?>(null);
    final latestSWaveGeoJson = useRef<String?>(null);
    final wasEewActive = useRef(false);
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      disposed.value = false;
      initFuture.value = enqueue(() async {
        await (
          styleController.addSource(
            GeoJsonSource(
              id: EewPsWaveLayer.sourceId.pWave,
              data: jsonEncode({
                'type': 'FeatureCollection',
                'features': <Map<String, dynamic>>[],
              }),
            ),
          ),
          styleController.addSource(
            GeoJsonSource(
              id: EewPsWaveLayer.sourceId.sWave,
              data: jsonEncode({
                'type': 'FeatureCollection',
                'features': <Map<String, dynamic>>[],
              }),
            ),
          ),
        ).wait;

        await (
          styleController.addLayer(
            LineStyleLayer(
              id: EewPsWaveLayer.layerId.pWaveLine,
              sourceId: EewPsWaveLayer.sourceId.pWave,
              paint: const {'line-color': '#0000FF', 'line-width': 1},
            ),
          ),
          styleController.addLayer(
            LineStyleLayer(
              id: EewPsWaveLayer.layerId.sWaveLine,
              sourceId: EewPsWaveLayer.sourceId.sWave,
              paint: const {
                'line-color': ['get', 'lineColor'],
                'line-width': 2,
              },
            ),
          ),
          styleController.addLayer(
            FillStyleLayer(
              id: EewPsWaveLayer.layerId.sWaveFill,
              sourceId: EewPsWaveLayer.sourceId.sWave,
              paint: const {
                'fill-color': ['get', 'fillColor'],
                'fill-opacity': 0.2,
              },
            ),
            belowLayerId: BaseLayer.areaForecastLocalEewLine.name,
          ),
        ).wait;

        isInitialized.value = true;
      });

      return () {
        disposed.value = true;
        isInitialized.value = false;
        unawaited(
          enqueue(
            () => MapStyleResourceRemover.remove(
              styleController: styleController,
              layerIds: [
                EewPsWaveLayer.layerId.pWaveLine,
                EewPsWaveLayer.layerId.sWaveLine,
                EewPsWaveLayer.layerId.sWaveFill,
              ],
              sourceIds: [
                EewPsWaveLayer.sourceId.pWave,
                EewPsWaveLayer.sourceId.sWave,
              ],
            ),
          ),
        );
      };
      // BaseLayer / EewPsWaveLayer は静的メンバ参照であり変数ではない
      // (プラグインが型名をローカル変数として誤検出する)。
      // ignore_keys: BaseLayer, EewPsWaveLayer
    }, [styleController]);

    final animationController = useAnimationController(
      duration: const Duration(days: 365),
    );

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      if (showEews.isNotEmpty) {
        if (animationRate == HomeEewAnimationRate.unlimited) {
          unawaited(animationController.repeat());
        } else {
          animationController.stop();
        }
        wasEewActive.value = true;
      } else {
        animationController.stop();
        if (wasEewActive.value && isInitialized.value) {
          unawaited(
            enqueue(
              () => _geoJsonUpdater.updateIfChanged(
                styleController: styleController,
                pWaveSourceId: EewPsWaveLayer.sourceId.pWave,
                sWaveSourceId: EewPsWaveLayer.sourceId.sWave,
                pWaveGeojson: _emptyGeoJson,
                sWaveGeojson: _emptyGeoJson,
                latestPWaveGeoJson: latestPWaveGeoJson,
                latestSWaveGeoJson: latestSWaveGeoJson,
                initFuture: initFuture,
                disposed: disposed,
              ),
            ),
          );
        }
        wasEewActive.value = false;
      }
      return null;
    }, [styleController, showEews, animationRate, animationController]);

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        // このリスナー自体の有効期間は `showEews`/`animationController` の
        // 変化にも連動する（[styleController] のみに連動する [disposed] とは別軸）。
        var listenerDisposed = false;

        void listener() {
          if (listenerDisposed || disposed.value) {
            return;
          }
          final travelTimeMap = ref.read(travelTimeDepthMapProvider);
          // 走時表未ロード時は波を描かない
          if (travelTimeMap == null) {
            return;
          }
          final now = ref.read(appClockProvider.notifier).now();
          // 設定が有効なら、強震モニタ画像の取得対象時刻に合わせる。
          final kyoshinMonitorOffset = alignToKyoshinMonitor
              ? ref.read(kyoshinMonitorEffectiveOffsetProvider)
              : null;
          final baseTime = kyoshinMonitorOffset == null
              ? now
              : now.subtract(kyoshinMonitorOffset);

          final (pWaveGeojson, sWaveGeojson) = _calculateGeoJson(
            showEews,
            baseTime,
            travelTimeMap,
          );

          unawaited(
            _geoJsonUpdater.updateIfChanged(
              styleController: styleController,
              pWaveSourceId: EewPsWaveLayer.sourceId.pWave,
              sWaveSourceId: EewPsWaveLayer.sourceId.sWave,
              pWaveGeojson: pWaveGeojson,
              sWaveGeojson: sWaveGeojson,
              latestPWaveGeoJson: latestPWaveGeoJson,
              latestSWaveGeoJson: latestSWaveGeoJson,
              initFuture: initFuture,
              disposed: disposed,
            ),
          );
        }

        Timer? timer;
        if (animationRate == HomeEewAnimationRate.oneHz) {
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
      [
        styleController,
        showEews,
        animationRate,
        animationController,
        alignToKyoshinMonitor,
      ],
    );

    return const SizedBox.shrink();
  }

  (String, String) _calculateGeoJson(
    List<EewTelegramItem> eews,
    DateTime now,
    TravelTimeDepthMap travelTimeMap,
  ) {
    final pWaveFeatures = <Map<String, dynamic>>[];
    final sWaveFeatures = <Map<String, dynamic>>[];

    for (final eew in eews) {
      final hypocenter = eew.hypocenter;
      final lat = hypocenter?.latitude;
      final lng = hypocenter?.longitude;
      if (hypocenter == null || lat == null || lng == null) {
        continue;
      }
      final depth = hypocenter.depth;
      final originTime = eew.originTime;

      if (depth == null || originTime == null) {
        continue;
      }

      final elapsed = now.difference(originTime).inMilliseconds / 1000;
      final travelTime = travelTimeMap.getTravelTime(depth, elapsed);

      final isWarning = eew.isWarning ?? false;
      final lineColor = isWarning ? '#FF0000' : '#FFA500';
      final fillColor = isWarning ? '#FF0000' : '#FFA500';

      final pDistance = travelTime.pDistance;
      if (pDistance != null && pDistance > 0) {
        pWaveFeatures.add(<String, dynamic>{
          'type': 'Feature',
          'geometry': <String, dynamic>{
            'type': 'Polygon',
            'coordinates': [_generateCircleCoordinates(lat, lng, pDistance)],
          },
          'properties': <String, dynamic>{},
        });
      }

      final sDistance = travelTime.sDistance;
      if (sDistance != null && sDistance > 0) {
        sWaveFeatures.add({
          'type': 'Feature',
          'geometry': {
            'type': 'Polygon',
            'coordinates': [_generateCircleCoordinates(lat, lng, sDistance)],
          },
          'properties': {'lineColor': lineColor, 'fillColor': fillColor},
        });
      }
    }

    final pWaveGeojson = jsonEncode({
      'type': 'FeatureCollection',
      'features': pWaveFeatures,
    });

    final sWaveGeojson = jsonEncode({
      'type': 'FeatureCollection',
      'features': sWaveFeatures,
    });

    return (pWaveGeojson, sWaveGeojson);
  }

  List<List<double>> _generateCircleCoordinates(
    double lat,
    double lng,
    double radiusKm,
  ) {
    const distance = latlong2.Distance();
    final center = latlong2.LatLng(lat, lng);
    final coordinates = <List<double>>[];

    for (var bearing = 0; bearing < 360; bearing += 4) {
      final point = distance.offset(center, radiusKm * 1000, bearing);
      coordinates.add([point.longitude, point.latitude]);
    }

    coordinates.add(coordinates.first);

    return coordinates;
  }
}

const _emptyGeoJson = '{"type":"FeatureCollection","features":[]}';
