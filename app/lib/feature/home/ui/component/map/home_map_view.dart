import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_controller_card.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_layer_modal.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_hypocenter_symbol_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_ps_wave_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/kyoshin_monitor_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/shake_detection_layer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_settings_modal.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/ui/components/kyoshin_monitor_scale_card.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class HomeMapView extends HookConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationNotifierProvider);
    // final kyoshinMonitorState = ref.watch(kyoshinMonitorNotifierProvider);

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
    final isInitialized = useState(false);
    final controller = useState<MapLibreMapController?>(null);

    final map = MapLibreMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          initialCameraPosition.target.lat,
          initialCameraPosition.target.lon,
        ),
        zoom: initialCameraPosition.zoom,
      ),
      styleString: styleString,
      minMaxZoomPreference: const MinMaxZoomPreference(0, 12),
      onStyleLoadedCallback: () async {
        isInitialized.value = true;
      },
      onMapCreated: (c) => controller.value = c,
    );

    return SizedBox.expand(
      child: MapLibreInherited(
        controller: controller.value,
        child: Stack(
          children: [
            map,
            if (isInitialized.value) ...<MapLayer>[
              const KyoshinMonitorLayer(),
              const EewHypocenterSymbolLayer(),
              const EewPsWaveLayer(),
              const EewEstimatedIntensityLayer(),
              const ShakeDetectionLayer(),
            ],
            SafeArea(child: _MapHeader(initialPosition: initialCameraPosition)),
          ],
        ),
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
          child:
              useKmoni
                  ? Column(
                    key: const ValueKey('kyoshin_monitor_status_card'),
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KyoshinMonitorStatusCard(
                        onTap:
                            () async =>
                                KyoshinMonitorSettingsModal.show(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child:
                              showScaleCard
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
          onLocationButtonTap:
              () async => MapLibreInherited.of(context).animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(
                      initialPosition.target.lat,
                      initialPosition.target.lon,
                    ),
                    zoom: initialPosition.zoom,
                  ),
                ),
                duration: const Duration(milliseconds: 400),
              ),
        ),
      ],
    );
  }
}
