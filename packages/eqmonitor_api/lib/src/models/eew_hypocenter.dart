// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'code_name.dart';
import 'coordinate.dart';

part 'eew_hypocenter.freezed.dart';
part 'eew_hypocenter.g.dart';

/// 震源に関する情報
@Freezed()
abstract class EewHypocenter with _$EewHypocenter {
  const factory EewHypocenter({
    required CodeName value,
    required Coordinate coordinates,
    @JsonKey(includeIfNull: true)
    required num? magnitude,

    /// 震源の深さ `0`: `ごく浅い`, `700`: `700km以上`, `null`: `不明`
    @JsonKey(includeIfNull: true)
    required num? depth,
    @JsonKey(includeIfNull: false)
    CodeName? detailed,
  }) = _EewHypocenter;
  
  factory EewHypocenter.fromJson(Map<String, Object?> json) => _$EewHypocenterFromJson(json);
}
