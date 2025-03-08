import 'dart:async';
import 'dart:developer';

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/provider/map/map_camera_util.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/ui/components/kyoshin_monitor_observation_map_layer.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/components/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
            southwest: const LatLng(30, 128.8), // 日本全域を含む
            northeast: const LatLng(45.8, 145.1), // 日本全域を含む
          );

          // 画面サイズに基づいて最適なカメラポジションを計算
          final cameraPosition = MapCameraUtil.getCameraPositionForBounds(
            bounds: japanMainlandBounds,
            screenWidth: constraints.maxWidth,
            screenHeight: constraints.maxHeight,
            padding: const EdgeInsets.all(24), // パディングを少し大きくして余裕を持たせる
          );

          return _MapView(
            styleString: value.styleString!,
            cameraPosition: cameraPosition,
            initialBounds: japanMainlandBounds,
          );
        },
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _MapView extends HookConsumerWidget {
  const _MapView({
    required this.styleString,
    required this.cameraPosition,
    required this.initialBounds,
  });

  final String styleString;
  final CameraPosition cameraPosition;
  final LatLngBounds initialBounds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // マップコントローラーの状態管理
    final mapController = useRef<MapLibreMapController?>(null);
    final isStyleLoaded = useState<bool>(false);

    // マップ作成時のコールバック
    final onMapCreated =
        useCallback<Future<void> Function(MapLibreMapController controller)>((
          controller,
        ) async {
          mapController.value = controller;

          // 地図の移動を監視
          controller.addListener(() {
            final position = controller.cameraPosition;
            log('position: $position');
          });
        }, []);

    // スタイル読み込み完了時のコールバック
    final onStyleLoaded = useCallback<Future<void> Function()>(() async {
      final controller = mapController.value;
      if (controller == null) {
        return;
      }
      isStyleLoaded.value = true;
    }, []);

    // クリーンアップ処理
    useEffect(() {
      return () {
        final controller = mapController.value;
        if (controller != null) {}
      };
    }, []);

    return MapController(
      controller: mapController.value,
      child: Stack(
        children: [
          MapLibreMap(
            initialCameraPosition: cameraPosition,
            styleString: styleString,
            onMapCreated: onMapCreated,
            onStyleLoadedCallback: onStyleLoaded,
            myLocationEnabled: true,
          ),
          if (isStyleLoaded.value) ...[KyoshinMonitorObservationMapLayer()],
        ],
      ),
    );
  }
}
