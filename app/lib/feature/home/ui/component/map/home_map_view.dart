import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/data/provider/map_camera_state_provider.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_controller_card.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_layer_modal.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_hypocenter_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_ps_wave_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_settings_modal.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/ui/components/kyoshin_monitor_scale_card.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class HomeMapView extends HookConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => _MapContent(
        styleString: value.styleString!,
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _MapContent extends HookConsumerWidget {
  const _MapContent({required this.styleString});

  final String styleString;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialOptions = calculateJapanViewMapOptions(
      context: context,
      styleString: styleString,
    );

    return MapLibreEventProvider(
      child: Builder(
        builder: (context) {
          final mapWidget = MapLibreMap(
            options: initialOptions,
            onMapCreated: (controller) {
              ref
                  .read(homeMapCameraStateProvider.notifier)
                  .setController(controller);
            },
            onEvent: (event) => MapLibreEventProvider.of(context).emit(event),
            children: [
              Consumer(
                builder: (context, ref, _) {
                  final regions = ref
                      .watch(eewAliveTelegramProvider)
                      ?.map((eew) => eew.forecastIntensity?.regions)
                      .nonNulls
                      .flattened
                      .toList();
                  return EewEstimatedIntensityLayer(
                    eewRegions: regions ?? [],
                  );
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
                builder: (context, ref, _) => EewHypocenterLayer(
                  eews: ref.watch(eewAliveTelegramProvider) ?? [],
                ),
              ),
              const SafeArea(child: _MapHeader()),
            ],
          );

          return SizedBox.expand(child: mapWidget);
        },
      ),
    );
  }
}

class _MapHeader extends ConsumerWidget {
  const _MapHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useKmoni = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.useKmoni),
    );
    final showScale = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.showScale),
    );

    final kyoshinMonitorColumn = Column(
      key: const ValueKey('kyoshin_monitor_status_card'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KyoshinMonitorStatusCard(
          onTap: () async => KyoshinMonitorSettingsModal.show(context),
        ),
        if (showScale)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: KyoshinMonitorScaleCard(),
          ),
      ],
    );

    final controllerCard = HomeMapControllerCard(
      onLayerButtonTap: () async => HomeMapLayerModal.show(context),
      onLocationButtonTap: () async {
        await ref.read(homeMapCameraStateProvider.notifier).returnToHome();
      },
    );

    return Row(
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
    );
  }
}
