import 'dart:async';
import 'dart:math' as math;

import 'package:eqmonitor/core/component/map/model/map_state.dart';
import 'package:eqmonitor/core/component/map/utils/global_point_and_zoom_level_tween.dart';
import 'package:eqmonitor/core/component/map/utils/web_mercator_projection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_viewmodel.g.dart';

@Riverpod()
class MapViewModel extends _$MapViewModel {
  @override
  MapState build(Key key) {
    return const MapState(
      offset: Offset.zero,
      zoomLevel: 1,
    );
  }

  double? _scaleStart;

  Animation<Offset>? _moveAnimation;
  Animation<double>? _scaleAnimation;
  Animation<(GlobalPoint, double zoomLevel)>? _globalPointAndZoomLevelAnimation;
  late AnimationController _moveController;
  late AnimationController _scaleController;
  late AnimationController _globalPointAndZoomLevelController;

  static const double _interactionEndFrictionCoefficient = 0.0000135;

  _GestureType? _gestureType;

  RenderBox? _renderBox;

  void Function()? _registerCallback;

  // * MapController周りの実装
  (LatLng, LatLng) _currencPoi = (
    const LatLng(45.8, 145.1),
    const LatLng(30, 128.8),
  );

  /// POI適用後に移動したかどうか
  bool _isMarkedAsMoved = false;

  /// デフォルトの表示領域に戻す
  void reset() => _currencPoi = (
        const LatLng(45.8, 145.1),
        const LatLng(30, 128.8),
      );

  /// 表示領域を変更する
  void applyBounds({
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double bottom = 0,
  }) {
    if (_renderBox == null) {
      return;
    }
    final points = _currencPoi.toGlobalPoints();
    state = state.fitBoundsByGlobalPoints(
      [points.$1, points.$2],
      padding
          .add(
            EdgeInsets.only(
              bottom: _renderBox!.size.height * bottom,
            ),
          )
          .deflateSize(_renderBox!.size),
    );
  }

