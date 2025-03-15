import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_telegram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:maplibre/maplibre.dart';
import 'package:synchronized/extension.dart';

class EewPsWaveLayer extends HookConsumerWidget {
  const EewPsWaveLayer({super.key});

  static const _sourceId = 'eew_ps_wave_source';
  static const _pWaveLayerId = 'eew_p_wave_layer';
  static const _sWaveLayerId = 'eew_s_wave_layer';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final controller = MapController.of(context);

    final tickerProvider = useSingleTickerProvider();

    useEffect(() {
      tickerProvider.createTicker(print);
      return null;
    }, [tickerProvider]);

    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async => controller.synchronized(() async {
            // GeoJSONソースを追加
            await controller.style!.addSource(
              GeoJsonSource(
                id: _sourceId,
                data: jsonEncode(_createGeoJson([])),
              ),
            );

            // P波レイヤーを追加
            await controller.style!.addLayer(
              const LineStyleLayer(
                id: _pWaveLayerId,
                sourceId: _sourceId,
                paint: {'line-color': '#0000FF', 'line-width': 2},
              ),
            );

            // S波レイヤーを追加
            await controller.style!.addLayer(
              const LineStyleLayer(
                id: _sWaveLayerId,
                sourceId: _sourceId,
                paint: {'line-color': '#FF0000', 'line-width': 2},
              ),
            );

            isInitialized.value = true;
          }),
        ),
      );
      return () {
        isInitialized.value = false;
        unawaited(
          controller.synchronized(() async {
            await controller.style!.removeLayer(_pWaveLayerId);
            await controller.style!.removeLayer(_sWaveLayerId);
            await controller.style!.removeSource(_sourceId);
          }),
        );
      };
    }, []);

    // EEWの状態が変更されたときにレイヤーを更新
    ref.listen(eewProvider.select((value) => value.valueOrNull), (
      _,
      eews,
    ) async {
      if (!isInitialized.value) {
        return;
      }
      final activeEews = eews ?? [];
      final travelTimeMap = ref.read(travelTimeDepthMapProvider);
      final now = DateTime.now();

      final results = <({TravelTimeResult result, double lat, double lon})>[];
      for (final eew in activeEews) {
        if (eew.isCanceled ||
            eew.latitude == null ||
            eew.longitude == null ||
            eew.depth == null ||
            eew.originTime == null) {
          continue;
        }

        final duration = now.difference(eew.originTime!).inMilliseconds / 1000;
        final result = travelTimeMap.getTravelTime(eew.depth!, duration);
        results.add((result: result, lat: eew.latitude!, lon: eew.longitude!));
      }

      await controller.style!.updateGeoJsonSource(
        id: _sourceId,
        data: jsonEncode(_createGeoJson(results)),
      );
    });

    return const SizedBox.shrink();
  }

  static Map<String, dynamic> _createGeoJson(
    List<({TravelTimeResult result, double lat, double lon})> results,
  ) {
    return {
      'type': 'FeatureCollection',
      'features': [
        for (final result in results) ...[
          // P波の円
          if (result.result.pDistance != null)
            {
              'type': 'Feature',
              'geometry': {
                'type': 'LineString',
                'coordinates': [
                  for (var i = 0; i <= 360; i += 4)
                    () {
                      final point = const latlong2.Distance().offset(
                        latlong2.LatLng(result.lat, result.lon),
                        (result.result.pDistance! * 1000).toInt(),
                        i.toDouble(),
                      );
                      return [point.longitude, point.latitude];
                    }(),
                ],
              },
              'properties': {'type': 'p_wave'},
            },
          // S波の円
          if (result.result.sDistance != null)
            {
              'type': 'Feature',
              'geometry': {
                'type': 'LineString',
                'coordinates': [
                  for (var i = 0; i <= 360; i += 4)
                    () {
                      final point = const latlong2.Distance().offset(
                        latlong2.LatLng(result.lat, result.lon),
                        (result.result.sDistance! * 1000).toInt(),
                        i.toDouble(),
                      );
                      return [point.longitude, point.latitude];
                    }(),
                ],
              },
              'properties': {'type': 's_wave'},
            },
        ],
      ],
    };
  }
}
