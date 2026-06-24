// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'depth_type.dart';

part 'depth.freezed.dart';
part 'depth.g.dart';

/// 震源の深さ
@Freezed()
abstract class Depth with _$Depth {
  const factory Depth({
    required DepthType type,

    /// typeがNORMALのときのみ出現する
    @JsonKey(includeIfNull: false)
    num? value,
  }) = _Depth;
  
  factory Depth.fromJson(Map<String, Object?> json) => _$DepthFromJson(json);
}
