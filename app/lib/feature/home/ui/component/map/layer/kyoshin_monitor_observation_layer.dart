import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/kyoshin_monitor_points_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

double _markerRadiusScale(HomeKmoniMarkerSize size) {
  return switch (size) {
    HomeKmoniMarkerSize.small => 0.65,
    HomeKmoniMarkerSize.medium => 1,
    HomeKmoniMarkerSize.large => 1.35,
  };
}

class KyoshinMonitorObservationLayer extends HookConsumerWidget {
  const KyoshinMonitorObservationLayer({super.key});

  static const _sourceId = 'kyoshin-monitor-observations';
  static const _layerId = 'kyoshin-monitor-circles';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = MapController.of(context);
    final styleController = controller.style;
    final useKmoni = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.value?.useKmoni ?? false),
    );
    final markerSize = ref.watch(
      homeConfigurationProvider.select(
        (a) => a.value?.kyoshinMonitor.markerSize ?? HomeKmoniMarkerSize.medium,
      ),
    );
    final radiusScale = _markerRadiusScale(markerSize);

    useEffect(
      () {
        if (styleController == null || !useKmoni) {
          return null;
        }

        unawaited(_initializeLayer(styleController, radiusScale));

        return () {
          unawaited(_cleanupLayer(styleController));
        };
      },
      [styleController, useKmoni, radiusScale],
    );

    useEffect(
      () {
        if (styleController == null || !useKmoni) {
          return null;
        }

        ref.listenManual(
          homeKyoshinMonitorObservationGeoJsonProvider,
          (_, next) async {
            final sw = Stopwatch()..start();
            await Timeline.timeSync(
              'kmoni.updateGeoJsonSource',
              () async => styleController.updateGeoJsonSource(
                id: _sourceId,
                data: next,
              ),
            );
            sw.stop();
          },
        );
        return null;
      },
      [styleController, useKmoni],
    );

    return const SizedBox.shrink();
  }

  Future<void> _initializeLayer(
    StyleController style,
    double radiusScale,
  ) async {
    await style.addSource(
      GeoJsonSource(
        id: _sourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': <Map<String, dynamic>>[],
        }),
      ),
    );

    await style.addLayer(
      CircleStyleLayer(
        id: _layerId,
        sourceId: _sourceId,
        paint: {
          'circle-radius': [
            '*',
            radiusScale,
            [
              'interpolate',
              ['linear'],
              ['zoom'],
              3,
              1,
              10,
              10,
            ],
          ],
          'circle-color': ['get', 'color'],
          'circle-stroke-color': '#808080',
          'circle-stroke-width': [
            '*',
            radiusScale,
            [
              'interpolate',
              ['linear'],
              ['zoom'],
              3,
              0.2,
              10,
              1,
            ],
          ],
        },
      ),
    );
  }

  Future<void> _cleanupLayer(StyleController style) async {
    await style.removeLayer(_layerId);
    await style.removeSource(_sourceId);
  }
}
