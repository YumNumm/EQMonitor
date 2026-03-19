// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'coordinate_type.dart';

part 'coordinate.freezed.dart';
part 'coordinate.g.dart';

/// 震源座標
@Freezed()
abstract class Coordinate with _$Coordinate {
  const factory Coordinate({
    required CoordinateType type,

    /// 緯度(typeがLAT_LNGのときのみ出現する)
    @JsonKey(includeIfNull: false)
    num? latitude,

    /// 経度(typeがLAT_LNGのときのみ出現する)
    @JsonKey(includeIfNull: false)
    num? longitude,

    /// 不明の場合のみ出現する
    @JsonKey(includeIfNull: false)
    String? condition,
  }) = _Coordinate;
  
  factory Coordinate.fromJson(Map<String, Object?> json) => _$CoordinateFromJson(json);
}
