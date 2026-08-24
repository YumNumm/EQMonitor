import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/model/home_map_bounds.dart';
import 'package:eqmonitor/feature/map/data/logic/seismic_map_focus_builder.dart';
import 'package:eqmonitor/feature/map/data/service/map_automatic_focus_controller.dart';
import 'package:eqmonitor/feature/map/data/service/map_automatic_focus_operation_queue.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:material_ui/material_ui.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_map_camera_coordinator.g.dart';

enum HomeMapCameraUpdateAction { fitToRealtime, returnToHome, none }

/// リアルタイム描画対象とホーム復帰要求からカメラ更新アクションを解決するクラス
class HomeMapCameraUpdateActionResolver {
  const new();

  HomeMapCameraUpdateAction resolve({
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
}

class HomeMapCameraCoordinator {
  MapController? _controller;
  Size? _viewportSize;
  var _cameraGeneration = 0;
  var _isHomeFocusRequested = true;
  var _operationQueue = MapAutomaticFocusOperationQueue();

  Future<bool?> setController({
    required MapController controller,
    required Size viewportSize,
    required Future<HomeConfigurationModel> home,
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
    bool applyInitialFocus = true,
  }) {
    _cameraGeneration += 1;
    _controller = controller;
    _viewportSize = viewportSize;
    _isHomeFocusRequested = false;
    _operationQueue = MapAutomaticFocusOperationQueue();
    if (!applyInitialFocus) {
      return Future<bool?>.value();
    }
    return handleRealtimeTransition(home: home, eews: eews, shakes: shakes);
  }

  void clearController({required MapController controller}) {
    if (identical(_controller, controller)) {
      _cameraGeneration += 1;
      _controller = null;
      _viewportSize = null;
      _isHomeFocusRequested = true;
      _operationQueue = MapAutomaticFocusOperationQueue();
    }
  }

  Future<bool?> handleRealtimeTransition({
    required Future<HomeConfigurationModel> home,
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
    bool ignoreAutoZoom = false,
  }) {
    final generation = ++_cameraGeneration;
    final targets = const SeismicMapFocusBuilder().realtimeTargetCoordinates(
      eews: eews,
      shakes: shakes,
    );
    return switch (const HomeMapCameraUpdateActionResolver().resolve(
      hasRealtimeTargets: targets.isNotEmpty,
      isAtHome: _isHomeFocusRequested,
    )) {
      .fitToRealtime => applyRealtimeFocus(
        home: home,
        eews: eews,
        shakes: shakes,
        generation: generation,
        ignoreAutoZoom: ignoreAutoZoom,
      ),
      .returnToHome => applyHomeFocus(home: home, generation: generation),
      .none => Future<bool?>.value(),
    };
  }

  Future<bool?> applyRealtimeFocus({
    required Future<HomeConfigurationModel> home,
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
    required int generation,
    bool ignoreAutoZoom = false,
  }) async {
    final configuration = await home;
    final controller = _controller;
    final viewportSize = _viewportSize;
    final isCurrent = () =>
        generation == _cameraGeneration &&
        identical(controller, _controller) &&
        viewportSize == _viewportSize;
    if (controller == null || viewportSize == null || !isCurrent()) {
      return null;
    }
    if (!configuration.eew.autoZoom && !ignoreAutoZoom) {
      return null;
    }

    _isHomeFocusRequested = false;
    final bounds = const SeismicMapFocusBuilder().forRealtime(
      fallbackBounds: const HomeMapBoundsResolver().resolve(configuration.map),
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
    return completedCurrent ? false : null;
  }

  Future<bool?> returnToHome({required Future<HomeConfigurationModel> home}) =>
      applyHomeFocus(home: home, generation: ++_cameraGeneration);

  void cancelAutomaticFocus() {
    _cameraGeneration += 1;
  }

  Future<bool?> applyHomeFocus({
    required Future<HomeConfigurationModel> home,
    required int generation,
  }) async {
    _isHomeFocusRequested = true;
    final configuration = await home;
    final controller = _controller;
    final viewportSize = _viewportSize;
    final isCurrent = () =>
        generation == _cameraGeneration &&
        identical(controller, _controller) &&
        viewportSize == _viewportSize;
    if (controller == null || viewportSize == null || !isCurrent()) {
      return null;
    }
    final completedCurrent = await _operationQueue.schedule(
      operation: () => const MapAutomaticFocusController().fit(
        controller: controller,
        bounds: const HomeMapBoundsResolver().resolve(configuration.map),
        viewportSize: viewportSize,
        isCurrent: isCurrent,
        nativeDuration: const Duration(milliseconds: 200),
        bearing: 0,
        pitch: 0,
        padding: const EdgeInsets.all(4),
      ),
    );
    return completedCurrent ? true : null;
  }
}

@Riverpod(keepAlive: true)
HomeMapCameraCoordinator homeMapCameraCoordinator(Ref ref) =>
    HomeMapCameraCoordinator();
