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

extension MapStateProjection on MapState {
  /// GlobalPointをOffsetに変換する
  Offset globalPointToOffset(GlobalPoint point) {
    return Offset(
      point.x * zoomLevel + offset.dx,
      point.y * zoomLevel + offset.dy,
    );
  }

  /// 画面座標OffsetをGlobalPointに変換する
  GlobalPoint offsetToGlobalPoint(Offset offset) {
    return Point(
      offset.dx / zoomLevel - this.offset.dx,
      offset.dy / zoomLevel - this.offset.dy,
    );
  }

  Offset latLngToOffset(LatLng latLng) {
    return globalPointToOffset(
      WebMercatorProjection().project(latLng),
    );
  }

  MapState move(Offset offset) {
    return copyWith(
      offset: this.offset + offset,
    );
  }

  MapState setOffset(Offset offset) {
    return copyWith(
      offset: offset,
    );
  }

  MapState moveCenter(Point<double> offset, Size size) {
    // 中心を移動する
    final focalPoint = globalPointToOffset(offset);
    final newOffset = focalPoint;
    debugPrint('focalPoint: $focalPoint');
    return move(newOffset);
  }

  MapState scale(double scale) {
    return copyWith(
      zoomLevel: scale,
    );
  }

  MapState setScale(double scale) {
    return copyWith(
      zoomLevel: scale,
    );
  }
}

extension PointExtension on Point {
  Offset toOffset() => Offset(x.toDouble(), y.toDouble());
}
