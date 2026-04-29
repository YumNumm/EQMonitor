import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/debug/replay/debug_replay_modal.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_station_icon_preloader.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/map_camera_state_provider.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_controller_card.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_options.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_hypocenter_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_ps_wave_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_warning_regions_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/shake_detection_layer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/connection_status_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/ui/components/kyoshin_monitor_scale_card.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class HomeMapView extends ConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => _MapContent(
        styleString: value.styleString!,
      ),
      AsyncError(:final error) => Center(
        child: ErrorCard(error: error),
      ),
      _ => Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.xl,
            vertical: spacing.lg,
          ),
          decoration: BoxDecoration(
            color: color.surfaceCard.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(designSystem.shape.card),
            border: Border.all(color: color.outlineSoft),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator.adaptive(),
              SizedBox(height: spacing.md),
              Text('地図を準備しています', style: typography.bodyMedium),
            ],
          ),
        ),
      ),
    };
  }
}

class _MapContent extends ConsumerWidget {
  const _MapContent({required this.styleString});

  final String styleString;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeConfigurationProvider);
    final mapSettings = homeAsync.value?.map ?? const HomeMapSettings();

    final mapOptions = homeMapOptionsFromSettings(
      context: context,
      styleString: styleString,
      map: mapSettings,
    );

    final mapKey = Object.hash(
      mapSettings.maxZoom,
      mapSettings.lockBearing,
      mapSettings.defaultBounds,
      mapSettings.customBounds,
    );

    return MapLibreEventProvider(
      child: Builder(
        builder: (context) {
          final mapWidget = MapLibreMap(
            key: ValueKey(mapKey),
            options: mapOptions,
            onMapCreated: (controller) {
              ref
                  .read(homeMapCameraStateProvider.notifier)
                  .setController(controller);
            },
            onEvent: (event) =>
                MapLibreEventProvider.maybeOf(context)?.emit(event),
            children: [
              Consumer(
                builder: (context, ref, _) {
                  final fillMode = ref.watch(
                    homeConfigurationProvider.select(
                      (a) => a.value?.eew.fillMode ?? HomeEewFillMode.intensity,
                    ),
                  );
                  final eews = ref.watch(eewAliveTelegramProvider) ?? [];
                  final regions = eews
                      .map((eew) => eew.forecastIntensity?.regions)
                      .nonNulls
                      .flattened
                      .toList();
                  return switch (fillMode) {
                    HomeEewFillMode.intensity => EewEstimatedIntensityLayer(
                      eewRegions: regions,
                    ),
                    HomeEewFillMode.warning => EewWarningRegionsLayer(
                      eews: eews,
                    ),
                    HomeEewFillMode.none => const SizedBox.shrink(),
                  };
                },
              ),
              const KyoshinMonitorObservationLayer(),
              Consumer(
                builder: (context, ref, _) {
                  final eews = ref.watch(eewAliveTelegramProvider) ?? [];
                  return EewPsWaveLayer(eews: eews);
                },
              ),
              Consumer(
                builder: (context, ref, _) => ShakeDetectionLayer(
                  events: ref.watch(shakeDetectionVisibleProvider),
                ),
              ),
              Consumer(
                builder: (context, ref, _) => EewHypocenterLayer(
                  eews: ref.watch(eewAliveTelegramProvider) ?? [],
                ),
              ),
              const SafeArea(child: _MapHeader()),
            ],
          );

          return Stack(
            children: [
              SizedBox.expand(child: mapWidget),
              // アプリ起動時に観測点震度アイコンを事前レンダリングする
              const EarthquakeHistoryStationIconPreloader(),
            ],
          );
        },
      ),
    );
  }
}

class _MapHeader extends ConsumerWidget {
  const _MapHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useKmoni =
        ref.watch(
          kyoshinMonitorSettingsProvider.select((v) => v.value?.useKmoni),
        ) ??
        false;
    final showScale =
        ref.watch(
          kyoshinMonitorSettingsProvider.select((v) => v.value?.showScale),
        ) ??
        false;

    final kyoshinMonitorColumn = Column(
      key: const ValueKey('kyoshin_monitor_status_card'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KyoshinMonitorStatusCard(
          onTap: () async => const HomeMapLayerRoute().push<void>(context),
        ),
        const ConnectionStatusCard(),
        if (showScale)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: KyoshinMonitorScaleCard(),
          ),
      ],
    );

    final isDebug = ref.watch(debugProvider).value ?? false;

    final controllerCard = HomeMapControllerCard(
      onLayerButtonTap: () async =>
          const HomeMapLayerRoute().push<void>(context),
      onLocationButtonTap: () =>
          ref.read(homeMapCameraStateProvider.notifier).returnToHome(),
      onDebugButtonTap:
          isDebug ? () => DebugReplayModal.show(context) : null,
    );

    return Padding(
      padding: EdgeInsets.all(context.designSystem.spacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: useKmoni ? kyoshinMonitorColumn : const SizedBox.shrink(),
          ),
          const Column(),
          controllerCard,
        ],
      ),
    );
  }
}
