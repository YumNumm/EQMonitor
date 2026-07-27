import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/home_map_bounds.dart';
import 'package:eqmonitor/feature/home/data/model/map_camera_state.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/data/logic/seismic_map_focus_builder.dart';
import 'package:eqmonitor/feature/map/data/service/map_automatic_focus_controller.dart';
import 'package:eqmonitor/feature/map/data/service/map_automatic_focus_operation_queue.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_camera_state_provider.g.dart';

enum HomeMapCameraUpdateAction { fitToRealtime, returnToHome, none }

HomeMapCameraUpdateAction resolveHomeMapCameraUpdateAction({
  required bool hasRealtimeTargets,
  required bool isAtHome,
}) {
  if (hasRealtimeTargets) {
    return HomeMapCameraUpdateAction.fitToRealtime;
  }
  if (!isAtHome) {
    return HomeMapCameraUpdateAction.returnToHome;
  }
  return HomeMapCameraUpdateAction.none;
}

@Riverpod(keepAlive: true)
class HomeMapCameraState extends _$HomeMapCameraState {
  MapController? _controller;
  Size? _viewportSize;
  var _cameraGeneration = 0;
  var _isHomeFocusRequested = true;
  var _operationQueue = MapAutomaticFocusOperationQueue();

  @override
  MapCameraState build() {
    ref.listen(eewAliveTelegramProvider, (_, _) async {
      await _handleRealtimeTransition(
        eews: ref.read(eewAliveTelegramProvider) ?? [],
        shakes: ref.read(shakeDetectionVisibleProvider),
      );
    });
    ref.listen(shakeDetectionVisibleProvider, (_, _) async {
      await _handleRealtimeTransition(
        eews: ref.read(eewAliveTelegramProvider) ?? [],
        shakes: ref.read(shakeDetectionVisibleProvider),
      );
    });

    return MapCameraState.home();
  }

  Future<void> setController(
    MapController controller, {
    required Size viewportSize,
  }) async {
    _cameraGeneration += 1;
    _controller = controller;
    _viewportSize = viewportSize;
    _isHomeFocusRequested = false;
    _operationQueue = MapAutomaticFocusOperationQueue();
    await _handleRealtimeTransition(
      eews: ref.read(eewAliveTelegramProvider) ?? [],
      shakes: ref.read(shakeDetectionVisibleProvider),
    );
  }

  /// マップ(Widget)の破棄時に呼び出し、保持中の [MapController] をクリアする。
  ///
  /// [controller] が現在保持しているものと一致する場合のみクリアする。
  /// unmount と次のマップの [setController] 呼び出し順序が入れ替わっても、
  /// 既に新しい controller に置き換わっている場合は何もしないため安全。
  void clearController(MapController controller) {
    if (identical(_controller, controller)) {
      _cameraGeneration += 1;
      _controller = null;
      _viewportSize = null;
      _isHomeFocusRequested = true;
      _operationQueue = MapAutomaticFocusOperationQueue();
    }
  }

  Future<void> _handleRealtimeTransition({
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
  }) async {
    final generation = ++_cameraGeneration;
    final targets = const SeismicMapFocusBuilder().realtimeTargetCoordinates(
      eews: eews,
      shakes: shakes,
    );
    switch (resolveHomeMapCameraUpdateAction(
      hasRealtimeTargets: targets.isNotEmpty,
      isAtHome: _isHomeFocusRequested,
    )) {
      case HomeMapCameraUpdateAction.fitToRealtime:
        await _fitToRealtime(
          eews: eews,
          shakes: shakes,
          generation: generation,
        );
        return;
      case HomeMapCameraUpdateAction.returnToHome:
        await _returnToHome(generation: generation);
        return;
      case HomeMapCameraUpdateAction.none:
        return;
    }
  }

  Future<void> _fitToRealtime({
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
    required int generation,
  }) async {
    final home = await ref.read(homeConfigurationProvider.future);
    final controller = _controller;
    final viewportSize = _viewportSize;
    final isCurrent = () =>
        generation == _cameraGeneration &&
        identical(controller, _controller) &&
        viewportSize == _viewportSize;
    if (controller == null || viewportSize == null || !isCurrent()) {
      return;
    }
    if (!home.eew.autoZoom) {
      return;
    }

    _isHomeFocusRequested = false;
    final homeBounds = lngLatBoundsForHomeMapSettings(home.map);
    final bounds = const SeismicMapFocusBuilder().forRealtime(
      fallbackBounds: homeBounds,
      eews: eews,
      shakes: shakes,
    );
    final completedCurrent = await _operationQueue.schedule(
      operation: () => const MapAutomaticFocusController().fit(
        controller: controller,
        bounds: bounds,
        viewportSize: viewportSize,
        isCurrent: isCurrent,
      ),
    );
    if (completedCurrent) {
      state = state.copyWith(isAtHome: false);
    }
  }

  Future<void> _returnToHome({required int generation}) async {
    _isHomeFocusRequested = true;
    final home = await ref.read(homeConfigurationProvider.future);
    final controller = _controller;
    final viewportSize = _viewportSize;
    final isCurrent = () =>
        generation == _cameraGeneration &&
        identical(controller, _controller) &&
        viewportSize == _viewportSize;
    if (controller == null || viewportSize == null || !isCurrent()) {
      return;
    }
    final bounds = lngLatBoundsForHomeMapSettings(home.map);

    final completedCurrent = await _operationQueue.schedule(
      operation: () => const MapAutomaticFocusController().fit(
        controller: controller,
        bounds: bounds,
        viewportSize: viewportSize,
        isCurrent: isCurrent,
        nativeDuration: const Duration(milliseconds: 200),
        bearing: 0,
        pitch: 0,
        padding: const EdgeInsets.all(4),
      ),
    );
    if (completedCurrent) {
      state = state.copyWith(isAtHome: true);
    }
  }

  Future<void> returnToHome() async {
    await _returnToHome(generation: ++_cameraGeneration);
  }
}
