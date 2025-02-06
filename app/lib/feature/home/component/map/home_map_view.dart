import 'package:eqmonitor/feature/map/controller/kyoshin_monitor_layer_controller.dart';
import 'package:eqmonitor/feature/map/model/camera_position.dart';
import 'package:eqmonitor/feature/map/widget/declarative_map.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class HomeMapView extends ConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 強震モニタレイヤーの監視
    final kyoshinLayer = ref.watch(kyoshinMonitorLayerControllerProvider);

    return DeclarativeMap(
      initialCameraPosition: const MapCameraPosition(
        target: LatLng(35.681236, 139.767125),
      ),
      layers: [
        if (kyoshinLayer != null) kyoshinLayer,
      ],
    );
  }
}
