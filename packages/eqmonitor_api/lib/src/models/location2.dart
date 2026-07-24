// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'location2.freezed.dart';
part 'location2.g.dart';

@Freezed()
abstract class Location2 with _$Location2 {
  const factory Location2({
    required num latitude,
    required num longitude,
  }) = _Location2;

  factory Location2.fromJson(Map<String, Object?> json) => _$Location2FromJson(json);
}
