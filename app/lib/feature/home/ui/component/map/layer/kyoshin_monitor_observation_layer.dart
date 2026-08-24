import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/kyoshin_monitor_points_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class KyoshinMonitorObservationLayer extends ConsumerWidget {
  const new({super.key});

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
  const new();

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
    final markerType = ref.watch(
      kyoshinMonitorSettingsProvider.select(
        (value) =>
            value.value?.kmoniMarkerType ?? KyoshinMonitorMarkerType.onlyEew,
      ),
    );
    final hasActiveEew = ref.watch(
      eewAliveTelegramProvider.select((eews) => eews?.isNotEmpty ?? false),
    );

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
            return MapStyleResourceRemover.remove(
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
              markerType: markerType,
              hasActiveEew: hasActiveEew,
            ),
          );
          isLayerInitialized.value = true;
        }),
      );
      return null;
    }, [styleController, radiusScaleFactor, markerType, hasActiveEew]);

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
  const new();

  CircleStyleLayer build({
    required double radiusScaleFactor,
    required KyoshinMonitorMarkerType markerType,
    required bool hasActiveEew,
  }) {
    final showMarkerBorder = switch (markerType) {
      KyoshinMonitorMarkerType.always => true,
      KyoshinMonitorMarkerType.onlyEew => hasActiveEew,
      KyoshinMonitorMarkerType.never => false,
    };
    return CircleStyleLayer(
      id: KyoshinMonitorObservationLayer._layerId,
      sourceId: KyoshinMonitorObservationLayer._sourceId,
      paint: {
        // MapLibre iOS はズーム依存の式 (interpolate + zoom) が式ツリーの
        // 最上位にないと NSException を投げるため、係数は stop の出力値へ畳み込む
        'circle-radius': [
          'interpolate',
          ['linear'],
          ['zoom'],
          3,
          1 * radiusScaleFactor,
          10,
          10 * radiusScaleFactor,
        ],
        'circle-color': ['get', 'color'],
        'circle-stroke-color': '#808080',
        'circle-stroke-width': showMarkerBorder
            ? [
                'interpolate',
                ['linear'],
                ['zoom'],
                3,
                0.2 * radiusScaleFactor,
                10,
                1 * radiusScaleFactor,
              ]
            : 0,
      },
    );
  }
}
