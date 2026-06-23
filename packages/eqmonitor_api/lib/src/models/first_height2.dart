// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'first_height_condition.dart';
import 'revise.dart';

part 'first_height2.freezed.dart';
part 'first_height2.g.dart';

@Freezed()
abstract class FirstHeight2 with _$FirstHeight2 {
  const factory FirstHeight2({
    /// まだ津波が到達していない場合、到達していないと推測される場合に出現する
    @JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,
    @JsonKey(includeIfNull: false) FirstHeightCondition? condition,
    @JsonKey(includeIfNull: false) Revise? revise,
  }) = _FirstHeight2;

  factory FirstHeight2.fromJson(Map<String, Object?> json) =>
      _$FirstHeight2FromJson(json);
}
