import 'dart:async';

import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:synchronized/extension.dart';

class KyoshinMonitorLayer extends HookConsumerWidget implements MapLayer {
  const KyoshinMonitorLayer({super.key});

  static const _layerId = 'kyoshin_monitor_layer';
  static const _sourceId = 'kyoshin_monitor_source';

  @override
  String get layerId => _layerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final controller = MapLibreInherited.of(context);

    final strokeSetting = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.kmoniMarkerType),
    );
    final hasActiveEew = ref.watch(
      eewAliveTelegramProvider.select((v) => v?.isNotEmpty ?? false),
    );
    final showStroke = switch (strokeSetting) {
      KyoshinMonitorMarkerType.always => true,
      KyoshinMonitorMarkerType.onlyEew => hasActiveEew,
      KyoshinMonitorMarkerType.never => false,
    };

    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async => controller.synchronized(() async {
            // await controller.addSource(
            //   _sourceId,
            //   GeojsonSourceProperties(
            //     data: _convertAnalyzedPointsToGeoJson([]),
            //   ),
            // );
            await controller.addGeoJsonSource(
              _sourceId,
              _convertAnalyzedPointsToGeoJson([]),
            );

            await controller.addLayer(
              _layerId,
              _sourceId,
              CircleLayerProperties(
                circleColor: ['get', 'color'],
                circleRadius: [
                  'interpolate',
                  ['linear'],
                  ['zoom'],
                  3,
                  1,
                  10,
                  10,
                ],
                circleStrokeColor: Colors.grey.toHexStringRGB(),
                circleStrokeWidth:
                    showStroke
                        ? [
                          'interpolate',
                          ['linear'],
                          ['zoom'],
                          3,
                          0.2,
                          10,
                          1,
                        ]
                        : 0,
                circleSortKey: ['get', 'scale'],
              ),
            );
            isInitialized.value = true;
          }),
        ),
      );
      return () {
        isInitialized.value = false;
      };
    }, []);

    useEffect(() {
      unawaited(
        controller.synchronized(() async {
          await controller.setLayerProperties(
            _layerId,
            CircleLayerProperties(
              circleStrokeColor: Colors.grey.toHexStringRGB(),
              circleStrokeWidth:
                  showStroke
                      ? [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        3,
                        0.2,
                        10,
                        1,
                      ]
                      : 0,
            ),
          );
        }),
      );
      return null;
    }, [showStroke]);

    ref.listen(
      kyoshinMonitorNotifierProvider.select(
        (v) => v.valueOrNull?.analyzedPoints,
      ),
      (_, analyzedPoints) async {
        if (!isInitialized.value) {
          return;
        }
        final controller = MapLibreInherited.of(context);
        unawaited(
          controller.synchronized(() async {
            await controller.setGeoJsonSource(
              _sourceId,
              _convertAnalyzedPointsToGeoJson(analyzedPoints ?? []),
            );
          }),
        );
      },
    );

    ref.listen(kyoshinMonitorSettingsProvider.select((v) => v.useKmoni), (
      _,
      showLayer,
    ) {
      if (isInitialized.value) {
        unawaited(
          controller.synchronized(() async {
            await controller.setLayerProperties(
              _layerId,
              CircleLayerProperties(circleOpacity: showLayer ? 1.0 : 0.0),
            );
          }),
        );
      }
    });

    return const SizedBox.shrink();
  }

  static Map<String, dynamic> _convertAnalyzedPointsToGeoJson(
    Iterable<KyoshinMonitorImageParseObservationPoint> points,
  ) {
    return {
      'type': 'FeatureCollection',
      'features':
          points
              .map(
                (point) => {
                  'type': 'Feature',
                  'geometry': {
                    'type': 'Point',
                    'coordinates': [
                      point.point.location.longitude,
                      point.point.location.latitude,
                    ],
                  },
                  'properties': {
                    'scale': point.observation.scale,
                    'color': point.observation.color.toHexStringRGB(),
                  },
                },
              )
              .toList(),
    };
  }
}

extension on KyoshinMonitorObservationAnalyzedPoint {
  Color get color {
    final rgb = (r << 16) | (g << 8) | b;
    return Color(rgb);
  }
}
