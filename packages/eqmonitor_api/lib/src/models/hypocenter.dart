// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'code_name.dart';
import 'coordinate.dart';
import 'depth.dart';
import 'hypocenter_auxiliary.dart';
import 'magnitude.dart';

part 'hypocenter.freezed.dart';
part 'hypocenter.g.dart';

/// 震源に関する情報
@Freezed()
abstract class Hypocenter with _$Hypocenter {
  const factory Hypocenter({
    /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
    required String code,
    required String name,
    required Magnitude magnitude,
    required Depth depth,
    @JsonKey(includeIfNull: false)
    CodeName? detailed,
    @JsonKey(includeIfNull: false)
    Coordinate? coordinates,
    @JsonKey(includeIfNull: false)
    HypocenterAuxiliary? auxiliary,
  }) = _Hypocenter;
  
  factory Hypocenter.fromJson(Map<String, Object?> json) => _$HypocenterFromJson(json);
}
