import 'dart:async';
import 'dart:convert';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:synchronized/extension.dart';

class EewPsWaveLayer extends HookConsumerWidget implements MapLayer {
  const EewPsWaveLayer({super.key, this.belowLayerId});

  final String? belowLayerId;

  @override
  String get layerId => _pWaveBorderLayerId;

  static const _sourceId = 'eew_ps_wave_source';
  static const _pWaveBorderLayerId = 'eew_p_wave_border_layer';
  static const _sWaveNonWarningBorderLayerId =
      'eew_s_wave_non_warning_border_layer';
  static const _sWaveWarningBorderLayerId = 'eew_s_wave_warning_border_layer';
  static const _sWaveNonWarningFillLayerId =
      'eew_s_wave_non_warning_fill_layer';
  static const _sWaveWarningFillLayerId = 'eew_s_wave_warning_fill_layer';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final isRefreshing = useRef(false);
    final currentEews = useRef<List<EewV1>>([]);
    final controller = MapLibreInherited.of(context);

    final animationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );

    useEffect(() {
      animationController.repeat();
      animationController.addListener(() async {
        if (!isInitialized.value) {
          return;
        }
        if (!isRefreshing.value) {
          isRefreshing.value = true;
          try {
            final eews = ref.read(eewAliveNormalTelegramProvider);
            if (currentEews.value.isEmpty && eews.isEmpty) {
              return;
            }
            final activeEews = eews;
            currentEews.value = activeEews;
            final travelTimeMap = ref.read(travelTimeDepthMapProvider);
            final now = DateTime.now();

            final results =
                <
                  ({
                    TravelTimeResult result,
                    double lat,
                    double lon,
                    bool isWarning,
                  })
                >[];
            for (final eew in activeEews) {
              if (eew.isCanceled ||
                  eew.latitude == null ||
                  eew.longitude == null ||
                  eew.depth == null ||
                  eew.originTime == null) {
                continue;
              }

              final duration =
                  now.difference(eew.originTime!).inMilliseconds / 1000;
              final result = travelTimeMap.getTravelTime(eew.depth!, duration);
              results.add((
                result: result,
                lat: eew.latitude!,
                lon: eew.longitude!,
                isWarning: eew.isWarning ?? false,
              ));
            }

            final geojson = _createGeoJson(results);
            try {
              await controller.setGeoJsonSource(_sourceId, geojson);
              // ignore: avoid_catching_errors
            } on UnsupportedError catch (_) {}
          } finally {
            isRefreshing.value = false;
          }
        }
      });

      return null;
    }, [animationController]);

    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async => controller.synchronized(() async {
            // GeoJSONソースを追加
            await controller.addSource(
              _sourceId,
              GeojsonSourceProperties(data: jsonEncode(_createGeoJson([]))),
            );

            // P波レイヤーを追加
            await controller.addLayer(
              _pWaveBorderLayerId,
              _sourceId,
              LineLayerProperties(
                lineColor: Colors.blueAccent.toHexStringRGB(),
                lineWidth: 2,
              ),
              filter: ['==', 'type', 'p_wave'],
            );

            // S波レイヤーを追加
            await controller.addLayer(
              _sWaveNonWarningBorderLayerId,
              _sourceId,
              LineLayerProperties(
                lineColor: Colors.orangeAccent.toHexStringRGB(),
                lineWidth: 2,
              ),
              filter: [
                'all',
                ['==', 'type', 's_wave'],
                ['==', 'is_warning', false],
              ],
              belowLayerId: _pWaveBorderLayerId,
            );

            await controller.addLayer(
              _sWaveWarningBorderLayerId,
              _sourceId,
              LineLayerProperties(
                lineColor: Colors.redAccent.toHexStringRGB(),
                lineWidth: 2,
              ),
              filter: [
                'all',
                ['==', 'type', 's_wave'],
                ['==', 'is_warning', true],
              ],
              belowLayerId: _pWaveBorderLayerId,
            );

            await controller.addLayer(
              _sWaveNonWarningFillLayerId,
              _sourceId,
              FillLayerProperties(
                fillColor: Colors.orangeAccent.toHexStringRGB(),
                fillOpacity: 0.1,
              ),
              filter: [
                'all',
                ['==', 'type', 's_wave'],
                ['==', 'is_warning', false],
              ],
            );

            await controller.addLayer(
              _sWaveWarningFillLayerId,
              _sourceId,
              FillLayerProperties(
                fillColor: Colors.redAccent.toHexStringRGB(),
                fillOpacity: 0.1,
              ),
              filter: [
                'all',
                ['==', 'type', 's_wave'],
                ['==', 'is_warning', true],
              ],
            );

            isInitialized.value = true;
          }),
        ),
      );
      return () {
        isInitialized.value = false;
      };
    }, []);

    // EEWの状態が変更されたときにレイヤーを更新
    ref.listen(eewAliveNormalTelegramProvider, (_, eews) async {
      if (!isInitialized.value) {
        return;
      }
    });

    return const SizedBox.shrink();
  }

  static Map<String, dynamic> _createGeoJson(
    List<({TravelTimeResult result, double lat, double lon, bool isWarning})>
    results,
  ) {
    return {
      'type': 'FeatureCollection',
      'features': [
        for (final result in results) ...[
          // P波の円
          if (result.result.pDistance != null && result.result.pDistance! > 0)
            {
              'type': 'Feature',
              'geometry': {
                'type': 'Polygon',
                'coordinates': [
                  [
                    for (final bearing in Iterable<int>.generate(
                      91,
                      (index) => index * 4,
                    ))
                      () {
                        final point = const latlong2.Distance().offset(
                          latlong2.LatLng(result.lat, result.lon),
                          (result.result.pDistance! * 1000).toInt(),
                          bearing.toDouble(),
                        );
                        return [point.longitude, point.latitude];
                      }(),
                  ],
                ],
              },
              'properties': {'type': 'p_wave', 'is_warning': result.isWarning},
            },
          // S波の円
          if (result.result.sDistance != null && result.result.sDistance! > 0)
            {
              'type': 'Feature',
              'geometry': {
                'type': 'Polygon',
                'coordinates': [
                  [
                    for (final bearing in Iterable<int>.generate(
                      91,
                      (index) => index * 4,
                    ))
                      () {
                        final point = const latlong2.Distance().offset(
                          latlong2.LatLng(result.lat, result.lon),
                          (result.result.sDistance! * 1000).toInt(),
                          bearing.toDouble(),
                        );
                        return [point.longitude, point.latitude];
                      }(),
                  ],
                ],
              },
              'properties': {'type': 's_wave', 'is_warning': result.isWarning},
            },
        ],
      ],
    };
  }
}
