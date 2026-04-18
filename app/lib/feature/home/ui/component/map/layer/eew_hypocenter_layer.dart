import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewHypocenterLayer extends HookConsumerWidget {
  const EewHypocenterLayer({required this.eews, super.key});

  final List<EewTelegramItem> eews;

  static const ({String lowPrecise, String normal}) sourceId = (
    normal: 'eew-hypocenter-normal',
    lowPrecise: 'eew-hypocenter-low-precise',
  );
  static const ({String lowPrecise, String normal}) layerId = (
    normal: 'eew-hypocenter-normal',
    lowPrecise: 'eew-hypocenter-low-precise',
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;

    final showEews = eews.where((eew) {
      return (eew.hypocenter?.hasLatLng ?? false) && !eew.isCanceled;
    });
    final normalEews = showEews.where((eew) => !eew.isPlum).toList();
    final lowPreciseEews = showEews.where((eew) => eew.isPlum).toList();

    final isInitialized = useRef(false);

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
          await (
            styleController.addImageFromAssets(
              id: 'normal-hypocenter',
              asset: Assets.images.map.normalHypocenter.path,
            ),
            styleController.addImageFromAssets(
              id: 'low-precise-hypocenter',
              asset: Assets.images.map.lowPreciseHypocenter.path,
            ),
          ).wait;

          await (
            styleController.addSource(
              GeoJsonSource(
                id: sourceId.normal,
                data: jsonEncode({
                  'type': 'FeatureCollection',
                  'features': <Map<String, dynamic>>[],
                }),
              ),
            ),
            styleController.addSource(
              GeoJsonSource(
                id: sourceId.lowPrecise,
                data: jsonEncode({
                  'type': 'FeatureCollection',
                  'features': <Map<String, dynamic>>[],
                }),
              ),
            ),
          ).wait;

          await (
            styleController.addLayer(
              SymbolStyleLayer(
                id: layerId.normal,
                sourceId: sourceId.normal,
                layout: {
                  'icon-allow-overlap': true,
                  'icon-ignore-placement': true,
                  'icon-image': 'normal-hypocenter',
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
            ),
            styleController.addLayer(
              SymbolStyleLayer(
                id: layerId.lowPrecise,
                sourceId: sourceId.lowPrecise,
                layout: {
                  'icon-allow-overlap': true,
                  'icon-ignore-placement': true,
                  'icon-image': 'low-precise-hypocenter',
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
            ),
          ).wait;
          isInitialized.value = true;
        }());

        return () async {
          await styleController.removeLayer(layerId.normal);
          await styleController.removeLayer(layerId.lowPrecise);
          await styleController.removeSource(sourceId.normal);
          await styleController.removeSource(sourceId.lowPrecise);
        };
      },
      [styleController],
    );

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(
          () async {
            Map<String, dynamic> convert(EewTelegramItem eew) {
              final hypo = eew.hypocenter!;
              return {
                'type': 'Feature',
                'geometry': {
                  'type': 'Point',
                  'coordinates': [hypo.longitude, hypo.latitude],
                },
                'properties': {
                  'magnitude': hypo.magnitude,
                  'depth': hypo.depth,
                },
              };
            }

            try {
              await (
                styleController.updateGeoJsonSource(
                  id: sourceId.normal,
                  data: jsonEncode({
                    'type': 'FeatureCollection',
                    'features': normalEews.map(convert).toList(),
                  }),
                ),
                styleController.updateGeoJsonSource(
                  id: sourceId.lowPrecise,
                  data: jsonEncode({
                    'type': 'FeatureCollection',
                    'features': lowPreciseEews.map(convert).toList(),
                  }),
                ),
              ).wait;
            } on Exception catch (e) {
              talker.log(e);
            }
          }(),
        );

        return null;
      },
      [styleController, normalEews],
    );

    return const SizedBox.shrink();
  }
}
