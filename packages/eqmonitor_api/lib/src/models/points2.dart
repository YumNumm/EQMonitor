// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'location2.dart';

part 'points2.freezed.dart';
part 'points2.g.dart';

@Freezed()
abstract class Points2 with _$Points2 {
  const factory Points2({
    required String code,
    required String name,
    required String region,
    required String type,
    required Location2 location,
    @JsonKey(includeIfNull: true)
    required num? intensity,
    @Default(0)
    num intensityDiff,
  }) = _Points2;

  factory Points2.fromJson(Map<String, Object?> json) => _$Points2FromJson(json);
}
