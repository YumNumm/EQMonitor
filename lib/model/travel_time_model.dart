import 'package:eqmonitor/const/travel_time_table/travel_time_table.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'travel_time_model.freezed.dart';

@freezed
class TravelTimeModel with _$TravelTimeModel {
  const factory TravelTimeModel({
    /// 走時表テーブル
    required List<TravelTimeTable> travelTimeTable,

    /// 走時表読み込みにかかった時間
    required Duration? loadDuration,
  }) = _TravelTimeModel;
}
