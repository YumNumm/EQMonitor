import 'dart:typed_data';

import 'package:eqmonitor/const/prefecture/area_forecast_local_eew.model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kmoni_map_model.freezed.dart';

@freezed
class KmoniMapModel with _$KmoniMapModel {
  const factory KmoniMapModel({
    /// Mapに表示する日本のポリゴン
    required List<MapPolygon> mapPolygons,

    required Matrix4 mapMatrix4,

    required double mapOutlineStrokeWidth,

    required Color mapOutlineStrokeColor,

    required Color mapFillColor,

    /// マップがロードされたかどうか
    required bool isMapLoaded,
  }) = _KmoniMapModel;
}
