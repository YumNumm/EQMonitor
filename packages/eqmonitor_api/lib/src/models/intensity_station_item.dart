// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'lpgm_pre_period.dart';

part 'intensity_station_item.freezed.dart';
part 'intensity_station_item.g.dart';

@Freezed()
abstract class IntensityStationItem with _$IntensityStationItem {
  const factory IntensityStationItem({
    /// 観測点ID
    required String code,

    /// 絶対速度応答スペクトルの1.6秒～7.8秒周期帯における最大値
    @JsonKey(includeIfNull: false)
    num? sva,

    /// 1秒～7秒の範囲で1秒毎の周期帯における長周期地震動階級と絶対応答スペクトル
    @JsonKey(includeIfNull: false,name: 'pre_periods')
    List<LpgmPrePeriod>? prePeriods,
  }) = _IntensityStationItem;
  
  factory IntensityStationItem.fromJson(Map<String, Object?> json) => _$IntensityStationItemFromJson(json);
}