  Future<void> animatedApplyBoundsIfNeeded({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCirc,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) async =>
      switch (_isMarkedAsMoved) {
        false => animatedApplyBounds(
            duration: duration,
            curve: curve,
            padding: padding,
          ),
        true => {},
      };

  Future<void> animatedApplyBounds({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCirc,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double bottom = 0,
  }) {
    if (_renderBox == null) {
      throw Exception('MapController is not initialized.');
    }
    final points = _currencPoi.toGlobalPoints();
    return animatedBoundsByGlobalPoints(
      [points.$1, points.$2],
      curve: curve,
      duration: duration,
      padding: padding,
      bottom: bottom,
    );
  }

  /// 表示領域をセットし、表示領域を変更する
  void setBounds(List<LatLng> latLngs) {
    if (latLngs.isEmpty) {
      throw ArgumentError('latLngs must not be empty');
    }
    var minLat = double.negativeInfinity;
    var minLng = double.negativeInfinity;
    var maxLat = double.infinity;
    var maxLng = double.infinity;
    for (final latLng in latLngs) {
      minLat = math.max(minLat, latLng.lat);
      minLng = math.max(minLng, latLng.lon);
      maxLat = math.min(maxLat, latLng.lat);
      maxLng = math.min(maxLng, latLng.lon);
    }
    _currencPoi = (
      LatLng(minLat, minLng),
      LatLng(maxLat, maxLng),
    );
  }

  void resetMarkAsMoved() => _isMarkedAsMoved = false;

  /// The minimum velocity for a touch to consider that touch to trigger a fling
  /// gesture.
  static const double kMinFlingVelocity = 50; // Logical pixels / second
  /// The default conversion factor when treating mouse scrolling as scaling.
  ///
  /// The value was arbitrarily chosen to feel natural for most mousewheels on
  /// all supported platforms.
  static const double kDefaultMouseScrollToScaleFactor = 200;

  /// _moveAnimationのリスナー
  void _onMoveAnimation() {
    if (!_moveController.isAnimating) {
      _moveAnimation?.removeListener(_onMoveAnimation);
      _moveAnimation = null;
      _moveController.reset();
      return;
    }
    state = state.copyWith(
      offset: _moveAnimation!.value,
    );
  }

  void _onGlobalPointAndZoomLevelAnimation() {
    if (!_globalPointAndZoomLevelController.isAnimating) {
      _globalPointAndZoomLevelAnimation
          ?.removeListener(_onGlobalPointAndZoomLevelAnimation);
      _globalPointAndZoomLevelAnimation = null;
      _globalPointAndZoomLevelController.reset();
      return;
    }
    final (GlobalPoint point, double zoomLevel) =
        _globalPointAndZoomLevelAnimation!.value;

    state = state.setCenter(point, _renderBox!.size).setScale(
          zoomLevel,
          focalPoint: _renderBox!.size.center(Offset.zero),
        );
  }

  void _onScaleAnimation() {
    if (!_scaleController.isAnimating) {
      _scaleAnimation?.removeListener(_onScaleAnimation);
      _scaleAnimation = null;
      _scaleController.reset();
      return;
    }
    state = state.setScale(
      _scaleAnimation!.value,
      focalPoint: _renderBox!.size.center(Offset.zero),
    );
  }

  // Decide which type of gesture this is by comparing the amount of scale
  // and rotation in the gesture, if any. Scale starts at 1 and rotation
  // starts at 0. Pan will have no scale and no rotation because it uses only
  // one finger.
  _GestureType _getGestureType(ScaleUpdateDetails details) {
    final scale = details.scale;
    const rotation = 0; //details.rotation;
    if ((scale - 1).abs() > rotation.abs()) {
      return _GestureType.scale;
    } else if (rotation != 0.0) {
      return _GestureType.rotate;
    } else {
      return _GestureType.pan;
    }
  }

  void handleScaleStart(ScaleStartDetails details) {
    if (_moveController.isAnimating) {
      _moveController
        ..stop()
        ..reset();
      _moveAnimation?.removeListener(_onMoveAnimation);
    }
    if (_scaleController.isAnimating) {
      _scaleController
        ..stop()
        ..reset();
      _scaleAnimation?.removeListener(_onScaleAnimation);
    }
    _gestureType = null;

    _scaleStart = state.zoomLevel;
  }

  void handleScaleUpdate(ScaleUpdateDetails details) {
    _isMarkedAsMoved = true;
    if (_gestureType == _GestureType.pan) {
      // ジェスチャーが最初に開始されたとき、2本の指で行うジェスチャーでも、
      // スケールや回転に変化がない場合がある。
      // ここでは、最初にpanとしてマークされた後、
      // 正しいタイプとして再解釈できるようにしています。
      _gestureType = _getGestureType(details);
    } else {
      _gestureType = _getGestureType(details);
    }
    final scale = state.zoomLevel;
    switch (_gestureType) {
      case _GestureType.pan:
        if (details.scale != 1.0) {
          return;
        }
        state = state.move(
          Offset(details.focalPointDelta.dx, details.focalPointDelta.dy) /
              state.zoomLevel,
        );
      case _GestureType.scale:
        assert(_scaleStart != null);
        final desiredScale = _scaleStart! * details.scale;
        // スケール中に ユーザの2本指はシーン内で同じ位置にあるはず
        // つまり、FocalPointのシーン内の位置はスケーリングの前後で変化しない
        state = state
            .setScale(
              desiredScale,
              focalPoint:
                  details.focalPoint - _renderBox!.localToGlobal(Offset.zero),
            )
            .move(details.focalPointDelta / scale);
      case _GestureType.rotate:
      case null:
        break;
    }
  }

  void handleScaleEnd(ScaleEndDetails details) {
    //  state = state.copyWith(
    //    zoomLevel: _scaleStart,
    //  );
    _moveAnimation?.removeListener(_onMoveAnimation);
    _scaleAnimation?.removeListener(_onScaleAnimation);

    _moveController.reset();
    _scaleController.reset();
    _scaleStart = null;

    if (_gestureType == _GestureType.pan) {
      if (details.velocity.pixelsPerSecond.distance < kMinFlingVelocity) {
        return;
      }
      final translation = state.offset;
      final frictionSimulationX = FrictionSimulation(
        _interactionEndFrictionCoefficient,
        translation.dx,
        -details.velocity.pixelsPerSecond.dx / state.zoomLevel,
      );
      final frictionSimulationY = FrictionSimulation(
        _interactionEndFrictionCoefficient,
        translation.dy,
        -details.velocity.pixelsPerSecond.dy / state.zoomLevel,
      );
      final tFinal = _getFinalTime(
        details.velocity.pixelsPerSecond.distance,
        _interactionEndFrictionCoefficient,
      );
      _moveAnimation = Tween<Offset>(
        begin: translation,
        end: Offset(frictionSimulationX.finalX, frictionSimulationY.finalX),
      ).animate(
        CurvedAnimation(
          parent: _moveController,
          curve: Curves.decelerate,
        ),
      );
      _moveController.duration =
          Duration(milliseconds: (tFinal * 1000).round());
      _moveAnimation!.addListener(_onMoveAnimation);
      _moveController.forward();
    } else if (_gestureType == _GestureType.scale) {
      if (details.scaleVelocity.abs() < 0.1) {
        return;
      }
      final scale = state.zoomLevel;
      final frictionSimulation = FrictionSimulation(
        _interactionEndFrictionCoefficient * kDefaultMouseScrollToScaleFactor,
        scale,
        details.scaleVelocity / 10,
      );
      final tFinal = _getFinalTime(
        details.scaleVelocity.abs(),
        _interactionEndFrictionCoefficient * kDefaultMouseScrollToScaleFactor,
        effectivelyMotionless: 0.1,
      );
      _scaleAnimation = Tween<double>(
        begin: scale,
        end: frictionSimulation.x(tFinal),
      ).animate(
        CurvedAnimation(
          parent: _scaleController,
          curve: Curves.decelerate,
        ),
      );
      _scaleController.duration =
          Duration(milliseconds: (tFinal * 1000).round());
      _scaleAnimation!.addListener(_onScaleAnimation);
      _scaleController.forward();
    }
  }

  // Given a velocity and drag, calculate the time at which motion will come to
  // a stop, within the margin of effectivelyMotionless.
  double _getFinalTime(
    double velocity,
    double drag, {
    double effectivelyMotionless = 10,
  }) {
    return math.log(effectivelyMotionless / velocity) / math.log(drag / 100);
  }

  void recievedPointerSignal(PointerSignalEvent event) {
    final double scaleChange;
    if (event is PointerScrollEvent) {
      if (event.kind == PointerDeviceKind.trackpad) {
        // トラックパッドのスクロールなので Pan として扱う
        handleScaleStart(
          ScaleStartDetails(
            focalPoint: event.position,
            localFocalPoint: event.localPosition,
          ),
        );

        final localDelta = PointerEvent.transformDeltaViaPositions(
          untransformedEndPosition: event.position + event.scrollDelta,
          untransformedDelta: event.scrollDelta,
          transform: event.transform,
        );

        state = state.move(localDelta / state.zoomLevel);
        return;
      }

      // Ignore left and right mouse wheel scroll.
      if (event.scrollDelta.dy == 0.0) {
        return;
      }
      scaleChange =
          math.exp(-event.scrollDelta.dy / kDefaultMouseScrollToScaleFactor);
    } else if (event is PointerScaleEvent) {
      scaleChange = event.scale;
    } else {
      return;
    }
    handleScaleStart(
      ScaleStartDetails(
        focalPoint: event.position,
        localFocalPoint: event.localPosition,
      ),
    );
    handleScaleUpdate(
      ScaleUpdateDetails(
        focalPoint: event.position,
        localFocalPoint: event.localPosition,
        scale: scaleChange,
      ),
    );
    handleScaleEnd(
      ScaleEndDetails(),
    );
  }

  Future<void> animatedMoveTo(
    LatLng target, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCirc,
  }) async {
    // 既存のAnimationがあったらキャンセルする
    _moveAnimation?.removeListener(_onMoveAnimation);
    _scaleAnimation?.removeListener(_onScaleAnimation);
    _moveController.reset();
    _scaleController.reset();

    final start = state.offset;
    final after = state.setCenterLatLng(target, _renderBox!.size).offset;

    final animation = Tween<Offset>(
      begin: start,
      end: after,
    ).animate(
      CurvedAnimation(
        parent: _moveController,
        curve: curve,
      ),
    );
    _moveController.duration = duration;
    _moveAnimation = animation;
    _moveAnimation!.addListener(_onMoveAnimation);
    await _moveController.forward();
  }

