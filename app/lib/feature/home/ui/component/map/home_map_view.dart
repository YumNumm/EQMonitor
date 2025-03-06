import 'package:eqmonitor/feature/home/ui/component/map/home_map_layer_modal.dart';
import 'package:eqmonitor/feature/home/ui/component/map/kyoshin_monitor_scale_card.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layers/kyoshin_monitor_observation_layer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_settings_modal.dart';
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
    final mapConfigurationAsyncValue = ref.watch(
      mapConfigurationNotifierProvider,
    );
    final isStyleLoaded = useState(false);

    return mapConfigurationAsyncValue.when(
      data: (mapConfiguration) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            final position = MapCameraPosition.fitBounds(
              screenWidth: size.width,
              screenHeight: size.height,
              // 日本全体を表示
              bounds: (minLat: 28, minLng: 127, maxLat: 46, maxLng: 148),
            );

            return MapLibreMap(
              onEvent: (event) {
                if (event case MapEventStyleLoaded()) {
                  isStyleLoaded.value = true;
                }
                if (event is MapEventMoveCamera) {}
              },
              acceptLicense: true,
              options: MapOptions(
                initStyle: 'file://${mapConfiguration.styleString}',
                initCenter: Position(position.target.lon, position.target.lat),
                initZoom: position.zoom,
              ),
              children: [
                if (isStyleLoaded.value) const KyoshinMonitorObservationLayer(),
                SafeArea(child: _MapHeader(initialPosition: position)),
                const MapScalebar(alignment: Alignment.topCenter),
              ],
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      error:
          (error, stackTrace) => Center(child: Text('マップの読み込みに失敗しました: $error')),
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
