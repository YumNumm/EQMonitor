// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'qualitative_height.dart';
import 'revise.dart';

part 'tsunami_region_estimation_max_height.freezed.dart';
part 'tsunami_region_estimation_max_height.g.dart';

/// 津波の予想高さ(推定値)
@Freezed()
abstract class TsunamiRegionEstimationMaxHeight with _$TsunamiRegionEstimationMaxHeight {
  const factory TsunamiRegionEstimationMaxHeight({
    @JsonKey(includeIfNull: false,name: 'observed_at')
    DateTime? observedAt,

    /// 津波警報以上でまだ津波の観測値が小さい場合は出現しない
    @JsonKey(includeIfNull: false)
    num? value,

    /// 10m超となる時に出現する 取りうる値はtrueのみ.
    /// const: true.
    @JsonKey(includeIfNull: false,name: 'is_over')
    bool? isOver,
    @JsonKey(includeIfNull: false)
    QualitativeHeight? qualitative,

    /// 津波警報以上でまだ津波の観測値が小さい場合に出現する.
    /// const: true.
    @JsonKey(includeIfNull: false,name: 'is_observing')
    bool? isObserving,
    @JsonKey(includeIfNull: false)
    Revise? revise,
  }) = _TsunamiRegionEstimationMaxHeight;
  
  factory TsunamiRegionEstimationMaxHeight.fromJson(Map<String, Object?> json) => _$TsunamiRegionEstimationMaxHeightFromJson(json);
}