  Future<void> animatedZoomTo(
    double target, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCirc,
  }) async {
    // 既存のAnimationがあったらキャンセルする
    _moveAnimation?.removeListener(_onMoveAnimation);
    _scaleAnimation?.removeListener(_onScaleAnimation);
    _moveController.reset();
    _scaleController.reset();

    final start = state;
    final after = state.setScale(
      target,
      focalPoint: _renderBox!.size.center(Offset.zero) / state.zoomLevel,
    );
    // moveAnimation
    final animation = Tween<Offset>(
      begin: start.offset,
      end: after.offset,
    ).animate(
      CurvedAnimation(
        parent: _moveController,
        curve: curve,
      ),
    );
    _moveController.duration = duration;
    _moveAnimation = animation;
    _moveAnimation!.addListener(_onMoveAnimation);
    // scaleAnimation
    final scaleAnimation = Tween<double>(
      begin: start.zoomLevel,
      end: after.zoomLevel,
    ).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: curve,
      ),
    );
    _scaleController.duration = duration;
    _scaleAnimation = scaleAnimation;
    _scaleAnimation!.addListener(_onScaleAnimation);
    await (
      _moveController.forward(),
      _scaleController.forward(),
    ).wait;
  }

  Future<void> animatedBounds(
    List<LatLng> bounds, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCirc,
  }) async {
    if (_renderBox == null) {
      throw Exception('MapController is not initialized.');
    }
    // 既存のAnimationがあったらキャンセルする
    _moveAnimation?.removeListener(_onMoveAnimation);
    _scaleAnimation?.removeListener(_onScaleAnimation);
    _globalPointAndZoomLevelAnimation
        ?.removeListener(_onGlobalPointAndZoomLevelAnimation);
    _moveController.reset();
    _scaleController.reset();
    _globalPointAndZoomLevelController.reset();

    final startCenterGlobalPoint =
        state.offsetToGlobalPoint(_renderBox!.size.center(Offset.zero));
    final startZoomLevel = state.zoomLevel;

    final after = state.fitBounds(bounds, _renderBox!.size);
    final afterCenterGlobalPoint =
        after.offsetToGlobalPoint(_renderBox!.size.center(Offset.zero));
    final afterZoomLevel = after.zoomLevel;

    // moveAnimation
    final animation = GlobalPointAndZoomLevelTween(
      begin: (startCenterGlobalPoint, startZoomLevel),
      end: (afterCenterGlobalPoint, afterZoomLevel),
    ).animate(
      CurvedAnimation(
        parent: _globalPointAndZoomLevelController,
        curve: curve,
      ),
    );
    _globalPointAndZoomLevelController.duration = duration;
    _globalPointAndZoomLevelAnimation = animation;
    _globalPointAndZoomLevelAnimation!
        .addListener(_onGlobalPointAndZoomLevelAnimation);

    await _globalPointAndZoomLevelController.forward();
  }

  /// [globalPoints]を含む最小の矩形を表示する
  Future<void> animatedBoundsByGlobalPoints(
    List<GlobalPoint> globalPoints, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCirc,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double bottom = 0,
  }) async {
    if (_renderBox == null) {
      throw Exception('MapController is not initialized.');
    }
    // 既存のAnimationがあったらキャンセルする
    _moveAnimation?.removeListener(_onMoveAnimation);
    _scaleAnimation?.removeListener(_onScaleAnimation);
    _globalPointAndZoomLevelAnimation
        ?.removeListener(_onGlobalPointAndZoomLevelAnimation);
    _moveController.reset();
    _scaleController.reset();
    _globalPointAndZoomLevelController.reset();

    final startCenterGlobalPoint =
        state.offsetToGlobalPoint(_renderBox!.size.center(Offset.zero));
    final startZoomLevel = state.zoomLevel;
    final after = state.fitBoundsByGlobalPoints(
      globalPoints,
      padding
          .add(
            EdgeInsets.only(
              bottom: _renderBox!.size.height * bottom,
            ),
          )
          .deflateSize(_renderBox!.size),
    );
    final afterCenterGlobalPoint =
        after.offsetToGlobalPoint(_renderBox!.size.center(Offset.zero));
    final afterZoomLevel = after.zoomLevel;

    // moveAnimation
    final animation = GlobalPointAndZoomLevelTween(
      begin: (startCenterGlobalPoint, startZoomLevel),
      end: (afterCenterGlobalPoint, afterZoomLevel),
    ).animate(
      CurvedAnimation(
        parent: _globalPointAndZoomLevelController,
        curve: curve,
      ),
    );
    _globalPointAndZoomLevelController.duration = duration;
    _globalPointAndZoomLevelAnimation = animation;
    _globalPointAndZoomLevelAnimation!
        .addListener(_onGlobalPointAndZoomLevelAnimation);

    await _globalPointAndZoomLevelController.forward();
  }

  void registerRenderBox(RenderBox renderBox) {
    _renderBox = renderBox;
    _registerCallback?.call();
  }

  void onRegisterRenderBox(void Function() callback) {
    _registerCallback = callback;
    if (_renderBox != null) {
      callback();
    }
  }

  void registerAnimationControllers({
    required AnimationController moveController,
    required AnimationController scaleController,
    required AnimationController globalPointAndZoomLevelController,
  }) {
    _moveController = moveController;
    _scaleController = scaleController;
    _globalPointAndZoomLevelController = globalPointAndZoomLevelController;
  }
}

// A classification of relevant user gestures. Each contiguous user gesture is
// represented by exactly one _GestureType.
enum _GestureType {
  pan,
  scale,
  rotate,
}
