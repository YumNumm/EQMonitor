import 'dart:math';
import 'dart:math' as math;

import 'package:eqmonitor/core/component/map/utils/web_mercator_projection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'map_state.freezed.dart';
part 'map_state.g.dart';

@freezed
class MapState with _$MapState {
  const factory MapState({
    @JsonKey(fromJson: _offsetFromJson, toJson: _offsetToJson)
    required Offset offset,
    required double zoomLevel,
  }) = _MapState;

  factory MapState.fromJson(Map<String, dynamic> json) =>
      _$MapStateFromJson(json);
}

Offset _offsetFromJson(Map<String, dynamic> json) {
  return Offset(
    json['dx'] as double,
    json['dy'] as double,
  );
}

Map<String, dynamic> _offsetToJson(Offset instance) => <String, dynamic>{
      'dx': instance.dx,
      'dy': instance.dy,
    };

extension MapStateProjection on MapState {
  /// GlobalPointをOffsetに変換する
  Offset globalPointToOffset(GlobalPoint point) {
    return Offset(
      (point.x - offset.dx) * zoomLevel,
      (point.y - offset.dy) * zoomLevel,
    );
  }

  /// 画面座標OffsetをGlobalPointに変換する
  GlobalPoint offsetToGlobalPoint(Offset offset) {
    return GlobalPoint(
      offset.dx / zoomLevel + this.offset.dx,
      offset.dy / zoomLevel + this.offset.dy,
    );
  }

  /// [intercept] ZoomLevelのみ適用したList<Point>を引数とし、中間処理を行う。
  /// その後、Offsetを適用する
  List<Offset>? globalPointsToOffsetsIntercepted({
    required List<GlobalPoint> points,
    required String id,
    required List<GlobalPoint>? Function({
      required List<GlobalPoint> points,
      required int zoomLevel,
      required String id,
    }) intercept,
  }) {
    final globalPoints = intercept(
      points: points,
      zoomLevel: zoomLevel.truncate(),
      id: id,
    );
    return globalPoints
        ?.map(
          globalPointToOffset,
        )
        .toList();
  }

  List<List<Offset>> globalPointsToOffsetsFeaturesIntercepted({
    required List<List<GlobalPoint>> features,
    required String id,
    required List<List<GlobalPoint>> Function({
      required List<List<GlobalPoint>> points,
      required int zoomLevel,
      required String id,
    }) intercept,
  }) {
    final globalPoints = intercept(
      points: features,
      zoomLevel: zoomLevel.toInt(),
      id: id,
    );
    return globalPoints
        .map(
          (e) => e
              .map(
                globalPointToOffset,
              )
              .toList(),
        )
        .toList();
  }

  Offset latLngToOffset(LatLng latLng) {
    return globalPointToOffset(
      WebMercatorProjection().project(latLng),
    );
  }

  MapState move(Offset offset) {
    return copyWith(
      offset: this.offset - offset,
    );
  }

  MapState setOffset(Offset offset) {
    return copyWith(
      offset: offset,
    );
  }

  /// 中心座標を[latLng]にする
  MapState setCenterLatLng(LatLng latLng, Size size) {
    final globalPoint = WebMercatorProjection().project(latLng);
    return copyWith(
      offset: Offset(globalPoint.x, globalPoint.y),
    ).move(Offset(size.width / 2, size.height / 2) / zoomLevel);
  }

  /// 中心座標を[point]にする
  MapState setCenter(GlobalPoint point, Size size) {
    return copyWith(
      offset: Offset(point.x, point.y),
    ).move(Offset(size.width / 2, size.height / 2) / zoomLevel);
  }

  LatLngBoundary getLatLngBoundary(Size size) {
    final topLeft = offsetToGlobalPoint(Offset.zero);
    final bottomRight = offsetToGlobalPoint(size.bottomRight(Offset.zero));
    final topLeftLatLng = WebMercatorProjection().unproject(topLeft);
    final bottomRightLatLng = WebMercatorProjection().unproject(bottomRight);
    return LatLngBoundary.fromTwo(
      topLeftLatLng,
      bottomRightLatLng,
    );
  }

  /// 中心座標を維持して拡大縮小する
  MapState setScale(double scale, {Offset focalPoint = Offset.zero}) {
    var mapState = this;
    final beforeFocalPoint = mapState.offsetToGlobalPoint(focalPoint);
    mapState = mapState.copyWith(
      zoomLevel: scale,
    );
    final afterFocalPoint = mapState.offsetToGlobalPoint(focalPoint);
    final diff = afterFocalPoint - beforeFocalPoint;
    return mapState.move(diff.toOffset() / zoomLevel).move(diff.toOffset());
  }

  /// [latLngs]を含む最小の矩形を表示する
  MapState fitBounds(
    List<LatLng> latLngs,
    Size widgetSize, {
    double maxZoom = 300,
  }) {
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
    final points = [
      LatLng(minLat, minLng),
      LatLng(maxLat, maxLng),
    ].map((e) => WebMercatorProjection().project(e));

    return fitBoundsByGlobalPoints(
      points.toList(),
      widgetSize,
      maxZoom: maxZoom,
    );
  }

  MapState fitBoundsByGlobalPoints(
    List<GlobalPoint> points,
    Size widgetSize, {
    double maxZoom = 300,
  }) {
    final (min, max) = _getBounds(points);
    final center = GlobalPoint(
      (min.x + max.x) / 2,
      (min.y + max.y) / 2,
    );
    final size = widgetSize;

    final scale = math.min(
      maxZoom,
      math.min(
        size.width / (max.x - min.x),
        size.height / (max.y - min.y),
      ),
    );
    return setScale(
      scale,
    ).setCenter(
      center,
      widgetSize,
    );
  }

  /// [points]を含む最小の矩形を返す
  (
    GlobalPoint min,
    GlobalPoint max,
  ) _getBounds(Iterable<GlobalPoint> points) {
    final xs = points.map((e) => e.x);
    final ys = points.map((e) => e.y);
    final minX = xs.reduce(min);
    final maxX = xs.reduce(max);
    final minY = ys.reduce(min);
    final maxY = ys.reduce(max);
    return (
      GlobalPoint(minX, minY),
      GlobalPoint(maxX, maxY),
    );
  }
}

extension PointExtension on Point {
  Offset toOffset() => Offset(x.toDouble(), y.toDouble());
}
