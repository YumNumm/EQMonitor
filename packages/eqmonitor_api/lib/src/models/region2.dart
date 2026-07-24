// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'top_left2.dart';
import 'bottom_right2.dart';

part 'region2.freezed.dart';
part 'region2.g.dart';

@Freezed()
abstract class Region2 with _$Region2 {
  const factory Region2({
    required TopLeft2 topLeft,
    required BottomRight2 bottomRight,
  }) = _Region2;

  factory Region2.fromJson(Map<String, Object?> json) => _$Region2FromJson(json);
}
