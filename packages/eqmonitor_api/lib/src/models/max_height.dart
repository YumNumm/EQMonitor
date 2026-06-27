// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'qualitative_height.dart';
import 'revise.dart';

part 'max_height.freezed.dart';
part 'max_height.g.dart';

@Freezed()
abstract class MaxHeight with _$MaxHeight {
  const factory MaxHeight({
    /// 10m超となる時に出現する 取りうる値はtrueのみ.
    /// const: true.
    @JsonKey(name: 'is_over')
    required bool isOver,

    /// 津波警報以上でまだ津波の観測値が小さい場合に出現する.
    /// const: true.
    @JsonKey(name: 'is_observing')
    required bool isObserving,
    @JsonKey(includeIfNull: false,name: 'observed_at')
    DateTime? observedAt,

    /// 津波警報以上でまだ津波の観測値が小さい場合は出現しない
    @JsonKey(includeIfNull: false)
    num? value,
    @JsonKey(includeIfNull: false)
    QualitativeHeight? qualitative,
    @JsonKey(includeIfNull: false)
    Revise? revise,
  }) = _MaxHeight;
  
  factory MaxHeight.fromJson(Map<String, Object?> json) => _$MaxHeightFromJson(json);
}
