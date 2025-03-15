import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/util/map_utility.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_layer_modal.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_hypocenter_symbol_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_ps_wave_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/kyoshin_monitor_layer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_settings_modal.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/ui/components/kyoshin_monitor_scale_card.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/components/controller/map_layer_controller_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

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
          print(cameraPosition);

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
    final controller = useState<MapController?>(null);

    return SizedBox.expand(
      child: MapLibreMap(
        acceptLicense: true,
        options: MapOptions(
          initStyle: 'file://$styleString',
          initZoom: initialCameraPosition.zoom,
          initCenter: Position(
            initialCameraPosition.target.lon,
            initialCameraPosition.target.lat,
          ),
        ),
        onStyleLoaded: (styleController) async {
          await ref
              .read(mapUtilityProvider)
              .addHypocenterImages(controller.value!);
          isInitialized.value = true;
        },
        onMapCreated: (c) => controller.value = c,
        children: [
          if (isInitialized.value) ...[
            const KyoshinMonitorLayer(),
            const EewHypocenterSymbolLayer(),
            const EewPsWaveLayer(),
            const EewEstimatedIntensityLayer(),
          ],
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
          child:
              useKmoni
                  ? Column(
                    key: const ValueKey('kyoshin_monitor_status_card'),
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
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
        MapLayerControllerCard(
          onLayerButtonTap: () async => HomeMapLayerModal.show(context),
          onLocationButtonTap:
              () async => MapController.of(context).animateCamera(
                nativeDuration: const Duration(milliseconds: 400),
                pitch: 0,
                bearing: 0,
                center: Position(
                  initialPosition.target.lon,
                  initialPosition.target.lat,
                ),
                zoom: initialPosition.zoom,
              ),
        ),
      ],
    );
  }
}
