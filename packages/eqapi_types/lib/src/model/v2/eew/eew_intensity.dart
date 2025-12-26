import 'package:eqapi_types/src/model/v2/common/code_name.dart';
import 'package:eqapi_types/src/model/v2/enum/intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_intensity.freezed.dart';
part 'eew_intensity.g.dart';

/// 予想震度の値
@freezed
abstract class EewIntensityValue with _$EewIntensityValue {
  const factory EewIntensityValue({
    required IntensityValue value,
    required bool isOver,
  }) = _EewIntensityValue;

  factory EewIntensityValue.fromJson(Map<String, dynamic> json) =>
      _$EewIntensityValueFromJson(json);
}

/// 予想長周期地震動階級の値
@freezed
abstract class EewIntensityLpgmValue with _$EewIntensityLpgmValue {
  const factory EewIntensityLpgmValue({
    required LpgmIntensityValue value,
    required bool isOver,
  }) = _EewIntensityLpgmValue;

  factory EewIntensityLpgmValue.fromJson(Map<String, dynamic> json) =>
      _$EewIntensityLpgmValueFromJson(json);
}

/// 到達予想時刻
@Freezed(unionKey: 'type')
sealed class EewArrivalTime with _$EewArrivalTime {
  /// 時刻
  @FreezedUnionValue('TIME')
  const factory EewArrivalTime.time({
    required DateTime value,
  }) = EewArrivalTimeTime;

  /// すでに到達
  @FreezedUnionValue('ARRIVED')
  const factory EewArrivalTime.arrived() = EewArrivalTimeArrived;

  factory EewArrivalTime.fromJson(Map<String, dynamic> json) =>
      _$EewArrivalTimeFromJson(json);
}

/// EEWの震度予想項目
@freezed
abstract class EewIntensityItem with _$EewIntensityItem {
  const factory EewIntensityItem({
    required CodeName value,
    required bool isPlum,
    required bool isWarning,
    required EewIntensityValue intensity,
    EewIntensityLpgmValue? lpgmIntensity,
    required EewArrivalTime arrivalTime,
  }) = _EewIntensityItem;

  factory EewIntensityItem.fromJson(Map<String, dynamic> json) =>
      _$EewIntensityItemFromJson(json);
}

/// 予想震度に関する情報
@freezed
abstract class EewIntensity with _$EewIntensity {
  const factory EewIntensity({
    EewIntensityValue? maxIntensity,
    EewIntensityLpgmValue? maxLpgmIntensity,
    required List<EewIntensityItem> regions,
  }) = _EewIntensity;

  factory EewIntensity.fromJson(Map<String, dynamic> json) =>
      _$EewIntensityFromJson(json);
}
