import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/map_camera_state.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/logic/home_map_eew_focus_transition.dart';
import 'package:eqmonitor/feature/home/data/service/home_map_camera_coordinator.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_camera_state_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeMapCameraState extends _$HomeMapCameraState {
  HomeMapEewFocusSession _eewFocusSession = HomeMapEewFocusSession.initial;

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
    final decision = ref
        .read(homeMapEewFocusTransitionProvider)
        .sync(
          previous: _eewFocusSession,
          eventIds: eews.map((eew) => eew.eventId).toSet(),
        );
    _eewFocusSession = decision.session;
    if (eews.isNotEmpty && !decision.shouldFocus) {
      return;
    }
    final focusSession = decision.session;
    if (eews.isNotEmpty) {
      state = state.copyWith(isAtHome: false, isEewFocusActive: true);
    }
    if (eews.isEmpty && state.isEewFocusActive) {
      state = state.copyWith(isEewFocusActive: false);
    }
    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .handleRealtimeTransition(
          home: ref.read(homeConfigurationProvider.future),
          eews: eews,
          shakes: shakes,
        );
    if (!identical(_eewFocusSession, focusSession)) {
      return;
    }
    if (isAtHome != null) {
      state = state.copyWith(
        isAtHome: isAtHome,
        isEewFocusActive:
            eews.isNotEmpty && !isAtHome && decision.session.isFocused,
      );
    } else if (eews.isNotEmpty) {
      state = state.copyWith(isEewFocusActive: false);
    }
  }

  Future<void> setController({
    required MapController controller,
    required Size viewportSize,
  }) async {
    final eews = ref.read(eewAliveTelegramProvider) ?? [];
    final shakes = ref.read(shakeDetectionVisibleProvider);
    final decision = ref
        .read(homeMapEewFocusTransitionProvider)
        .sync(
          previous: _eewFocusSession,
          eventIds: eews.map((eew) => eew.eventId).toSet(),
        );
    _eewFocusSession = decision.session;
    final shouldApplyInitialFocus = eews.isEmpty || decision.shouldFocus;
    final focusSession = decision.session;
    if (eews.isNotEmpty && decision.shouldFocus) {
      state = state.copyWith(isAtHome: false, isEewFocusActive: true);
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
    if (!identical(_eewFocusSession, focusSession)) {
      return;
    }
    if (isAtHome != null) {
      state = state.copyWith(
        isAtHome: isAtHome,
        isEewFocusActive:
            eews.isNotEmpty && !isAtHome && decision.session.isFocused,
      );
    } else if (eews.isNotEmpty) {
      state = state.copyWith(isEewFocusActive: false);
    }
  }

  /// マップ(Widget)の破棄時に呼び出し、保持中の [MapController] をクリアする。
  void clearController({required MapController controller}) {
    ref
        .read(homeMapCameraCoordinatorProvider)
        .clearController(controller: controller);
  }

  void handleUserMapGesture() {
    if (!state.isEewFocusActive) {
      return;
    }
    _eewFocusSession = ref
        .read(homeMapEewFocusTransitionProvider)
        .dismiss(previous: _eewFocusSession);
    ref.read(homeMapCameraCoordinatorProvider).cancelAutomaticFocus();
    state = state.copyWith(isAtHome: false, isEewFocusActive: false);
  }

  Future<void> returnToHome() async {
    final eews = ref.read(eewAliveTelegramProvider) ?? [];
    if (eews.isNotEmpty) {
      final transition = ref.read(homeMapEewFocusTransitionProvider);
      _eewFocusSession = transition
          .sync(
            previous: _eewFocusSession,
            eventIds: eews.map((eew) => eew.eventId).toSet(),
          )
          .session;
      final decision = transition.refocus(previous: _eewFocusSession);
      _eewFocusSession = decision.session;
      if (!decision.shouldFocus) {
        return;
      }
      final focusSession = decision.session;
      state = state.copyWith(isAtHome: false, isEewFocusActive: true);
      final isAtHome = await ref
          .read(homeMapCameraCoordinatorProvider)
          .handleRealtimeTransition(
            home: ref.read(homeConfigurationProvider.future),
            eews: eews,
            shakes: const [],
            ignoreAutoZoom: true,
          );
      if (!identical(_eewFocusSession, focusSession)) {
        return;
      }
      if (isAtHome != null) {
        state = state.copyWith(
          isAtHome: isAtHome,
          isEewFocusActive: !isAtHome,
        );
      } else {
        state = state.copyWith(isEewFocusActive: false);
      }
      return;
    }
    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .returnToHome(home: ref.read(homeConfigurationProvider.future));
    if (isAtHome != null) {
      state = state.copyWith(
        isAtHome: isAtHome,
        isEewFocusActive: false,
      );
    }
  }
}
