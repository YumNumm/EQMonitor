import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/model/home_map_bounds.dart';
import 'package:eqmonitor/feature/map/data/logic/seismic_map_focus_builder.dart';
import 'package:eqmonitor/feature/map/data/model/map_camera_bounds.dart';
import 'package:eqmonitor/feature/map/data/service/map_automatic_focus_controller.dart';
import 'package:eqmonitor/feature/map/data/service/map_automatic_focus_operation_queue.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_map_camera_coordinator.g.dart';

enum HomeMapCameraUpdateAction { fitToRealtime, returnToHome, none }

typedef HomeMapRealtimeFocus = ({
  MapCameraBounds bounds,
  int generation,
  Future<bool?> result,
});

/// リアルタイム描画対象とホーム復帰要求からカメラ更新アクションを解決するクラス
class const HomeMapCameraUpdateActionResolver() {
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
  HomeMapRealtimeFocus? _realtimeFocus;
  final _focusBounds = ValueNotifier<MapCameraBounds?>(null);

  ValueListenable<MapCameraBounds?> get focusBounds => _focusBounds;

  Future<bool?> setController({
    required MapController controller,
    required Size viewportSize,
    required Future<HomeConfigurationModel> home,
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
    bool applyInitialFocus = true,
  }) {
    _cameraGeneration += 1;
    _realtimeFocus = null;
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
      _realtimeFocus = null;
      _focusBounds.value = null;
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
    final targets = const SeismicMapFocusBuilder().realtimeTargetCoordinates(
      eews: eews,
      shakes: shakes,
    );
    final action = const HomeMapCameraUpdateActionResolver().resolve(
      hasRealtimeTargets: targets.isNotEmpty,
      isAtHome: _isHomeFocusRequested,
    );
    if (action != .fitToRealtime) {
      final generation = ++_cameraGeneration;
      _realtimeFocus = null;
      return action == .returnToHome
          ? applyHomeFocus(home: home, generation: generation)
          : Future<bool?>.value();
    }
    final bounds = const SeismicMapFocusBuilder().boundsForRealtimeTargets(
      targets: targets,
      shakes: shakes,
    );
    final current = _realtimeFocus;
    // 同じ範囲へのフォーカスが実行中または完了済みなら、世代を進めずに
    // その結果を返す。世代を進めると実行中のアニメーションが無効になる。
    if (!ignoreAutoZoom && current != null && current.bounds == bounds) {
      return current.result;
    }
    final generation = ++_cameraGeneration;
    final result = applyRealtimeFocus(
      home: home,
      eews: eews,
      bounds: bounds,
      generation: generation,
      ignoreAutoZoom: ignoreAutoZoom,
    );
    _realtimeFocus = (bounds: bounds, generation: generation, result: result);
    return result;
  }

  Future<bool?> applyRealtimeFocus({
    required Future<HomeConfigurationModel> home,
    required List<EewTelegramItem> eews,
    required MapCameraBounds bounds,
    required int generation,
    bool ignoreAutoZoom = false,
  }) async {
    var isFocused = false;
    try {
      isFocused = await fitRealtimeBounds(
        home: home,
        eews: eews,
        bounds: bounds,
        generation: generation,
        ignoreAutoZoom: ignoreAutoZoom,
      );
    } finally {
      if (!isFocused && _realtimeFocus?.generation == generation) {
        _realtimeFocus = null;
      }
    }
    return isFocused ? false : null;
  }

  Future<bool> fitRealtimeBounds({
    required Future<HomeConfigurationModel> home,
    required List<EewTelegramItem> eews,
    required MapCameraBounds bounds,
    required int generation,
    required bool ignoreAutoZoom,
  }) async {
    final configuration = await home;
    final controller = _controller;
    final viewportSize = _viewportSize;
    final isCurrent = () =>
        generation == _cameraGeneration &&
        identical(controller, _controller) &&
        viewportSize == _viewportSize;
    if (controller == null || viewportSize == null || !isCurrent()) {
      return false;
    }
    // 揺れ検知だけの場合は、対象を渡す側が揺れ検知の自動フォーカス設定で絞っている。
    if (eews.isNotEmpty && !configuration.eew.autoZoom && !ignoreAutoZoom) {
      return false;
    }

    _isHomeFocusRequested = false;
    _focusBounds.value = bounds;
    return _operationQueue.schedule(
      operation: () => const MapAutomaticFocusController().fit(
        controller: controller,
        bounds: bounds,
        viewportSize: viewportSize,
        isCurrent: isCurrent,
      ),
    );
  }

  Future<bool?> returnToHome({required Future<HomeConfigurationModel> home}) {
    _realtimeFocus = null;
    return applyHomeFocus(home: home, generation: ++_cameraGeneration);
  }

  void cancelAutomaticFocus() {
    _cameraGeneration += 1;
    _realtimeFocus = null;
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
    final bounds = const HomeMapBoundsResolver().resolve(configuration.map);
    _focusBounds.value = bounds;
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
    return completedCurrent ? true : null;
  }
}

@Riverpod(keepAlive: true)
HomeMapCameraCoordinator homeMapCameraCoordinator(Ref ref) =>
    HomeMapCameraCoordinator();
