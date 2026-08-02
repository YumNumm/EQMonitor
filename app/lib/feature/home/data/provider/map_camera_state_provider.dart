import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/logic/eew_map_focus_bounds_builder.dart';
import 'package:eqmonitor/feature/home/data/model/eew_map_focus_state.dart';
import 'package:eqmonitor/feature/home/data/model/map_camera_state.dart';
import 'package:eqmonitor/feature/home/data/model/home_map_bounds.dart';
import 'package:eqmonitor/feature/home/data/notifier/eew_map_focus.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/service/home_map_camera_coordinator.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_camera_state_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeMapCameraState extends _$HomeMapCameraState {
  @override
  MapCameraState build() {
    ref.listen(eewAliveTelegramProvider, (_, _) async {
      await handleRealtimeTransition();
    });
    ref.listen(shakeDetectionProvider, (_, _) async {
      await handleRealtimeTransition();
    });

    return MapCameraState.home();
  }

  Future<void> handleRealtimeTransition() async {
    final eews =
        ref.read(eewAliveTelegramProvider) ?? const <EewTelegramItem>[];
    if (eews.isNotEmpty) {
      final decision = ref.read(eewMapFocusProvider.notifier).sync();
      await applyEewFocus(decision: decision, ignoreAutoZoom: false);
      return;
    }

    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .handleRealtimeTransition(
          home: ref.read(homeConfigurationProvider.future),
          eews: const [],
          shakes: ref.read(shakeDetectionVisibleProvider),
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
          eews: const [],
          shakes: const [],
          applyInitialFocus: false,
          isAtHome: false,
        );
    if (isAtHome != null) {
      state = state.copyWith(isAtHome: isAtHome);
    }
    await handleRealtimeTransition();
  }

  /// マップ(Widget)の破棄時に呼び出し、保持中の [MapController] をクリアする。
  void clearController({required MapController controller}) {
    ref
        .read(homeMapCameraCoordinatorProvider)
        .clearController(controller: controller);
  }

  Future<void> returnToHome() async {
    final eews =
        ref.read(eewAliveTelegramProvider) ?? const <EewTelegramItem>[];
    if (eews.isNotEmpty) {
      final decision = ref.read(eewMapFocusProvider.notifier).refocus();
      await applyEewFocus(decision: decision, ignoreAutoZoom: true);
      return;
    }

    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .returnToHome(home: ref.read(homeConfigurationProvider.future));
    if (isAtHome != null) {
      state = state.copyWith(isAtHome: isAtHome);
    }
  }

  Future<void> applyEewFocus({
    required EewMapFocusDecision decision,
    required bool ignoreAutoZoom,
  }) async {
    if (!decision.shouldFit) {
      return;
    }
    final focusedEventId = decision.state.focusedEventId;
    final focused = focusedEventId == null
        ? null
        : (ref.read(eewAliveTelegramProvider) ?? const <EewTelegramItem>[])
              .where((eew) => eew.eventId == focusedEventId)
              .firstOrNull;
    if (focused == null) {
      return;
    }

    final configuration = await ref.read(homeConfigurationProvider.future);
    final bounds = ref
        .read(eewMapFocusBoundsBuilderProvider)
        .boundsForFocus(
          hypocenter: decision.state.focusedHypocenter,
          shakeRect: decision.state.shakeBoundsByEventId[focused.eventId],
          fallbackBounds: lngLatBoundsForHomeMapSettings(configuration.map),
        );
    if (bounds == null) {
      return;
    }

    final coordinator = ref.read(homeMapCameraCoordinatorProvider);
    final isAtHome = await coordinator.applyEewFocus(
      home: Future.value(configuration),
      bounds: bounds,
      generation: coordinator.nextCameraGeneration(),
      ignoreAutoZoom: ignoreAutoZoom,
    );
    if (isAtHome != null) {
      state = state.copyWith(isAtHome: isAtHome);
    }
  }
}
