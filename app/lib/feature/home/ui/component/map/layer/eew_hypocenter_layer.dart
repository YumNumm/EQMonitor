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
  const EewHypocenterLayer({
    required this.eews,
    this.enableBlink = false,
    super.key,
  });

  final List<EewTelegramItem> eews;
  final bool enableBlink;

  static const ({String lowPrecise, String normal}) sourceId = (
    normal: 'eew-hypocenter-normal',
    lowPrecise: 'eew-hypocenter-low-precise',
  );
  static const ({String lowPrecise, String normal}) layerId = (
    normal: 'eew-hypocenter-normal',
    lowPrecise: 'eew-hypocenter-low-precise',
  );

  static Map<String, dynamic> _convertEew(EewTelegramItem eew, double opacity) {
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
        'opacity': opacity,
      },
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;

    final hypocenterEews = useMemoized(
      () {
        final normal = <EewTelegramItem>[];
        final lowPrecise = <EewTelegramItem>[];
        for (final eew in eews) {
          if (eew.hypocenter?.latitude == null ||
              eew.hypocenter?.longitude == null ||
              eew.isCanceled) {
            continue;
          }
          if (eew.isLowPreciseHypocenter) {
            lowPrecise.add(eew);
          } else {
            normal.add(eew);
          }
        }
        return (normal: normal, lowPrecise: lowPrecise);
      },
      [eews],
    );
    final normalEews = hypocenterEews.normal;
    final lowPreciseEews = hypocenterEews.lowPrecise;

    final isInitialized = useRef(false);

    // 点滅制御
    final isVisible = useState(true);
    useEffect(
      () {
        if (!enableBlink) {
          isVisible.value = true;
          return null;
        }
        final timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
          isVisible.value = !isVisible.value;
        });
        return timer.cancel;
      },
      [enableBlink],
    );

    final iconOpacity = isVisible.value ? 1.0 : 0.75;

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
                    0.15,
                    20,
                    0.4,
                  ],
                },
                paint: const {
                  'icon-opacity': ['get', 'opacity'],
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
                    0.15,
                    20,
                    0.4,
                  ],
                },
                paint: const {
                  'icon-opacity': ['get', 'opacity'],
                },
              ),
            ),
          ).wait;
          isInitialized.value = true;
          await (
            styleController.updateGeoJsonSource(
              id: sourceId.normal,
              data: jsonEncode({
                'type': 'FeatureCollection',
                'features': normalEews
                    .map((eew) => _convertEew(eew, iconOpacity))
                    .toList(),
              }),
            ),
            styleController.updateGeoJsonSource(
              id: sourceId.lowPrecise,
              data: jsonEncode({
                'type': 'FeatureCollection',
                'features': lowPreciseEews
                    .map((eew) => _convertEew(eew, iconOpacity))
                    .toList(),
              }),
            ),
          ).wait;
        }());

        return () async {
          isInitialized.value = false;
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
        if (styleController == null || !isInitialized.value) {
          return null;
        }

        unawaited(
          () async {
            try {
              await (
                styleController.updateGeoJsonSource(
                  id: sourceId.normal,
                  data: jsonEncode({
                    'type': 'FeatureCollection',
                    'features': normalEews
                        .map((eew) => _convertEew(eew, iconOpacity))
                        .toList(),
                  }),
                ),
                styleController.updateGeoJsonSource(
                  id: sourceId.lowPrecise,
                  data: jsonEncode({
                    'type': 'FeatureCollection',
                    'features': lowPreciseEews
                        .map((eew) => _convertEew(eew, iconOpacity))
                        .toList(),
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
      [styleController, normalEews, lowPreciseEews, iconOpacity],
    );

    return const SizedBox.shrink();
  }
}
