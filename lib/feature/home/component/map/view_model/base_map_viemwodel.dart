import 'dart:developer';
import 'dart:math' as math;

import 'package:eqmonitor/common/feature/map/model/lat_lng.dart';
import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/feature/home/component/map/model/map_state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'base_map_viemwodel.g.dart';

@riverpod
class BaseMapViewModel extends _$BaseMapViewModel {
  @override
  MapState build() {
    ref.listenSelf((previous, next) {
      log(next.toString());
    });
    return const MapState(
      offset: Offset.zero,
      zoomLevel: 1,
      focalPoint: null,
    );
  }

  double? _scaleStart;
  GlobalPoint? _referenceFocalPoint;
  Size? _widgetSize;
  LatLng? _scaleStartedLatLng;

  void handleScaleStart(ScaleStartDetails details) {
    if (details.pointerCount == 1) {
      return;
    }
    _scaleStart = state.zoomLevel;
    _referenceFocalPoint = state.offsetToGlobalPoint(
      details.focalPoint,
    );
    _scaleStartedLatLng = WebMercatorProjection().unproject(
      _referenceFocalPoint!,
    );
    log('handleScaleStart: $_scaleStartedLatLng');
  }

  void handleScaleUpdate(ScaleUpdateDetails details) {
    state = state.copyWith(
      focalPoint: state.offsetToGlobalPoint(
        details.focalPoint,
      ),
    );
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
  }

  void handlePanUpdate(Offset delta) {
    state = state.move(delta);
  }

  void reset() {
    state = const MapState(
      offset: Offset.zero,
      zoomLevel: 1,
      focalPoint: null,
    );
  }

  void registerWidgetSize(Size size) {
    log(size.toString());
    _widgetSize = size;
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
