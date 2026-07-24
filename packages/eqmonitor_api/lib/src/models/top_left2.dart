// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_left2.freezed.dart';
part 'top_left2.g.dart';

@Freezed()
abstract class TopLeft2 with _$TopLeft2 {
  const factory TopLeft2({
    required num latitude,
    required num longitude,
  }) = _TopLeft2;

  factory TopLeft2.fromJson(Map<String, Object?> json) => _$TopLeft2FromJson(json);
}
