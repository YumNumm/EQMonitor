// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'code_name.dart';
import 'jma_intensity.dart';
import 'jma_lpgm_intensity.dart';
import 'pre_periods.dart';

part 'intensity_station_item.freezed.dart';
part 'intensity_station_item.g.dart';

@Freezed()
abstract class IntensityStationItem with _$IntensityStationItem {
  const factory IntensityStationItem({
    required CodeName value,
    @JsonKey(includeIfNull: false, name: 'max_intensity')
    JmaIntensity? maxIntensity,
    @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')
    JmaLpgmIntensity? maxLpgmIntensity,

    /// 絶対速度応答スペクトルの1.6秒～7.8秒周期帯における最大値
    @JsonKey(includeIfNull: false) num? sva,

    /// 1秒～7秒の範囲で1秒毎の周期帯における長周期地震動階級と絶対応答スペクトル
    @JsonKey(includeIfNull: false) List<PrePeriods>? prePeriods,
  }) = _IntensityStationItem;

  factory IntensityStationItem.fromJson(Map<String, Object?> json) =>
      _$IntensityStationItemFromJson(json);
}
