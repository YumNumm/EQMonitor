import 'dart:math';

import 'package:eqmonitor/common/feature/map/model/lat_lng.dart';
import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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

Map<String, dynamic> _globalPointToJson(GlobalPoint? instance) =>
    <String, dynamic>{
      'x': instance?.x,
      'y': instance?.y,
    };

GlobalPoint? _globalPointFromJson(Map<String, dynamic> json) {
  return GlobalPoint(
    json['x'] as double,
    json['y'] as double,
  );
}

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
}

extension PointExtension on Point {
  Offset toOffset() => Offset(x.toDouble(), y.toDouble());
}
