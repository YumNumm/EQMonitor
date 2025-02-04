import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/map/controller/kyoshin_monitor_layer_controller.dart';
import 'package:eqmonitor/core/map/model/camera_position.dart';
import 'package:eqmonitor/core/map/widget/declarative_map.dart';
import 'package:eqmonitor/feature/home/component/eew/eew_widget.dart';
import 'package:eqmonitor/feature/home/component/parameter/parameter_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 強震モニタレイヤーの監視
    final kyoshinLayer = ref.watch(kyoshinMonitorLayerControllerProvider);

    return Scaffold(
      body: Stack(
        children: [
          DeclarativeMap(
            initialCameraPosition: const MapCameraPosition(
              target: LatLng(35.681236, 139.767125),
            ),
            layers: [
              if (kyoshinLayer != null) kyoshinLayer,
            ],
          ),
          const _Sheet(),
        ],
      ),
    );
  }
}

class _Sheet extends HookConsumerWidget {
  const _Sheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BasicModalSheet(
      children: [
        // 緊急地震速報
        EewWidgets(),
        SizedBox(height: 8),
        // 強震モニタ
        ParameterLoaderWidget(),
      ],
    );
  }
}
