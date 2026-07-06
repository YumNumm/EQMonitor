import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:maplibre/maplibre.dart';

class EewPsWaveLayer extends ConsumerWidget {
  const EewPsWaveLayer({required this.eews, super.key});

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
  const _EewPsWaveLayerBody({required this.eews});

  final List<EewTelegramItem> eews;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;

    final animationRate = ref.watch(
      homeConfigurationProvider.select(
        (a) => a.value?.eew.animationRate ?? HomeEewAnimationRate.unlimited,
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
            !eew.isPlum;
      }).toList(),
      [eews],
    );

    final isInitialized = useRef(false);
    final latestPWaveGeoJson = useRef<String?>(null);
    final latestSWaveGeoJson = useRef<String?>(null);
    final wasEewActive = useRef(false);
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      unawaited(
        enqueue(() async {
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
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            await styleController.removeLayer(EewPsWaveLayer.layerId.pWaveLine);
            await styleController.removeLayer(EewPsWaveLayer.layerId.sWaveLine);
            await styleController.removeLayer(EewPsWaveLayer.layerId.sWaveFill);
            await styleController.removeSource(EewPsWaveLayer.sourceId.pWave);
            await styleController.removeSource(EewPsWaveLayer.sourceId.sWave);
          }),
        );
      };
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
            _updateGeoJsonIfChanged(
              styleController,
              pWaveGeojson: _emptyGeoJson,
              sWaveGeojson: _emptyGeoJson,
              latestPWaveGeoJson: latestPWaveGeoJson,
              latestSWaveGeoJson: latestSWaveGeoJson,
            ),
          );
        }
        wasEewActive.value = false;
      }
      return null;
    }, [styleController, showEews, animationRate, animationController]);

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      var disposed = false;

      void listener() {
        if (disposed || !isInitialized.value) {
          return;
        }
        final travelTimeMap = ref.read(travelTimeDepthMapProvider);
        // 走時表未ロード時は波を描かない
        if (travelTimeMap == null) {
          return;
        }
        final now = ref.read(appClockProvider.notifier).now();

        final (pWaveGeojson, sWaveGeojson) = _calculateGeoJson(
          showEews,
          now,
          travelTimeMap,
        );

        unawaited(
          _updateGeoJsonIfChanged(
            styleController,
            pWaveGeojson: pWaveGeojson,
            sWaveGeojson: sWaveGeojson,
            latestPWaveGeoJson: latestPWaveGeoJson,
            latestSWaveGeoJson: latestSWaveGeoJson,
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
        disposed = true;
        timer?.cancel();
        animationController.removeListener(listener);
      };
    }, [styleController, showEews, animationRate, animationController]);

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
      if (hypocenter == null ||
          hypocenter.latitude == null ||
          hypocenter.longitude == null) {
        continue;
      }
      final depth = hypocenter.depth;
      final originTime = eew.originTime;

      if (depth == null || originTime == null) {
        continue;
      }

      final lat = hypocenter.latitude!;
      final lng = hypocenter.longitude!;

      final elapsed = now.difference(originTime).inMilliseconds / 1000;
      final travelTime = travelTimeMap.getTravelTime(depth, elapsed);

      final isWarning = eew.isWarning ?? false;
      final lineColor = isWarning ? '#FF0000' : '#FFA500';
      final fillColor = isWarning ? '#FF0000' : '#FFA500';

      if (travelTime.pDistance != null && travelTime.pDistance! > 0) {
        pWaveFeatures.add(<String, dynamic>{
          'type': 'Feature',
          'geometry': <String, dynamic>{
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

Future<void> _updateGeoJsonIfChanged(
  StyleController styleController, {
  required String pWaveGeojson,
  required String sWaveGeojson,
  required ObjectRef<String?> latestPWaveGeoJson,
  required ObjectRef<String?> latestSWaveGeoJson,
}) async {
  final shouldUpdatePWave = latestPWaveGeoJson.value != pWaveGeojson;
  final shouldUpdateSWave = latestSWaveGeoJson.value != sWaveGeojson;
  if (!shouldUpdatePWave && !shouldUpdateSWave) {
    return;
  }

  if (shouldUpdatePWave && shouldUpdateSWave) {
    await (
      styleController.updateGeoJsonSource(
        id: EewPsWaveLayer.sourceId.pWave,
        data: pWaveGeojson,
      ),
      styleController.updateGeoJsonSource(
        id: EewPsWaveLayer.sourceId.sWave,
        data: sWaveGeojson,
      ),
    ).wait;
    latestPWaveGeoJson.value = pWaveGeojson;
    latestSWaveGeoJson.value = sWaveGeojson;
    return;
  }

  if (shouldUpdatePWave) {
    await styleController.updateGeoJsonSource(
      id: EewPsWaveLayer.sourceId.pWave,
      data: pWaveGeojson,
    );
    latestPWaveGeoJson.value = pWaveGeojson;
  }

  if (shouldUpdateSWave) {
    await styleController.updateGeoJsonSource(
      id: EewPsWaveLayer.sourceId.sWave,
      data: sWaveGeojson,
    );
    latestSWaveGeoJson.value = sWaveGeojson;
  }
}
