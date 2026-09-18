import 'dart:async';
import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_simulation_notifier.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:maplibre/maplibre.dart';

class EewSimulationPsWaveLayer extends HookConsumerWidget {
  const new({super.key});

  static const _pWaveSourceId = 'eew-sim-p-wave';
  static const _sWaveSourceId = 'eew-sim-s-wave';
  static const _pWaveLayerId = 'eew-sim-p-wave-line';
  static const _sWaveLayerId = 'eew-sim-s-wave-line';
  static const _sWaveFillLayerId = 'eew-sim-s-wave-fill';

  static const _emptyGeoJson = '{"type":"FeatureCollection","features":[]}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final simulation = ref.watch(eewSimulationProvider);
    ref.watch(travelTimeDepthMapProvider);
    final enqueue = useMapOperationQueue();
    final initFuture = useRef<Future<void>?>(null);
    // 破棄開始後は毎フレームの更新(updateGeoJsonSource)を実行しないためのガード。
    // enqueue にすべての更新を積むとチェーンが肥大化するため、更新自体は
    // enqueue を経由させず、このフラグで破棄後の実行のみを止める。
    final disposed = useRef(false);
    final latestPWaveGeoJson = useRef<String?>(null);
    final latestSWaveGeoJson = useRef<String?>(null);

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      disposed.value = false;
      initFuture.value = enqueue(() => _initializeLayers(styleController));

