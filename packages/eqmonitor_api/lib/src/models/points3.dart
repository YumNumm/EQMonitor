// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'location3.dart';

part 'points3.freezed.dart';
part 'points3.g.dart';

@Freezed()
abstract class Points3 with _$Points3 {
  const factory Points3({
    required String code,
    required String name,
    required String region,
    required String type,
    required Location3 location,
    @JsonKey(includeIfNull: true)
    required num? intensity,
    @Default(0)
    num intensityDiff,
  }) = _Points3;

  factory Points3.fromJson(Map<String, Object?> json) => _$Points3FromJson(json);
}
