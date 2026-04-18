import 'dart:async';
import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:maplibre/maplibre.dart';

class EewPsWaveLayer extends HookConsumerWidget {
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
    final styleController = MapController.maybeOf(context)?.style;

    final showEews = useMemoized(
      () => eews.where((eew) {
        final hypo = eew.hypocenter;
        return hypo != null &&
            hypo.hasLatLng &&
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

    // レイヤーの初期化
    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
          await (
            styleController.addSource(
              GeoJsonSource(
                id: sourceId.pWave,
                data: jsonEncode({
                  'type': 'FeatureCollection',
                  'features': <Map<String, dynamic>>[],
                }),
              ),
            ),
            styleController.addSource(
              GeoJsonSource(
                id: sourceId.sWave,
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
                id: layerId.pWaveLine,
                sourceId: sourceId.pWave,
                paint: const {
                  'line-color': '#0000FF',
                  'line-width': 1,
                },
              ),
            ),
            styleController.addLayer(
              LineStyleLayer(
                id: layerId.sWaveLine,
                sourceId: sourceId.sWave,
                paint: const {
                  'line-color': ['get', 'lineColor'],
                  'line-width': 2,
                },
              ),
            ),
            styleController.addLayer(
              FillStyleLayer(
                id: layerId.sWaveFill,
                sourceId: sourceId.sWave,
                paint: const {
                  'fill-color': ['get', 'fillColor'],
                  'fill-opacity': 0.2,
                },
              ),
            ),
          ).wait;

          isInitialized.value = true;
        }());

        return () async {
          await styleController.removeLayer(layerId.pWaveLine);
          await styleController.removeLayer(layerId.sWaveLine);
          await styleController.removeLayer(layerId.sWaveFill);
          await styleController.removeSource(sourceId.pWave);
          await styleController.removeSource(sourceId.sWave);
        };
      },
      [styleController],
    );

    // Tickerで毎フレームGeoJSONを更新
    final animationController = useAnimationController(
      duration: const Duration(days: 365),
    );

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }
        if (showEews.isNotEmpty) {
          unawaited(animationController.repeat());
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
      },
      [styleController, showEews],
    );

    useEffect(
      () {
        void listener() {
          if (!isInitialized.value || styleController == null) {
            return;
          }
          final travelTimeMap = ref.read(travelTimeDepthMapProvider);
          final now = clock.now();

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

        animationController.addListener(listener);
        return () => animationController.removeListener(listener);
      },
      [styleController, showEews],
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
      if (hypocenter == null || !hypocenter.hasLatLng) {
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
              _generateCircleCoordinates(
                lat,
                lng,
                travelTime.pDistance!,
              ),
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
              _generateCircleCoordinates(
                lat,
                lng,
                travelTime.sDistance!,
              ),
            ],
          },
          'properties': {
            'lineColor': lineColor,
            'fillColor': fillColor,
          },
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
