import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_simulation_notifier.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:maplibre/maplibre.dart';

class EewSimulationPsWaveLayer extends HookConsumerWidget {
  const EewSimulationPsWaveLayer({super.key});

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
    final initFuture = useRef<Future<void>?>(null);
    final latestPWaveGeoJson = useRef<String?>(null);
    final latestSWaveGeoJson = useRef<String?>(null);

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        final future = _initializeLayers(styleController);
        initFuture.value = future;

        return () {
          initFuture.value = null;
          unawaited(() async {
            await future;
            await _removeLayers(styleController);
          }());
        };
      },
      [styleController],
    );

    final animationController = useAnimationController(
      duration: const Duration(days: 365),
    );

    useEffect(
      () {
        if (simulation != null) {
          unawaited(animationController.repeat());
        } else {
          animationController.stop();
        }
        return null;
      },
      [simulation != null],
    );

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        var disposed = false;

        void listener() {
          if (disposed) {
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
              ),
            );
            return;
          }

          final currentReport = sim.currentReport;
          final originTime = currentReport.originTime;
          final hypocenter = currentReport.hypocenter;
          if (originTime == null ||
              hypocenter == null ||
              hypocenter.latitude == null ||
              hypocenter.longitude == null ||
              hypocenter.depth == null ||
              currentReport.isPlum) {
            unawaited(
              _updateGeoJson(
                styleController,
                pWaveGeoJson: _emptyGeoJson,
                sWaveGeoJson: _emptyGeoJson,
                latestP: latestPWaveGeoJson,
                latestS: latestSWaveGeoJson,
                initFuture: initFuture,
              ),
            );
            return;
          }

          final now = DateTime.now();
          final firstReportTime = sim.reports.first.reportTime;
          final offset =
              firstReportTime.difference(originTime).inMilliseconds / 1000;
          final simulationElapsed =
              now.difference(sim.startedAt).inMilliseconds / 1000;
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
              ),
            );
            return;
          }
          final travelTime = travelTimeMap.getTravelTime(
            hypocenter.depth!,
            elapsed,
          );

          final lat = hypocenter.latitude!;
          final lng = hypocenter.longitude!;
          final isWarning = currentReport.isWarning ?? false;
          final lineColor = isWarning ? '#FF0000' : '#FFA500';
          final fillColor = isWarning ? '#FF0000' : '#FFA500';

          final pWaveFeatures = <Map<String, dynamic>>[];
          final sWaveFeatures = <Map<String, dynamic>>[];

          if (travelTime.pDistance != null && travelTime.pDistance! > 0) {
            pWaveFeatures.add({
              'type': 'Feature',
              'geometry': {
                'type': 'Polygon',
                'coordinates': [
                  _generateCircleCoordinates(lat, lng, travelTime.pDistance!),
                ],
              },
              'properties': <String, dynamic>{},
            });
          }

          if (travelTime.sDistance != null && travelTime.sDistance! > 0) {
            sWaveFeatures.add({
              'type': 'Feature',
              'geometry': {
                'type': 'Polygon',
                'coordinates': [
                  _generateCircleCoordinates(lat, lng, travelTime.sDistance!),
                ],
              },
              'properties': {
                'lineColor': lineColor,
                'fillColor': fillColor,
              },
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
            ),
          );
        }

        animationController.addListener(listener);
        return () {
          disposed = true;
          animationController.removeListener(listener);
        };
      },
      [styleController, simulation, animationController],
    );

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
  }) async {
    await initFuture.value;
    final shouldUpdateP = latestP.value != pWaveGeoJson;
    final shouldUpdateS = latestS.value != sWaveGeoJson;
    if (!shouldUpdateP && !shouldUpdateS) {
      return;
    }

    if (shouldUpdateP) {
      await styleController.updateGeoJsonSource(
        id: _pWaveSourceId,
        data: pWaveGeoJson,
      );
      latestP.value = pWaveGeoJson;
    }
    if (shouldUpdateS) {
      await styleController.updateGeoJsonSource(
        id: _sWaveSourceId,
        data: sWaveGeoJson,
      );
      latestS.value = sWaveGeoJson;
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
