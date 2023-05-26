import 'dart:developer';
import 'dart:math' as math;

import 'package:eqmonitor/common/component/map/model/map_state.dart';
import 'package:eqmonitor/common/feature/map/model/lat_lng.dart';
import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_viemwodel.g.dart';

@riverpod
class MapViewModel extends _$MapViewModel {
  @override
  MapState build() {
    ref.listenSelf((previous, next) {
      //log(next.toString());
    });
    return const MapState(
      offset: Offset.zero,
      zoomLevel: 1,
    );
  }

  double? _scaleStart;
  GlobalPoint? _referenceFocalPoint;
  Size? _widgetSize;
  LatLng? _scaleStartedLatLng;

  Animation<Offset>? moveAnimation;
  Animation<double>? scaleAnimation;
  late AnimationController controller;
  late AnimationController scaleController;

  double interactionEndFrictionCoefficient = 0.0000135;

  _GestureType? _gestureType;

  /// The minimum velocity for a touch to consider that touch to trigger a fling
  /// gesture.
  static const double kMinFlingVelocity = 50; // Logical pixels / second
  /// The default conversion factor when treating mouse scrolling as scaling.
  ///
  /// The value was arbitrarily chosen to feel natural for most mousewheels on
  /// all supported platforms.
  static const double kDefaultMouseScrollToScaleFactor = 200;

  /// moveAnimationのリスナー
  void _onMoveAnimation() {
    if (!controller.isAnimating) {
      moveAnimation?.removeListener(_onMoveAnimation);
      moveAnimation = null;
      controller.reset();
      return;
    }
    state = state.copyWith(
      offset: moveAnimation!.value,
    );
  }

