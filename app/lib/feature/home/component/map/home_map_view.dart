import 'package:eqmonitor/core/utils/map_camera_position_helper.dart';
import 'package:eqmonitor/feature/home/component/map/home_map_content.dart';
import 'package:eqmonitor/feature/home/component/map/home_map_layer_modal.dart';
import 'package:eqmonitor/feature/home/component/map/kyoshin_monitor_scale_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_settings_modal.dart';
import 'package:eqmonitor/feature/map/data/controller/declarative_map_controller.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/ui/components/controller/map_layer_controller_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class HomeMapView extends HookConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = useMemoized(DeclarativeMapController.new);

    final size = MediaQuery.sizeOf(context);
    final cameraPosition = useMemoized(
      () => MapCameraPosition(
        target: MapCameraPositionHelper.calculateJapanCenterPosition(
          size.width,
          size.height,
        ),
        zoom: MapCameraPositionHelper.calculateJapanZoomLevel(
          size.width,
          size.height,
        ),
      ),
      [size.width, size.height],
    );

    return Stack(
      children: [
        HomeMapContent(
          mapController: mapController,
          cameraPosition: cameraPosition,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: _MapHeader(mapController: mapController, size: size),
          ),
        ),
      ],
    );
  }
}

class _MapHeader extends ConsumerWidget {
  const _MapHeader({
    required this.mapController,
    required this.size,
  });

  final DeclarativeMapController mapController;
  final Size size;

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
                  spacing: 4,
                  children: [
                    KyoshinMonitorStatusCard(
                      onTap: () async =>
                          KyoshinMonitorSettingsModal.show(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
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
        MapLayerControllerCard(
          onLayerButtonTap: () async => HomeMapLayerModal.show(context),
          onLocationButtonTap: () async {
            await mapController.moveCameraToPosition(
              CameraPosition(
                target: MapCameraPositionHelper.calculateJapanCenterPosition(
                  size.width,
                  size.height,
                ),
                zoom: MapCameraPositionHelper.calculateJapanZoomLevel(
                  size.width,
                  size.height,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
