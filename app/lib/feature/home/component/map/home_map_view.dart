import 'package:eqmonitor/feature/home/component/map/home_map_layer_modal.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_scale.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart';
import 'package:eqmonitor/feature/map/data/controller/kyoshin_monitor_layer_controller.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/ui/components/controller/map_layer_controller_card.dart';
import 'package:eqmonitor/feature/map/ui/declarative_map.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class HomeMapView extends HookConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 強震モニタレイヤーの監視
    final kyoshinLayer = ref.watch(kyoshinMonitorLayerControllerProvider);

    return Stack(
      children: [
        DeclarativeMap(
          initialCameraPosition: const MapCameraPosition(
            target: LatLng(35.681236, 139.767125),
            zoom: 3,
          ),
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const KyoshinMonitorStatusCard(),
                    const SizedBox(height: 10),
                    for (final type in KyoshinMonitorScaleType.values)
                      Row(
                        children: [
                          KyoshinMonitorScale(
                            type: type,
                            width: 100,
                            height: 20,
                          ),
                          Text(type.name),
                        ],
                      ),
                  ],
                ),
                const Column(),
                MapLayerControllerCard(
                  onLayerButtonTap: () async => HomeMapLayerModal.show(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
