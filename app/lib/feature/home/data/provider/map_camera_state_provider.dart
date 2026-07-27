import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/map_camera_state.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/service/home_map_camera_coordinator.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_camera_state_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeMapCameraState extends _$HomeMapCameraState {
  @override
  MapCameraState build() {
    ref.listen(eewAliveTelegramProvider, (_, _) async {
      await handleRealtimeTransition(
        eews: ref.read(eewAliveTelegramProvider) ?? [],
        shakes: ref.read(shakeDetectionVisibleProvider),
      );
    });
    ref.listen(shakeDetectionVisibleProvider, (_, _) async {
      await handleRealtimeTransition(
        eews: ref.read(eewAliveTelegramProvider) ?? [],
        shakes: ref.read(shakeDetectionVisibleProvider),
      );
    });

    return MapCameraState.home();
  }

  Future<void> handleRealtimeTransition({
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
  }) async {
    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .handleRealtimeTransition(
          home: ref.read(homeConfigurationProvider.future),
          eews: eews,
          shakes: shakes,
        );
    if (isAtHome != null) {
      state = state.copyWith(isAtHome: isAtHome);
    }
  }

  Future<void> setController({
    required MapController controller,
    required Size viewportSize,
  }) async {
    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .setController(
          controller: controller,
          viewportSize: viewportSize,
          home: ref.read(homeConfigurationProvider.future),
          eews: ref.read(eewAliveTelegramProvider) ?? [],
          shakes: ref.read(shakeDetectionVisibleProvider),
        );
    if (isAtHome != null) {
      state = state.copyWith(isAtHome: isAtHome);
    }
  }

  /// マップ(Widget)の破棄時に呼び出し、保持中の [MapController] をクリアする。
  void clearController({required MapController controller}) {
    ref
        .read(homeMapCameraCoordinatorProvider)
        .clearController(controller: controller);
  }

  Future<void> returnToHome() async {
    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .returnToHome(home: ref.read(homeConfigurationProvider.future));
    if (isAtHome != null) {
      state = state.copyWith(isAtHome: isAtHome);
    }
  }
}
