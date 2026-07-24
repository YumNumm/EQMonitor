// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'top_left3.dart';
import 'bottom_right3.dart';

part 'region3.freezed.dart';
part 'region3.g.dart';

@Freezed()
abstract class Region3 with _$Region3 {
  const factory Region3({
    required TopLeft3 topLeft,
    required BottomRight3 bottomRight,
  }) = _Region3;

  factory Region3.fromJson(Map<String, Object?> json) => _$Region3FromJson(json);
}
