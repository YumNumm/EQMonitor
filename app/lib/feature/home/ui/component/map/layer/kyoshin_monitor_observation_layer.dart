import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/kyoshin_monitor_points_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon_data.dart';
import 'package:eqmonitor/feature/map/features/icon/data/provider/intensity_icon_provider.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class const KyoshinMonitorObservationLayer({super.key}) extends ConsumerWidget {
  static const _sourceId = 'kyoshin-monitor-observations';
  static const _layerId = 'kyoshin-monitor-circles';
  static const _iconLayerId = 'kyoshin-monitor-intensity-icons';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useKmoni = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.value?.useKmoni ?? false),
    );
    final isReplay = ref.watch(isReplayModeProvider);
    if (!useKmoni && !isReplay) {
      return const SizedBox.shrink();
    }
    return const _KyoshinMonitorObservationLayerBody();
  }
}

class const _KyoshinMonitorObservationLayerBody() extends HookConsumerWidget {
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

    final iconData = ref.watch(intensityIconProvider).value;
    final hasIcon = iconData != null;

    final isLayerInitialized = useRef(false);
    final registeredIconData = useRef<IntensityIconData?>(null);
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
      registeredIconData.value = null;
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
              layerIds: const [
                KyoshinMonitorObservationLayer._iconLayerId,
                KyoshinMonitorObservationLayer._layerId,
              ],
              sourceIds: const [KyoshinMonitorObservationLayer._sourceId],
            );
          }),
        );
      };
    }, [styleController]);

    useEffect(() {
      final token = lifecycleToken.value;
      final initialized = initialization.value;
      if (styleController == null ||
          token == null ||
          initialized == null ||
          iconData == null) {
        return null;
      }
      unawaited(
        enqueue(() async {
          await initialized;
          if (lifecycleToken.value != token ||
              identical(registeredIconData.value, iconData)) {
            return;
          }
          await styleController.addImages(iconData.toMapStyleImages);
          registeredIconData.value = iconData;
        }),
      );
      return null;
    }, [styleController, iconData]);

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
            await MapStyleResourceRemover.remove(
              styleController: styleController,
              layerIds: const [
                KyoshinMonitorObservationLayer._iconLayerId,
                KyoshinMonitorObservationLayer._layerId,
              ],
            );
          }
          if (lifecycleToken.value != token) {
            return;
          }
          for (final layer
              in const KyoshinMonitorObservationLayerBuilder().buildStyleLayers(
                radiusScaleFactor: radiusScaleFactor,
                markerType: markerType,
                hasActiveEew: hasActiveEew,
                hasIcon: hasIcon,
              )) {
            await styleController.addLayer(
              layer,
              belowLayerId: BaseLayer.foregroundOverlayAnchor.name,
            );
          }
          isLayerInitialized.value = true;
        }),
      );
      return null;
    }, [styleController, radiusScaleFactor, markerType, hasActiveEew, hasIcon]);

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

class const KyoshinMonitorObservationLayerBuilder() {
  // リアルタイム震度は scale * 10 - 3 で求めるため、境界値ちょうどの観測点が
  // 浮動小数誤差で 1 階級下に落ちないよう閾値を僅かに下げる。
  static const _boundaryTolerance = 0.001;
  static const iconTextMinZoom = 7.0;

  static const _intensityStops = <(double, JmaIntensity)>[
    (0.5, JmaIntensity.one),
    (1.5, JmaIntensity.two),
    (2.5, JmaIntensity.three),
    (3.5, JmaIntensity.four),
    (4.5, JmaIntensity.fiveLower),
    (5.0, JmaIntensity.fiveUpper),
    (5.5, JmaIntensity.sixLower),
    (6.0, JmaIntensity.sixUpper),
    (6.5, JmaIntensity.seven),
  ];

  List<StyleLayer> buildStyleLayers({
    required double radiusScaleFactor,
    required KyoshinMonitorMarkerType markerType,
    required bool hasActiveEew,
    required bool hasIcon,
  }) => [
    build(
      radiusScaleFactor: radiusScaleFactor,
      markerType: markerType,
      hasActiveEew: hasActiveEew,
      hasIcon: hasIcon,
    ),
    if (hasIcon) buildIconLayer(radiusScaleFactor: radiusScaleFactor),
  ];

  SymbolStyleLayer buildIconLayer({required double radiusScaleFactor}) {
    return SymbolStyleLayer(
      id: KyoshinMonitorObservationLayer._iconLayerId,
      sourceId: KyoshinMonitorObservationLayer._sourceId,
      filter: const [
        'all',
        ['has', 'intensity'],
        [
          '>=',
          ['get', 'intensity'],
          -_boundaryTolerance,
        ],
      ],
      layout: {
        'icon-image': [
          'step',
          ['zoom'],
          _iconImageExpression(IntensityIconType.smallWithoutText),
          iconTextMinZoom,
          _iconImageExpression(IntensityIconType.small),
        ],
        'icon-allow-overlap': true,
        'icon-ignore-placement': true,
        'symbol-sort-key': ['get', 'intensity'],
        'icon-size': [
          'interpolate',
          ['linear'],
          ['zoom'],
          3,
          0.03 * radiusScaleFactor,
          7,
          0.13 * radiusScaleFactor,
          20,
          0.5 * radiusScaleFactor,
        ],
      },
    );
  }

  List<Object> _iconImageExpression(IntensityIconType type) => [
    'step',
    ['get', 'intensity'],
    'JmaIntensity.${type.name}.${JmaIntensity.zero.name}',
    for (final (threshold, intensity) in _intensityStops) ...[
      threshold - _boundaryTolerance,
      'JmaIntensity.${type.name}.${intensity.name}',
    ],
  ];

  CircleStyleLayer build({
    required double radiusScaleFactor,
    required KyoshinMonitorMarkerType markerType,
    required bool hasActiveEew,
    required bool hasIcon,
  }) {
    final showMarkerBorder = switch (markerType) {
      KyoshinMonitorMarkerType.always => true,
      KyoshinMonitorMarkerType.onlyEew => hasActiveEew,
      KyoshinMonitorMarkerType.never => false,
    };
    // 欠測中の観測点は枠の設定によらず、枠線だけを描く。
    Object strokeWidth(double width) => showMarkerBorder
        ? width
        : [
            'case',
            ['has', 'lost'],
            width,
            0,
          ];
    return CircleStyleLayer(
      id: KyoshinMonitorObservationLayer._layerId,
      sourceId: KyoshinMonitorObservationLayer._sourceId,
      filter: hasIcon
          ? const [
              'any',
              [
                '!',
                ['has', 'intensity'],
              ],
              [
                '<',
                ['get', 'intensity'],
                -_boundaryTolerance,
              ],
            ]
          : null,
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
        'circle-color': [
          'coalesce',
          ['get', 'color'],
          '#808080',
        ],
        'circle-opacity': [
          'case',
          ['has', 'lost'],
          0,
          1,
        ],
        'circle-stroke-color': '#808080',
        'circle-stroke-width': [
          'interpolate',
          ['linear'],
          ['zoom'],
          3,
          strokeWidth(0.2 * radiusScaleFactor),
          10,
          strokeWidth(1 * radiusScaleFactor),
        ],
      },
    );
  }
}