  void _onScaleAnimation() {
    if (!scaleController.isAnimating) {
      scaleAnimation?.removeListener(_onScaleAnimation);
      scaleAnimation = null;
      scaleController.reset();
      return;
    }
    state = state.copyWith(
      zoomLevel: scaleAnimation!.value,
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
    if (controller.isAnimating) {
      controller
        ..stop()
        ..reset();
      moveAnimation?.removeListener(_onMoveAnimation);
    }
    if (scaleController.isAnimating) {
      scaleController
        ..stop()
        ..reset();
      scaleAnimation?.removeListener(_onScaleAnimation);
    }
    _gestureType = null;

    _scaleStart = state.zoomLevel;
    _referenceFocalPoint = state.offsetToGlobalPoint(
      details.focalPoint,
    );
    _scaleStartedLatLng = WebMercatorProjection().unproject(
      _referenceFocalPoint!,
    );
  }

  void handleScaleUpdate(ScaleUpdateDetails details) {
    if (_gestureType == _GestureType.pan) {
      // When a gesture first starts, it sometimes has no change in scale and
      // rotation despite being a two-finger gesture. Here the gesture is
      // allowed to be reinterpreted as its correct type after originally
      // being marked as a pan.
      _gestureType = _getGestureType(details);
    } else {
      _gestureType ??= _getGestureType(details);
    }
    final scale = state.zoomLevel;
    if (details.pointerCount == 1) {
      debugPrint('handleScaleUpdate: ${details.focalPointDelta}');
      handlePanUpdate(
        Offset(details.focalPointDelta.dx, details.focalPointDelta.dy) /
            state.zoomLevel,
      );
      return;
    }

    assert(_scaleStart != null);
    final desiredScale = _scaleStart! * details.scale;
    // スケール中に ユーザの2本指はシーン内で同じ位置にあるはず
    // つまり、FocalPointのシーン内の位置はスケーリングの前後で変化しない

    // _scaleStartedLatLngの位置を保ったまま、スケーリングする
    state = state
        .setScale(desiredScale, focalPoint: details.focalPoint)
        .move(details.focalPointDelta / scale);
  }

  void handleScaleEnd(ScaleEndDetails details) {
    //  state = state.copyWith(
    //    zoomLevel: _scaleStart,
    //  );
    moveAnimation?.removeListener(_onMoveAnimation);
    scaleAnimation?.removeListener(_onScaleAnimation);

    controller.reset();
    scaleController.reset();

    log(_gestureType.toString(), name: 'GestureType');

    if (_gestureType == _GestureType.pan) {
      if (details.velocity.pixelsPerSecond.distance < kMinFlingVelocity) {
        return;
      }
      // log('MOVE ANIMATION!');
      final translation = state.offset;
      final frictionSimulationX = FrictionSimulation(
        interactionEndFrictionCoefficient,
        translation.dx,
        -details.velocity.pixelsPerSecond.dx / state.zoomLevel,
      );
      final frictionSimulationY = FrictionSimulation(
        interactionEndFrictionCoefficient,
        translation.dy,
        -details.velocity.pixelsPerSecond.dy / state.zoomLevel,
      );
      final tFinal = _getFinalTime(
        details.velocity.pixelsPerSecond.distance,
        interactionEndFrictionCoefficient,
      );
      moveAnimation = Tween<Offset>(
        begin: translation,
        end: Offset(frictionSimulationX.finalX, frictionSimulationY.finalX),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.decelerate,
        ),
      );
      controller.duration = Duration(milliseconds: (tFinal * 1000).round());
      moveAnimation!.addListener(_onMoveAnimation);
      controller.forward();
    } else if (_gestureType == _GestureType.scale) {
      if (details.scaleVelocity.abs() < 0.1) {
        return;
      }
      // log('SCALE ANIMATION!');
      final scale = state.zoomLevel;
      final frictionSimulation = FrictionSimulation(
        interactionEndFrictionCoefficient * kDefaultMouseScrollToScaleFactor,
        scale,
        details.scaleVelocity / 10,
      );
      final tFinal = _getFinalTime(
        details.scaleVelocity.abs(),
        interactionEndFrictionCoefficient * kDefaultMouseScrollToScaleFactor,
        effectivelyMotionless: 0.1,
      );
      scaleAnimation = Tween<double>(
        begin: scale,
        end: frictionSimulation.x(tFinal),
      ).animate(
        CurvedAnimation(
          parent: scaleController,
          curve: Curves.decelerate,
        ),
      );
      scaleController.duration =
          Duration(milliseconds: (tFinal * 1000).round());
      scaleAnimation!.addListener(_onScaleAnimation);
      scaleController.forward();
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

  void handlePanUpdate(Offset delta) {
    state = state.move(delta);
  }

  void reset() {
    state = const MapState(
      offset: Offset.zero,
      zoomLevel: 1,
    );
  }

  void registerWidgetSize(Size size) {
    log(size.toString());
    _widgetSize = size;
  }

  void registerAnimationControllers({
    required AnimationController controller,
    required AnimationController scaleController,
  }) {
    this.controller = controller;
    this.scaleController = scaleController;
  }

  // 左上の緯度経度
  LatLng get topLeftLatLng {
    final topLeftPoint = state.offsetToGlobalPoint(Offset.zero);
    return WebMercatorProjection().unproject(topLeftPoint);
  }

  // setter
  set topLeftLatLng(LatLng latLng) {
    final topLeftPoint = WebMercatorProjection().project(latLng);
    debugPrint('topLeftPoint: $topLeftPoint');
    final offset = state.globalPointToOffset(topLeftPoint);
    debugPrint('offset: $offset');
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
      focalPoint: Offset(_widgetSize!.width / 2, _widgetSize!.height / 2),
    );
  }

  /// [latLngs]を含む最小の矩形を表示する
  void fitBounds(List<LatLng> latLngs) {
    final points = latLngs.map((e) => WebMercatorProjection().project(e));
    final (min, max) = _getBounds(points);
    final center = GlobalPoint(
      (min.x + max.x) / 2,
      (min.y + max.y) / 2,
    );
    final size = _widgetSize!;

    final scale = math.min(
      size.width / (max.x - min.x),
      size.height / (max.y - min.y),
    );
    state = state.setScale(
      scale,
    );

    state = state.setCenter(
      center,
      _widgetSize!,
    );
  }

  /// [points]を含む最小の矩形を返す
  (
    GlobalPoint min,
    GlobalPoint max,
  ) _getBounds(Iterable<GlobalPoint> points) {
    final xs = points.map((e) => e.x);
    final ys = points.map((e) => e.y);
    final minX = xs.reduce(math.min);
    final maxX = xs.reduce(math.max);
    final minY = ys.reduce(math.min);
    final maxY = ys.reduce(math.max);
    return (
      GlobalPoint(minX, minY),
      GlobalPoint(maxX, maxY),
    );
  }
}

// A classification of relevant user gestures. Each contiguous user gesture is
// represented by exactly one _GestureType.
enum _GestureType {
  pan,
  scale,
  rotate,
}
