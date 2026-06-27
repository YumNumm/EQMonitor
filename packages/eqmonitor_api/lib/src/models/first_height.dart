// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'revise.dart';

part 'first_height.freezed.dart';
part 'first_height.g.dart';

@Freezed()
abstract class FirstHeight with _$FirstHeight {
  const factory FirstHeight({
    /// 早いところでは既に津波到達と推定.
    /// const: true.
    @JsonKey(name: 'is_already_arrived')
    required bool isAlreadyArrived,

    /// 1観測地点以上で第1波の時刻を明瞭に観測した場合
    @JsonKey(includeIfNull: false,name: 'arrival_time')
    DateTime? arrivalTime,
    @JsonKey(includeIfNull: false)
    Revise? revise,
  }) = _FirstHeight;
  
  factory FirstHeight.fromJson(Map<String, Object?> json) => _$FirstHeightFromJson(json);
}
