import 'package:eqmonitor/core/utils/map_camera_position_helper.dart';
import 'package:eqmonitor/feature/home/component/map/home_map_layer_modal.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_scale.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart';
import 'package:eqmonitor/feature/map/data/controller/declarative_map_controller.dart';
import 'package:eqmonitor/feature/map/data/controller/kyoshin_monitor_layer_controller.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/components/controller/map_layer_controller_card.dart';
import 'package:eqmonitor/feature/map/ui/declarative_map.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class HomeMapView extends HookConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 強震モニタレイヤーの監視
    final kyoshinLayer = ref.watch(kyoshinMonitorLayerControllerProvider);
    final size = MediaQuery.sizeOf(context);
    final mapController = useMemoized(DeclarativeMapController.new);

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

    // スタイルの監視
    final configurationState = ref.watch(mapConfigurationNotifierProvider);
    final configuration = configurationState.valueOrNull;

    if (configuration == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    final styleString = configuration.styleString;
    if (styleString == null) {
      throw ArgumentError('styleString is null');
    }

    return Stack(
      children: [
        DeclarativeMap(
          styleString: styleString,
          controller: mapController,
          initialCameraPosition: cameraPosition,
          layers: [
            if (kyoshinLayer != null) kyoshinLayer,
          ],
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KyoshinMonitorStatusCard(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: _KyoshinMonitorScale(),
                    ),
                  ],
                ),
                const Column(),
                MapLayerControllerCard(
                  onLayerButtonTap: () async => HomeMapLayerModal.show(context),
                  onLocationButtonTap: () async {
                    await mapController.moveCameraToPosition(
                      CameraPosition(
                        target: MapCameraPositionHelper
                            .calculateJapanCenterPosition(
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
            ),
          ),
        ),
      ],
    );
  }
}

class _KyoshinMonitorScale extends ConsumerWidget {
  const _KyoshinMonitorScale();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final realtimeDataType = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.realtimeDataType),
    );
    final type = switch (realtimeDataType) {
      RealtimeDataType.shindo => KyoshinMonitorScaleType.intensity,
      RealtimeDataType.pga => KyoshinMonitorScaleType.pga,
      RealtimeDataType.pgv ||
      RealtimeDataType.response0125Hz ||
      RealtimeDataType.response025Hz ||
      RealtimeDataType.response05Hz ||
      RealtimeDataType.response1Hz ||
      RealtimeDataType.response2Hz ||
      RealtimeDataType.response4Hz =>
        KyoshinMonitorScaleType.pgv,
      RealtimeDataType.pgd => KyoshinMonitorScaleType.pgd,
      _ => throw ArgumentError(
          'Invalid realtimeDataType: $realtimeDataType)',
        ),
    };
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          type.unit == ''
              ? type.title
              : '${type.title.toUpperCase()} [${type.unit}]',
          style: theme.textTheme.bodySmall!.copyWith(
            fontFamily: FontFamily.jetBrainsMono,
            textBaseline: TextBaseline.alphabetic,
            fontWeight: FontWeight.bold,
          ),
        ),
        KyoshinMonitorScale(
          type: type,
          width: 15,
          height: 150,
          gradientDirection: KyoshinMonitorScaleGradientDirection.reverse,
          orientation: KyoshinMonitorScaleOrientation.vertical,
          textColor: theme.colorScheme.onSurface,
          tickInterval: 3,
          textStyle: theme.textTheme.bodySmall!.copyWith(
            fontFamily: FontFamily.jetBrainsMono,
            textBaseline: TextBaseline.alphabetic,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
