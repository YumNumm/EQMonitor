import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/util/color_converter.dart';
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
import 'package:maplibre/maplibre.dart';
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
          (_) async {
            final style = controller.style;
            if (style == null) return;
            
            await controller.synchronized(() async {
              await style.addSource(
                GeoJsonSource(
                  id: _sourceId,
                  data: jsonEncode(_convertAnalyzedPointsToGeoJson([])),
                ),
              );

              await style.addLayer(
                CircleStyleLayer(
                  id: _layerId,
                  sourceId: _sourceId,
                  paint: {
                    'circle-color': ['get', 'color'],
                    'circle-radius': [
                      'interpolate',
                      ['linear'],
                      ['zoom'],
                      3,
                      1,
                      10,
                      10,
                    ],
                    'circle-stroke-color': Colors.grey.toHexStringRGB(),
                    'circle-stroke-width': showStroke
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
                    'circle-sort-key': ['get', 'scale'],
                  },
                ),
              );
              isInitialized.value = true;
            });
          },
        ),
      );
      return () {
        isInitialized.value = false;
      };
    }, []);

    useEffect(() {
      unawaited(
        controller.synchronized(() async {
          final style = controller.style;
          if (isInitialized.value && style != null) {
            // Remove and re-add the layer with updated properties
            await style.removeLayer(_layerId);
            await style.addLayer(
              CircleStyleLayer(
                id: _layerId,
                sourceId: _sourceId,
                paint: {
                  'circle-color': ['get', 'color'],
                  'circle-radius': [
                    'interpolate',
                    ['linear'],
                    ['zoom'],
                    3,
                    1,
                    10,
                    10,
                  ],
                  'circle-stroke-color': Colors.grey.toHexStringRGB(),
                  'circle-stroke-width': showStroke
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
                  'circle-sort-key': ['get', 'scale'],
                },
              ),
            );
          }
        }),
      );
      return null;
    }, [showStroke, isInitialized.value]);

    ref.listen(
      kyoshinMonitorNotifierProvider.select(
        (v) => v.value?.analyzedPoints,
      ),
      (_, analyzedPoints) async {
        if (!isInitialized.value) {
          return;
        }
        final controller = MapLibreInherited.of(context);
        final style = controller.style;
        if (style == null) return;
        
        unawaited(
          controller.synchronized(() async {
            await style.updateGeoJsonSource(
              id: _sourceId,
              data: jsonEncode(_convertAnalyzedPointsToGeoJson(analyzedPoints ?? [])),
            );
          }),
        );
      },
    );

    ref.listen(kyoshinMonitorSettingsProvider.select((v) => v.useKmoni), (
      _,
      showLayer,
    ) {
      final style = controller.style;
      if (isInitialized.value && style != null) {
        unawaited(
          controller.synchronized(() async {
            // Remove and re-add the layer with updated opacity
            await style.removeLayer(_layerId);
            await style.addLayer(
              CircleStyleLayer(
                id: _layerId,
                sourceId: _sourceId,
                paint: {
                  'circle-color': ['get', 'color'],
                  'circle-radius': [
                    'interpolate',
                    ['linear'],
                    ['zoom'],
                    3,
                    1,
                    10,
                    10,
                  ],
                  'circle-stroke-color': Colors.grey.toHexStringRGB(),
                  'circle-stroke-width': showStroke
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
                  'circle-sort-key': ['get', 'scale'],
                  'circle-opacity': showLayer ? 1.0 : 0.0,
                },
              ),
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
      'features': points
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
