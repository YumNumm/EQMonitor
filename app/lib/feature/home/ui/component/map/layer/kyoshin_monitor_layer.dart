import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/extension/color_extension.dart';
import 'package:eqmonitor/feature/eew/data/eew_telegram.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:maplibre/maplibre.dart';
import 'package:synchronized/extension.dart';

class KyoshinMonitorLayer extends HookConsumerWidget {
  const KyoshinMonitorLayer({super.key});

  static const _layerId = 'kyoshin_monitor_layer';
  static const _sourceId = 'kyoshin_monitor_source';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final controller = MapController.of(context);
    final manager = useMemoized(_KyoshinMonitorPaintManager.new);

    final strokeSetting = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.kmoniMarkerType),
    );
    final hasActiveEew = ref.watch(
      eewProvider.select((eews) => eews.valueOrNull?.isNotEmpty ?? false),
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
            await controller.style!.addSource(
              GeoJsonSource(
                id: _sourceId,
                data: _convertAnalyzedPointsToGeoJson([]),
              ),
            );

            await controller.style!.addLayer(
              CircleStyleLayer(
                id: _layerId,
                sourceId: _sourceId,
                paint: manager.json(showStroke: showStroke),
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
            await controller.style!.removeLayer(_layerId);
            await controller.style!.removeSource(_sourceId);
          }),
        );
      };
    }, []);

    useEffect(() {
      unawaited(
        controller.synchronized(() async {
          await controller.style!.updateLayer(
            CircleStyleLayer(
              id: _layerId,
              sourceId: _sourceId,
              paint: manager.json(showStroke: showStroke),
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
        final controller = MapController.of(context);
        unawaited(
          controller.synchronized(() async {
            await controller.style!.updateGeoJsonSource(
              id: _sourceId,
              data: _convertAnalyzedPointsToGeoJson(analyzedPoints ?? []),
            );
          }),
        );
      },
    );

    return const SizedBox.shrink();
  }

  static String _convertAnalyzedPointsToGeoJson(
    Iterable<KyoshinMonitorImageParseObservationPoint> points,
  ) {
    return jsonEncode({
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
    });
  }
}

extension on KyoshinMonitorObservationAnalyzedPoint {
  Color get color {
    final rgb = (r << 16) | (g << 8) | b;
    return Color(rgb);
  }
}

class _KyoshinMonitorPaintManager {
  Map<String, Object> json({required bool showStroke}) => {
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
    'circle-stroke-width': [
      'interpolate',
      ['linear'],
      ['zoom'],
      3,
      0.2,
      10,
      1,
    ],
    if (showStroke) ...{
      'circle-stroke-color': Colors.grey.toHexStringRGB(),
      'circle-stroke-width': [
        'interpolate',
        ['linear'],
        ['zoom'],
        3,
        0.2,
        10,
        1,
      ],
    } else ...{
      'circle-stroke-color': '#00000000',
      'circle-stroke-width': 0,
    },
    'circle-sort-key': ['get', 'scale'],
  };
}
