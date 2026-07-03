// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'revise.dart';

part 'tsunami_region_estimation_first_height.freezed.dart';
part 'tsunami_region_estimation_first_height.g.dart';

@Freezed()
abstract class TsunamiRegionEstimationFirstHeight with _$TsunamiRegionEstimationFirstHeight {
  const factory TsunamiRegionEstimationFirstHeight({
    /// 1観測地点以上で第1波の時刻を明瞭に観測した場合
    @JsonKey(includeIfNull: false,name: 'arrival_time')
    DateTime? arrivalTime,

    /// 早いところでは既に津波到達と推定.
    /// const: true.
    @JsonKey(includeIfNull: false,name: 'is_already_arrived')
    bool? isAlreadyArrived,
    @JsonKey(includeIfNull: false)
    Revise? revise,
  }) = _TsunamiRegionEstimationFirstHeight;
  
  factory TsunamiRegionEstimationFirstHeight.fromJson(Map<String, Object?> json) => _$TsunamiRegionEstimationFirstHeightFromJson(json);
}
