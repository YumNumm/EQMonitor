import 'package:eqapi_types/src/model/v2/common/code_name.dart';
import 'package:eqapi_types/src/model/v2/enum/intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity.freezed.dart';
part 'intensity.g.dart';

/// 震度情報の各項目
@freezed
abstract class IntensityItem with _$IntensityItem {
  const factory IntensityItem({
    required CodeName value,
    IntensityValue? maxIntensity,
    LpgmIntensityValue? maxLpgmIntensity,
  }) = _IntensityItem;

  factory IntensityItem.fromJson(Map<String, dynamic> json) =>
      _$IntensityItemFromJson(json);
}

/// 周期帯情報
@freezed
abstract class PrePeriod with _$PrePeriod {
  const factory PrePeriod({
    required int band,
    required LpgmIntensityValue lpgmIntensity,
    required double sva,
  }) = _PrePeriod;

  factory PrePeriod.fromJson(Map<String, dynamic> json) =>
      _$PrePeriodFromJson(json);
}

/// 観測点の震度情報
@freezed
abstract class IntensityStationItem with _$IntensityStationItem {
  const factory IntensityStationItem({
    required CodeName value,
    IntensityValue? maxIntensity,
    LpgmIntensityValue? maxLpgmIntensity,

    /// 絶対速度応答スペクトルの1.6秒～7.8秒周期帯における最大値
    double? sva,

    /// 1秒～7秒の範囲で1秒毎の周期帯における長周期地震動階級と絶対応答スペクトル
    List<PrePeriod>? prePeriods,
  }) = _IntensityStationItem;

  factory IntensityStationItem.fromJson(Map<String, dynamic> json) =>
      _$IntensityStationItemFromJson(json);
}

/// 震度に関する情報
@freezed
abstract class Intensity with _$Intensity {
  const factory Intensity({
    required IntensityValue maxIntensity,
    LpgmIntensityValue? maxLpgmIntensity,
    required List<IntensityItem> prefectures,
    required List<IntensityItem> regions,
    List<IntensityItem>? cities,
    List<IntensityStationItem>? stations,
  }) = _Intensity;

  factory Intensity.fromJson(Map<String, dynamic> json) =>
      _$IntensityFromJson(json);
}

/// 震度に関する情報（部分的、citiesとstationsを含まない）
@freezed
abstract class IntensityPartial with _$IntensityPartial {
  const factory IntensityPartial({
    required IntensityValue maxIntensity,
    LpgmIntensityValue? maxLpgmIntensity,
    required List<IntensityItem> prefectures,
    required List<IntensityItem> regions,
  }) = _IntensityPartial;

  factory IntensityPartial.fromJson(Map<String, dynamic> json) =>
      _$IntensityPartialFromJson(json);
}
