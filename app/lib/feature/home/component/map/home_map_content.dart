import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/map/data/controller/declarative_map_controller.dart';
import 'package:eqmonitor/feature/map/data/controller/eew_hypocenter_layer_controller.dart';
import 'package:eqmonitor/feature/map/data/controller/kyoshin_monitor_layer_controller.dart';
import 'package:eqmonitor/feature/map/data/layer/eew_hypocenter/eew_hypocenter_layer.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/declarative_map.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeMapContent extends HookConsumerWidget {
  const HomeMapContent({
    required this.mapController,
    required this.cameraPosition,
    super.key,
  });

  final DeclarativeMapController mapController;
  final MapCameraPosition cameraPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 強震モニタレイヤーの監視
    final kyoshinLayer = ref.watch(kyoshinMonitorLayerControllerProvider);
    final isKyoshinLayerEnabled = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.useKmoni),
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

    final homeConfiguration = ref.watch(homeConfigurationNotifierProvider);

    return RepaintBoundary(
      child: DeclarativeMap(
        myLocationEnabled: homeConfiguration.showLocation,
        styleString: styleString,
        controller: mapController,
        initialCameraPosition: cameraPosition,
        layers: [
          if (isKyoshinLayerEnabled) kyoshinLayer,
          ref.watch(
            eewHypocenterLayerControllerProvider(EewHypocenterIcon.normal),
          ),
          ref.watch(
            eewHypocenterLayerControllerProvider(
              EewHypocenterIcon.lowPrecise,
            ),
          ),
        ],
      ),
    );
  }
}
