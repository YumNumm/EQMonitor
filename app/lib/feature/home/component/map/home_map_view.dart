import 'package:eqmonitor/core/map/controller/kyoshin_monitor_layer_controller.dart';
import 'package:eqmonitor/core/map/controller/layer_controller.dart';
import 'package:eqmonitor/core/map/model/camera_position.dart';
import 'package:eqmonitor/core/map/widget/declarative_map.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class HomeMapView extends ConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // レイヤーの監視
    final layerState = ref.watch(mapLayerControllerProvider);
    // 強震モニタレイヤーの監視
    final kyoshinLayer = ref.watch(kyoshinMonitorLayerControllerProvider);

    return DeclarativeMap(
      initialCameraPosition: const MapCameraPosition(
        target: LatLng(35.681236, 139.767125),
      ),
      layers: [
        ...layerState,
        if (kyoshinLayer != null) kyoshinLayer,
      ],
    );
  }
}
