import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/map_camera_state.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/logic/home_map_realtime_focus_transition.dart';
import 'package:eqmonitor/feature/home/data/service/home_map_camera_coordinator.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_camera_state_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeMapCameraState extends _$HomeMapCameraState {
  HomeMapRealtimeFocusSession _focusSession =
      HomeMapRealtimeFocusSession.initial;

  @override
  MapCameraState build() {
    ref.listen(eewAliveTelegramProvider, (_, _) async {
      await handleRealtimeTransition(
        eews: ref.read(eewAliveTelegramProvider) ?? [],
        shakes: ref.read(shakeDetectionFocusTargetsProvider),
      );
    });
    ref.listen(shakeDetectionFocusTargetsProvider, (_, _) async {
      await handleRealtimeTransition(
        eews: ref.read(eewAliveTelegramProvider) ?? [],
        shakes: ref.read(shakeDetectionFocusTargetsProvider),
      );
    });

    return MapCameraState.home();
  }

  Future<void> handleRealtimeTransition({
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
  }) async {
    final decision = ref
        .read(homeMapRealtimeFocusTransitionProvider)
        .sync(
          previous: _focusSession,
          eewEventIds: eews.map((eew) => eew.eventId).toSet(),
          shakeEventIds: shakes.map((shake) => shake.eventId).toSet(),
        );
    _focusSession = decision.session;
    final focusSession = decision.session;
    final hasTargets = focusSession.hasTargets;
    if (hasTargets && !decision.shouldFocus) {
      return;
    }
    if (hasTargets) {
      state = state.copyWith(isAtHome: false, isRealtimeFocusActive: true);
    }
    if (!hasTargets && state.isRealtimeFocusActive) {
      state = state.copyWith(isRealtimeFocusActive: false);
    }
    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .handleRealtimeTransition(
          home: ref.read(homeConfigurationProvider.future),
          eews: eews,
          shakes: shakes,
        );
    if (!identical(_focusSession, focusSession)) {
      return;
    }
    if (isAtHome != null) {
      state = state.copyWith(
        isAtHome: isAtHome,
        isRealtimeFocusActive: !isAtHome && focusSession.isFocused,
      );
    } else if (hasTargets) {
      state = state.copyWith(isRealtimeFocusActive: false);
    }
  }

  Future<void> setController({
    required MapController controller,
    required Size viewportSize,
  }) async {
    final eews = ref.read(eewAliveTelegramProvider) ?? [];
    final shakes = ref.read(shakeDetectionFocusTargetsProvider);
    final decision = ref
        .read(homeMapRealtimeFocusTransitionProvider)
        .sync(
          previous: _focusSession,
          eewEventIds: eews.map((eew) => eew.eventId).toSet(),
          shakeEventIds: shakes.map((shake) => shake.eventId).toSet(),
        );
    _focusSession = decision.session;
    final focusSession = decision.session;
    final hasTargets = focusSession.hasTargets;
    final shouldApplyInitialFocus = !hasTargets || decision.shouldFocus;
    if (hasTargets && decision.shouldFocus) {
      state = state.copyWith(isAtHome: false, isRealtimeFocusActive: true);
    }
    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .setController(
          controller: controller,
          viewportSize: viewportSize,
          home: ref.read(homeConfigurationProvider.future),
          eews: eews,
          shakes: shakes,
          applyInitialFocus: shouldApplyInitialFocus,
        );
    if (!identical(_focusSession, focusSession)) {
      return;
    }
    if (isAtHome != null) {
      state = state.copyWith(
        isAtHome: isAtHome,
        isRealtimeFocusActive: !isAtHome && focusSession.isFocused,
      );
    } else if (hasTargets) {
      state = state.copyWith(isRealtimeFocusActive: false);
    }
  }

  /// マップ(Widget)の破棄時に呼び出し、保持中の [MapController] をクリアする。
  void clearController({required MapController controller}) {
    ref
        .read(homeMapCameraCoordinatorProvider)
        .clearController(controller: controller);
  }

  void handleUserMapGesture() {
    if (!state.isRealtimeFocusActive) {
      return;
    }
    _focusSession = ref
        .read(homeMapRealtimeFocusTransitionProvider)
        .dismiss(previous: _focusSession);
    ref.read(homeMapCameraCoordinatorProvider).cancelAutomaticFocus();
    state = state.copyWith(isAtHome: false, isRealtimeFocusActive: false);
  }

  Future<void> returnToHome() async {
    final eews = ref.read(eewAliveTelegramProvider) ?? [];
    final shakes = ref.read(shakeDetectionFocusTargetsProvider);
    final transition = ref.read(homeMapRealtimeFocusTransitionProvider);
    _focusSession = transition
        .sync(
          previous: _focusSession,
          eewEventIds: eews.map((eew) => eew.eventId).toSet(),
          shakeEventIds: shakes.map((shake) => shake.eventId).toSet(),
        )
        .session;
    final decision = transition.refocus(previous: _focusSession);
    _focusSession = decision.session;
    if (decision.shouldFocus) {
      final focusSession = decision.session;
      state = state.copyWith(isAtHome: false, isRealtimeFocusActive: true);
      final isAtHome = await ref
          .read(homeMapCameraCoordinatorProvider)
          .handleRealtimeTransition(
            home: ref.read(homeConfigurationProvider.future),
            eews: eews,
            shakes: eews.isEmpty ? shakes : const [],
            ignoreAutoZoom: true,
          );
      if (!identical(_focusSession, focusSession)) {
        return;
      }
      if (isAtHome != null) {
        state = state.copyWith(
          isAtHome: isAtHome,
          isRealtimeFocusActive: !isAtHome,
        );
      } else {
        state = state.copyWith(isRealtimeFocusActive: false);
      }
      return;
    }
    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .returnToHome(home: ref.read(homeConfigurationProvider.future));
    if (isAtHome != null) {
      state = state.copyWith(
        isAtHome: isAtHome,
        isRealtimeFocusActive: false,
      );
    }
  }
}