      return () {
        disposed.value = true;
        unawaited(enqueue(() => _removeLayers(styleController)));
      };
    }, [styleController]);

    final animationController = useAnimationController(
      duration: const Duration(days: 365),
    );

    useEffect(() {
      if (simulation?.isPlaying ?? false) {
        unawaited(animationController.repeat());
      } else {
        animationController.stop();
      }
      return null;
    }, [simulation?.isPlaying]);

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      // simulationの状態遷移時はリスナーを張り直し、停止・完了位置を即時反映する。
      var listenerDisposed = false;

      void listener() {
        if (listenerDisposed || disposed.value) {
          return;
        }
        final sim = ref.read(eewSimulationProvider);
        if (sim == null) {
          unawaited(
            _updateGeoJson(
              styleController,
              pWaveGeoJson: _emptyGeoJson,
              sWaveGeoJson: _emptyGeoJson,
              latestP: latestPWaveGeoJson,
              latestS: latestSWaveGeoJson,
              initFuture: initFuture,
              disposed: disposed,
            ),
          );
          return;
        }

        final currentReport = sim.currentReport;
        final originTime = currentReport.originTime;
        final hypocenter = currentReport.hypocenter;
        final latitude = hypocenter?.latitude;
        final longitude = hypocenter?.longitude;
        final depth = hypocenter?.depth;
        if (originTime == null ||
            hypocenter == null ||
            latitude == null ||
            longitude == null ||
            depth == null ||
            currentReport.isPlum) {
          unawaited(
            _updateGeoJson(
              styleController,
              pWaveGeoJson: _emptyGeoJson,
              sWaveGeoJson: _emptyGeoJson,
              latestP: latestPWaveGeoJson,
              latestS: latestSWaveGeoJson,
              initFuture: initFuture,
              disposed: disposed,
            ),
          );
          return;
        }

        final firstReportTime = sim.reports.first.reportTime;
        final offset =
            firstReportTime.difference(originTime).inMilliseconds / 1000;
        final simulationElapsed =
            sim.playbackElapsedAt(clock.now()).inMilliseconds / 1000;
        final elapsed = offset + simulationElapsed;

        final travelTimeMap = ref.read(travelTimeDepthMapProvider);
        // 走時表未ロード時は波を描かない
        if (travelTimeMap == null) {
          unawaited(
            _updateGeoJson(
              styleController,
              pWaveGeoJson: _emptyGeoJson,
              sWaveGeoJson: _emptyGeoJson,
              latestP: latestPWaveGeoJson,
              latestS: latestSWaveGeoJson,
              initFuture: initFuture,
              disposed: disposed,
            ),
          );
          return;
        }
        final travelTime = travelTimeMap.getTravelTime(depth, elapsed);

        final lat = latitude;
        final lng = longitude;
        final isWarning = currentReport.isWarning ?? false;
        final lineColor = isWarning ? '#FF0000' : '#FFA500';
        final fillColor = isWarning ? '#FF0000' : '#FFA500';

        final pWaveFeatures = <Map<String, dynamic>>[];
        final sWaveFeatures = <Map<String, dynamic>>[];

        final pDistance = travelTime.pDistance;
        if (pDistance != null && pDistance > 0) {
          pWaveFeatures.add({
            'type': 'Feature',
            'geometry': {
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

        final pGeoJson = jsonEncode({
          'type': 'FeatureCollection',
          'features': pWaveFeatures,
        });
        final sGeoJson = jsonEncode({
          'type': 'FeatureCollection',
          'features': sWaveFeatures,
        });

        unawaited(
          _updateGeoJson(
            styleController,
            pWaveGeoJson: pGeoJson,
            sWaveGeoJson: sGeoJson,
            latestP: latestPWaveGeoJson,
            latestS: latestSWaveGeoJson,
            initFuture: initFuture,
            disposed: disposed,
          ),
        );
      }

      animationController.addListener(listener);
      listener();
      return () {
        listenerDisposed = true;
        animationController.removeListener(listener);
      };
      // 本体は ref.read 経由で読むため simulation の直接参照はないが、
      // 上のコメントの通りリスナーの張り直し契機として意図的に keys に含める。
      // ignore_keys: simulation
    }, [styleController, simulation, animationController]);

    return const SizedBox.shrink();
  }

  Future<void> _initializeLayers(StyleController styleController) async {
    await _removeLayers(styleController);
    await (
      styleController.addSource(
        const GeoJsonSource(id: _pWaveSourceId, data: _emptyGeoJson),
      ),
      styleController.addSource(
        const GeoJsonSource(id: _sWaveSourceId, data: _emptyGeoJson),
      ),
    ).wait;

    await (
      styleController.addLayer(
        const LineStyleLayer(
          id: _pWaveLayerId,
          sourceId: _pWaveSourceId,
          paint: {'line-color': '#0000FF', 'line-width': 1},
        ),
      ),
      styleController.addLayer(
        const LineStyleLayer(
          id: _sWaveLayerId,
          sourceId: _sWaveSourceId,
          paint: {
            'line-color': ['get', 'lineColor'],
            'line-width': 2,
          },
        ),
      ),
      styleController.addLayer(
        const FillStyleLayer(
          id: _sWaveFillLayerId,
          sourceId: _sWaveSourceId,
          paint: {
            'fill-color': ['get', 'fillColor'],
            'fill-opacity': 0.1,
          },
        ),
        belowLayerId: BaseLayer.areaForecastLocalEewLine.name,
      ),
    ).wait;
  }

  Future<void> _removeLayers(StyleController styleController) async {
    for (final layerId in [_pWaveLayerId, _sWaveLayerId, _sWaveFillLayerId]) {
      try {
        await styleController.removeLayer(layerId);
      } on Exception {
        // ignore
      }
    }
    for (final sourceId in [_pWaveSourceId, _sWaveSourceId]) {
      try {
        await styleController.removeSource(sourceId);
      } on Exception {
        // ignore
      }
    }
  }

  Future<void> _updateGeoJson(
    StyleController styleController, {
    required String pWaveGeoJson,
    required String sWaveGeoJson,
    required ObjectRef<String?> latestP,
    required ObjectRef<String?> latestS,
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
    final shouldUpdateP = latestP.value != pWaveGeoJson;
    final shouldUpdateS = latestS.value != sWaveGeoJson;
    if (!shouldUpdateP && !shouldUpdateS) {
      return;
    }

    if (shouldUpdateP) {
      try {
        await styleController.updateGeoJsonSource(
          id: _pWaveSourceId,
          data: pWaveGeoJson,
        );
        latestP.value = pWaveGeoJson;
      } catch (e, stackTrace) {
        talker.handle(e, stackTrace);
      }
    }
    if (disposed.value) {
      return;
    }
    if (shouldUpdateS) {
      try {
        await styleController.updateGeoJsonSource(
          id: _sWaveSourceId,
          data: sWaveGeoJson,
        );
        latestS.value = sWaveGeoJson;
      } catch (e, stackTrace) {
        talker.handle(e, stackTrace);
      }
    }
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
