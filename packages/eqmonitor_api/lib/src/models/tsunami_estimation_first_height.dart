// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_estimation_first_height.freezed.dart';
part 'tsunami_estimation_first_height.g.dart';

@Freezed()
abstract class TsunamiEstimationFirstHeight
    with _$TsunamiEstimationFirstHeight {
  const factory TsunamiEstimationFirstHeight({
    @JsonKey(name: 'is_already_arrived') required bool isAlreadyArrived,
    @JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,
  }) = _TsunamiEstimationFirstHeight;

  factory TsunamiEstimationFirstHeight.fromJson(Map<String, Object?> json) =>
      _$TsunamiEstimationFirstHeightFromJson(json);
}
