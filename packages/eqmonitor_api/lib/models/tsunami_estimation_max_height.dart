// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'qualitative_height.dart';

part 'tsunami_estimation_max_height.freezed.dart';
part 'tsunami_estimation_max_height.g.dart';

@Freezed()
abstract class TsunamiEstimationMaxHeight with _$TsunamiEstimationMaxHeight {
  const factory TsunamiEstimationMaxHeight({
    @JsonKey(includeIfNull: false,name: 'date_time')
    DateTime? dateTime,
    @JsonKey(includeIfNull: false)
    num? value,
    @JsonKey(includeIfNull: false)
    bool? over,
    @JsonKey(includeIfNull: false)
    QualitativeHeight? qualitative,
    @JsonKey(includeIfNull: false,name: 'is_observing')
    bool? isObserving,
  }) = _TsunamiEstimationMaxHeight;
  
  factory TsunamiEstimationMaxHeight.fromJson(Map<String, Object?> json) => _$TsunamiEstimationMaxHeightFromJson(json);
}
