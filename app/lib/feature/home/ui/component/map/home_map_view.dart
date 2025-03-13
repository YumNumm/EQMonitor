import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:map_plugin/map_plugin.dart';

class HomeMapView extends HookConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationNotifierProvider);
    final kyoshinMonitorState = ref.watch(kyoshinMonitorNotifierProvider);

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

          // 強震モニタの観測点データを取得
          final observationPoints = _getObservationPoints(kyoshinMonitorState);

          return _MapView(
            styleString: value.styleString!,
            observationPoints: observationPoints,
          );
        },
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }

  // 強震モニタの観測点データをマップ用に変換
  List<ObservationPoint> _getObservationPoints(
    AsyncValue<KyoshinMonitorState> state,
  ) {
    return state.valueOrNull?.analyzedPoints?.map((point) {
          // 震度値に応じた色を設定
          return ObservationPoint(
            id: point.point.code,
            latitude: point.point.location.latitude,
            longitude: point.point.location.longitude,
            intensity: point.observation.scale,
            color: Color.fromARGB(
              255,
              point.observation.r,
              point.observation.g,
              point.observation.b,
            ),
          );
        }).toList() ??
        [];
  }
}

class _MapView extends HookConsumerWidget {
  const _MapView({required this.styleString, required this.observationPoints});

  final String styleString;
  final List<ObservationPoint> observationPoints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MapPlugin(
      onMapCreated: (p0) {
        talker.info('MapPluginView created: $p0');
      },
      styleString: styleString,
      observationPoints: observationPoints,
    );
  }
}
