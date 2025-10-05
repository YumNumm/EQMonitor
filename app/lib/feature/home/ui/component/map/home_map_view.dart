import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_controller_card.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_layer_modal.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_settings_modal.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/ui/components/kyoshin_monitor_scale_card.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeMapView extends HookConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);
    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => LayoutBuilder(
        builder: (context, constraints) {
          final cameraPosition = MapCameraPosition.fitBounds(
            screenWidth: constraints.maxWidth,
            screenHeight: constraints.maxHeight,
            bounds: (minLat: 30, minLng: 128.8, maxLat: 45.8, maxLng: 145.1),
            padding: 16,
          );

          return _MapView(
            styleString: value.styleString!,
            initialCameraPosition: cameraPosition,
          );
        },
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _MapView extends HookConsumerWidget {
  const _MapView({
    required this.styleString,
    required this.initialCameraPosition,
  });

  final String styleString;
  final MapCameraPosition initialCameraPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox.expand(
      child: Stack(
        children: [
          SafeArea(child: _MapHeader(initialPosition: initialCameraPosition)),
        ],
      ),
    );
  }
}

class _MapHeader extends ConsumerWidget {
  const _MapHeader({required this.initialPosition});

  final MapCameraPosition initialPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useKmoni = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.useKmoni),
    );
    final showScaleCard = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.showScale),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: useKmoni
              ? Column(
                  key: const ValueKey('kyoshin_monitor_status_card'),
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KyoshinMonitorStatusCard(
                      onTap: () async =>
                          KyoshinMonitorSettingsModal.show(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: showScaleCard
                            ? const KyoshinMonitorScaleCard()
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        const Column(),
        HomeMapControllerCard(
          onLayerButtonTap: () async => HomeMapLayerModal.show(context),
          onLocationButtonTap: () async => throw UnimplementedError(),
        ),
      ],
    );
  }
}
