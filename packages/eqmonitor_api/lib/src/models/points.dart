// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'location.dart';

part 'points.freezed.dart';
part 'points.g.dart';

@Freezed()
abstract class Points with _$Points {
  const factory Points({
    required String code,
    required String name,
    required String region,
    required String type,
    required Location location,
    @JsonKey(includeIfNull: true)
    required num? intensity,
    required num intensityDiff,
  }) = _Points;
  
  factory Points.fromJson(Map<String, Object?> json) => _$PointsFromJson(json);
}
