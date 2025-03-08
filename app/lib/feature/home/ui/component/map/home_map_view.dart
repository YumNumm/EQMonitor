import 'dart:io';

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/provider/map/map_camera_util.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class HomeMapView extends HookConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationNotifierProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => LayoutBuilder(
        builder: (context, constraints) {
          // 日本の本州を含む範囲を定義（より適切な範囲に調整）
          final japanMainlandBounds = LatLngBounds(
            southwest: const LatLng(34, 132), // 本州西部
            northeast: const LatLng(40, 141), // 本州北部
          );

          // 画面サイズに基づいて最適なカメラポジションを計算
          final cameraPosition = MapCameraUtil.getCameraPositionForBounds(
            bounds: japanMainlandBounds,
            screenWidth: constraints.maxWidth,
            screenHeight: constraints.maxHeight,
            padding: const EdgeInsets.all(24), // パディングを少し大きくして余裕を持たせる
          );
          debugPrint('カメラポジション: $cameraPosition');
          final bytes = File(value.styleString!).readAsStringSync();
          print(bytes);

          return MapLibreMap(
            initialCameraPosition: cameraPosition,
            styleString: value.styleString!,
          );
        },
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}
