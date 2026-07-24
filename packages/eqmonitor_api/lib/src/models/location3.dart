// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'location3.freezed.dart';
part 'location3.g.dart';

@Freezed()
abstract class Location3 with _$Location3 {
  const factory Location3({
    required num latitude,
    required num longitude,
  }) = _Location3;

  factory Location3.fromJson(Map<String, Object?> json) => _$Location3FromJson(json);
}
