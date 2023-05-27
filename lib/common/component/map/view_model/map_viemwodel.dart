import 'dart:math' as math;

import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:eqmonitor/common/component/map/model/map_state.dart';
import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_viemwodel.g.dart';

@riverpod
class MapViewModel extends _$MapViewModel {
  @override
  MapState build(Key key) {
    return const MapState(
      offset: Offset.zero,
      zoomLevel: 1,
    );
  }

  double? _scaleStart;
  Size? _widgetSize;

  Animation<Offset>? _moveAnimation;
  Animation<double>? _scaleAnimation;
  late AnimationController _moveController;
  late AnimationController _scaleController;

  final double _interactionEndFrictionCoefficient = 0.0000135;

  _GestureType? _gestureType;

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

  void _onScaleAnimation() {
    if (!_scaleController.isAnimating) {
      _scaleAnimation?.removeListener(_onScaleAnimation);
      _scaleAnimation = null;
      _scaleController.reset();
      return;
    }
    state = state.copyWith(
      zoomLevel: _scaleAnimation!.value,
    );
  }

  // Decide which type of gesture this is by comparing the amount of scale
  // and rotation in the gesture, if any. Scale starts at 1 and rotation
  // starts at 0. Pan will have no scale and no rotation because it uses only one
  // finger.
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
    if (_gestureType == _GestureType.pan) {
      // When a gesture first starts, it sometimes has no change in scale and
      // rotation despite being a two-finger gesture. Here the gesture is
      // allowed to be reinterpreted as its correct type after originally
      // being marked as a pan.
      _gestureType = _getGestureType(details);
    } else {
      _gestureType = _getGestureType(details);
    }
    final scale = state.zoomLevel;
    switch (_gestureType) {
      case _GestureType.pan:
        // details may have a change in scale here when scaleEnabled is false.
        // In an effort to keep the behavior similar whether or not scaleEnabled
        // is true, these gestures are thrown away.
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
            .setScale(desiredScale, focalPoint: details.focalPoint)
            .move(details.focalPointDelta / scale);
      default:
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

  void reset() {
    state = const MapState(
      offset: Offset.zero,
      zoomLevel: 1,
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
    final after = state.setCenterLatLng(target, _widgetSize!).offset;

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
      focalPoint: Offset(_widgetSize!.width / 2, _widgetSize!.height / 2) /
          state.zoomLevel,
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
    // 既存のAnimationがあったらキャンセルする
    _moveAnimation?.removeListener(_onMoveAnimation);
    _scaleAnimation?.removeListener(_onScaleAnimation);
    _moveController.reset();
    _scaleController.reset();

    final start = state;
    final after = state.fitBounds(bounds, _widgetSize!);

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

  void registerWidgetSize(Size size) {
    _widgetSize = size;
  }

  void registerAnimationControllers({
    required AnimationController moveController,
    required AnimationController scaleController,
  }) {
    _moveController = moveController;
    _scaleController = scaleController;
  }

  // 左上の緯度経度
  LatLng get topLeftLatLng {
    final topLeftPoint = state.offsetToGlobalPoint(Offset.zero);
    return WebMercatorProjection().unproject(topLeftPoint);
  }

  // setter
  set topLeftLatLng(LatLng latLng) {
    final topLeftPoint = WebMercatorProjection().project(latLng);
    final offset = state.globalPointToOffset(topLeftPoint);
    state = state.move(offset);
  }

  LatLng get centerLatLng {
    final centerPoint = state.offsetToGlobalPoint(
      Offset(_widgetSize!.width / 2, _widgetSize!.height / 2),
    );
    return WebMercatorProjection().unproject(centerPoint);
  }

  set centerLatLng(LatLng latLng) => state = state.setCenterLatLng(
        latLng,
        _widgetSize!,
      );

  set zoomLevel(double zoom) {
    state = state.setScale(
      zoom,
      focalPoint: Offset(_widgetSize!.width / 2, _widgetSize!.height / 2) /
          state.zoomLevel,
    );
  }

  /// [latLngs]を含む最小の矩形を表示する
  void fitBounds(
    List<LatLng> latLngs, {
    double maxZoom = 200,
  }) =>
      state = state.fitBounds(
        latLngs,
        _widgetSize!,
        maxZoom: maxZoom,
      );
}

// A classification of relevant user gestures. Each contiguous user gesture is
// represented by exactly one _GestureType.
enum _GestureType {
  pan,
  scale,
  rotate,
}
