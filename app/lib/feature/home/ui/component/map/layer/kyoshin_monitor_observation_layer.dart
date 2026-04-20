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
import 'package:synchronized/synchronized.dart';

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
    if (styleController == null || !useKmoni) {
      return const SizedBox.shrink();
    }

    final markerSize = ref.watch(
      homeConfigurationProvider.select(
        (a) => a.value?.kyoshinMonitor.markerSize ?? HomeKmoniMarkerSize.medium,
      ),
    );
    final radiusScaleFactor = switch (markerSize) {
      HomeKmoniMarkerSize.small => 0.65,
      HomeKmoniMarkerSize.medium => 1,
      HomeKmoniMarkerSize.large => 1.35,
    };
    final lock = useMemoized(Lock.new, []);

    useEffect(
      () {
        unawaited(
          lock.synchronized(
            () async {
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
                CircleStyleLayer(
                  id: _layerId,
                  sourceId: _sourceId,
                  paint: {
                    'circle-radius': [
                      'interpolate',
                      ['linear'],
                      ['zoom'],
                      3,
                      1,
                      10,
                      10,
                    ],
                    'circle-color': ['get', 'color'],
                    'circle-stroke-color': '#808080',
                    'circle-stroke-width': [
                      '*',
                      radiusScaleFactor,
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
            },
          ),
        );
        return () async => unawaited(
          lock.synchronized(
            () async {
              await styleController.removeLayer(_layerId);
              await styleController.removeSource(_sourceId);
            },
          ),
        );
      },
      [styleController, useKmoni, radiusScaleFactor],
    );

    useEffect(
      () {
        if (!useKmoni) {
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
      [
        styleController,
        useKmoni,
      ],
    );

    return const SizedBox.shrink();
  }
}
