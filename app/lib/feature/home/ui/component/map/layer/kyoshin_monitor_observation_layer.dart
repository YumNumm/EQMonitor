import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/kyoshin_monitor_points_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class KyoshinMonitorObservationLayer extends ConsumerWidget {
  const KyoshinMonitorObservationLayer({super.key});

  static const _sourceId = 'kyoshin-monitor-observations';
  static const _layerId = 'kyoshin-monitor-circles';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useKmoni = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.value?.useKmoni ?? false),
    );
    if (!useKmoni) {
      return const SizedBox.shrink();
    }
    return const _KyoshinMonitorObservationLayerBody();
  }
}

class _KyoshinMonitorObservationLayerBody extends HookConsumerWidget {
  const _KyoshinMonitorObservationLayerBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;

    final markerSize = ref.watch(
      homeConfigurationProvider.select(
        (a) => a.value?.kyoshinMonitor.markerSize ?? HomeKmoniMarkerSize.medium,
      ),
    );
    final radiusScaleFactor = switch (markerSize) {
      HomeKmoniMarkerSize.small => 0.65,
      HomeKmoniMarkerSize.medium => 1.0,
      HomeKmoniMarkerSize.large => 1.35,
    };

    final isLayerInitialized = useRef(false);
    final lifecycleToken = useRef<Object?>(null);
    final initialization = useRef<Future<void>?>(null);
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      final token = Object();
      lifecycleToken.value = token;
      isLayerInitialized.value = false;
      initialization.value = enqueue(() async {
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addSource(
          GeoJsonSource(
            id: KyoshinMonitorObservationLayer._sourceId,
            data: jsonEncode({
              'type': 'FeatureCollection',
              'features': <Map<String, dynamic>>[],
            }),
          ),
        );
      });
      return () {
        if (lifecycleToken.value == token) {
          lifecycleToken.value = null;
        }
        unawaited(
          enqueue(() {
            return removeMapStyleResources(
              styleController: styleController,
              layerIds: const [KyoshinMonitorObservationLayer._layerId],
              sourceIds: const [KyoshinMonitorObservationLayer._sourceId],
            );
          }),
        );
      };
    }, [styleController]);

    useEffect(() {
      final token = lifecycleToken.value;
      final initialized = initialization.value;
      if (styleController == null || token == null || initialized == null) {
        return null;
      }
      unawaited(
        enqueue(() async {
          await initialized;
          if (lifecycleToken.value != token) {
            return;
          }
          if (isLayerInitialized.value) {
            await styleController.removeLayer(
              KyoshinMonitorObservationLayer._layerId,
            );
          }
          if (lifecycleToken.value != token) {
            return;
          }
          await styleController.addLayer(
            const KyoshinMonitorObservationLayerBuilder().build(
              radiusScaleFactor: radiusScaleFactor,
            ),
          );
          isLayerInitialized.value = true;
        }),
      );
      return null;
    }, [styleController, radiusScaleFactor]);

    useEffect(() {
      final token = lifecycleToken.value;
      final initialized = initialization.value;
      if (styleController == null || token == null || initialized == null) {
        return null;
      }

      final subscription = ref.listenManual(
        homeKyoshinMonitorObservationGeoJsonProvider,
        (_, next) {
          unawaited(
            enqueue(() async {
              await initialized;
              if (lifecycleToken.value != token) {
                return;
              }
              final sw = Stopwatch()..start();
              await Timeline.timeSync(
                'kmoni.updateGeoJsonSource',
                () async => styleController.updateGeoJsonSource(
                  id: KyoshinMonitorObservationLayer._sourceId,
                  data: next,
                ),
                arguments: {
                  'sourceId': KyoshinMonitorObservationLayer._sourceId,
                  'nextDataLength': next.length,
                },
              );
              sw.stop();
            }),
          );
        },
        fireImmediately: true,
      );
      return subscription.close;
    }, [styleController]);

    return const SizedBox.shrink();
  }
}

class KyoshinMonitorObservationLayerBuilder {
  const KyoshinMonitorObservationLayerBuilder();

  CircleStyleLayer build({required double radiusScaleFactor}) =>
      CircleStyleLayer(
        id: KyoshinMonitorObservationLayer._layerId,
        sourceId: KyoshinMonitorObservationLayer._sourceId,
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
            'interpolate',
            ['linear'],
            ['zoom'],
            3,
            0.2 * radiusScaleFactor,
            10,
            radiusScaleFactor,
          ],
        },
      );
}
