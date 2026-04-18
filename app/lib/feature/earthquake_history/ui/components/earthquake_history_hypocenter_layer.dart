import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の震源マーカー
class EarthquakeHistoryHypocenterLayer extends HookConsumerWidget {
  const EarthquakeHistoryHypocenterLayer({required this.earthquake, super.key});

  final Earthquake earthquake;

  static const _sourceId = 'earthquake-history-hypocenter';
  static const _layerId = 'earthquake-history-hypocenter-symbol';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final isInitialized = useRef(false);

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
          await styleController.addImageFromAssets(
            id: 'earthquake-history-hypocenter-icon',
            asset: Assets.images.map.normalHypocenter.path,
          );

          await styleController.addSource(
            GeoJsonSource(
              id: _sourceId,
              data: jsonEncode({
                'type': 'FeatureCollection',
                'features': <Map<String, dynamic>>[],
              }),
            ),
          );

          await styleController.addLayer(
            const SymbolStyleLayer(
              id: _layerId,
              sourceId: _sourceId,
              layout: {
                'icon-allow-overlap': true,
                'icon-ignore-placement': true,
                'icon-image': 'earthquake-history-hypocenter-icon',
                'icon-size': [
                  'interpolate',
                  ['linear'],
                  ['zoom'],
                  3,
                  0.3,
                  20,
                  2,
                ],
              },
            ),
          );
          isInitialized.value = true;
        }());

        return () async {
          await styleController.removeLayer(_layerId);
          await styleController.removeSource(_sourceId);
        };
      },
      [styleController],
    );

    useEffect(
      () {
        if (styleController == null || !isInitialized.value) {
          return null;
        }

        unawaited(
          () async {
            final hyp = earthquake.hypocenter;
            if (hyp == null) {
              await _clear(styleController);
              return;
            }
            final coords = hyp.coordinates;
            if (coords is! CoordinateLatLng) {
              await _clear(styleController);
              return;
            }

            try {
              await styleController.updateGeoJsonSource(
                id: _sourceId,
                data: jsonEncode({
                  'type': 'FeatureCollection',
                  'features': [
                    {
                      'type': 'Feature',
                      'geometry': {
                        'type': 'Point',
                        'coordinates': [coords.longitude, coords.latitude],
                      },
                      'properties': <String, dynamic>{},
                    },
                  ],
                }),
              );
            } on Exception catch (e) {
              talker.log(e);
            }
          }(),
        );

        return null;
      },
      [styleController, earthquake],
    );

    return const SizedBox.shrink();
  }

  Future<void> _clear(StyleController styleController) async {
    try {
      await styleController.updateGeoJsonSource(
        id: _sourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': <Map<String, dynamic>>[],
        }),
      );
    } on Exception catch (e) {
      talker.log(e);
    }
  }
}
