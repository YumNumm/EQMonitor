import 'dart:async';
import 'dart:convert';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewHypocenterLayer extends HookConsumerWidget {
  const EewHypocenterLayer({required this.eews, super.key});

  final List<EewV1> eews;

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

    final showEews = eews.where(
      (eew) => eew.latitude != null && eew.longitude != null && !eew.isCanceled,
    );
    final normalEews = showEews
        .where(
          (eew) => !eew.isLowPrecise,
        )
        .toList();
    final lowPreciseEews = showEews
        .where(
          (eew) => eew.isLowPrecise,
        )
        .toList();

    final isInitialized = useRef(false);

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
          // 画像追加
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
            Map<String, dynamic> convert(EewV1 eew) => {
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [eew.longitude!, eew.latitude!],
              },
              'properties': {
                'magnitude': eew.magnitude,
                'depth': eew.depth,
              },
            };
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
          }(),
        );

        return null;
      },
      [styleController, normalEews],
    );

    useEffect(() {
      var visible = true;
      final timer = Timer.periodic(const Duration(milliseconds: 500), (
        _,
      ) async {
        if (styleController == null) {
          return;
        }
        final style = {
          'icon-allow-overlap': true,
          'icon-ignore-placement': true,
          'icon-size': [
            'interpolate',
            ['linear'],
            ['zoom'],
            3,
            0.3,
            20,
            2,
          ],
          'icon-opacity': visible ? 1 : 0.5,
        };
        await (
          styleController.updateLayer(
            layer: SymbolStyleLayer(
              id: layerId.lowPrecise,
              sourceId: sourceId.lowPrecise,
              layout: style,
            ),
          ),
          styleController.updateLayer(
            layer: SymbolStyleLayer(
              id: layerId.normal,
              sourceId: sourceId.normal,
              layout: style,
            ),
          ),
        ).wait;
        visible = !visible;
      });
      return () => timer.cancel;
    }, [styleController]);

    return const SizedBox.shrink();
  }
}

extension EewV1Extension on EewV1 {
  bool get isLowPrecise => isIpfOnePoint || isLevelEew || (isPlum ?? false);
}
