import 'dart:developer';
import 'dart:math' hide log;

import 'package:eqmonitor/common/feature/map/model/lat_lng.dart';
import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/feature/home/component/map/model/map_state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'base_map_viemwodel.g.dart';

@riverpod
class BaseMapViewModel extends _$BaseMapViewModel {
  @override
  MapState build() => const MapState(
        offset: Offset.zero,
        zoomLevel: 1,
      );

  double? _scaleStart;
  Offset? _referenceFocalPoint;
  Size? _widgetSize;

  void handleScaleStart(ScaleStartDetails details) {
    if (details.pointerCount == 1) {
      return;
    }
    _scaleStart = state.zoomLevel;
    _referenceFocalPoint = state.globalPointToOffset(
      Point(details.localFocalPoint.dx, details.localFocalPoint.dy),
    );
  }

  void handleScaleUpdate(ScaleUpdateDetails details) {
    log(_widgetSize.toString());
    var mapState = state;
    if (details.pointerCount == 1) {
      debugPrint('handleScaleUpdate: ${details.focalPointDelta}');
      handlePanUpdate(
        Offset(details.focalPointDelta.dx, details.focalPointDelta.dy),
      );
      return;
    }
    assert(_scaleStart != null);
    // FocalPointのGlobalPointを取得
    final focalGlobalPoint = state.offsetToGlobalPoint(
      details.localFocalPoint,
    );
    // scale
    final desiredScale = _scaleStart! * details.scale;
    mapState = mapState.setScale(
      desiredScale,
    );
    // focalPointを中心にズーム
    final newFocalPoint = mapState.offsetToGlobalPoint(details.localFocalPoint);
    // ズレた分を計算
    final focalPointDelta = focalGlobalPoint - newFocalPoint;
    log('focalPointDelta: $focalPointDelta');
    // ズレた分を戻す

    // move
    state = mapState;
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

  set centerLatLng(LatLng latLng) {
    final centerPoint = WebMercatorProjection().project(latLng);
    final offset = state.globalPointToOffset(centerPoint);
    final widgetCenter =
        Offset(_widgetSize!.width / 2, _widgetSize!.height / 2);
    final newOffset = widgetCenter - offset;
    state = state.move(newOffset);
  }

  set zoomLevel(double zoom) {
    state = state.setScale(zoom);
  }

  /// [latLngs]を含む最小の矩形を表示する
  void fitBounds(List<LatLng> latLngs) {
    final points = latLngs.map((e) => WebMercatorProjection().project(e));
    final bounds = _getBounds(points);
    final topLeft =
        state.globalPointToOffset(Point(bounds.topLeft.dx, bounds.topLeft.dy));
    final bottomRight = state.globalPointToOffset(
      Point(bounds.bottomRight.dx, bounds.bottomRight.dy),
    );
    final widgetSize = _widgetSize!;
    final widgetCenter = Offset(widgetSize.width / 2, widgetSize.height / 2);
    final newOffset = widgetCenter - (topLeft + bottomRight) / 2;
    final newZoom = min(
      widgetSize.width / (bottomRight.dx - topLeft.dx),
      widgetSize.height / (bottomRight.dy - topLeft.dy),
    );
    state = state
        .move(newOffset)
        .setScale(newZoom)
        .move(Offset(widgetSize.width / 2, widgetSize.height / 2));
  }

  /// [points]を含む最小の矩形を返す
  Rect _getBounds(Iterable<Point> points) {
    final xs = points.map((e) => e.x);
    final ys = points.map((e) => e.y);
    final minX = xs.reduce(min);
    final maxX = xs.reduce(max);
    final minY = ys.reduce(min);
    final maxY = ys.reduce(max);
    return Rect.fromLTRB(
      minX.toDouble(),
      minY.toDouble(),
      maxX.toDouble(),
      maxY.toDouble(),
    );
  }
}
