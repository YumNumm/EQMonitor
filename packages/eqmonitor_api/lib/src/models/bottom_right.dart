// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_right.freezed.dart';
part 'bottom_right.g.dart';

@Freezed()
abstract class BottomRight with _$BottomRight {
  const factory BottomRight({
    required num latitude,
    required num longitude,
  }) = _BottomRight;
  
  factory BottomRight.fromJson(Map<String, Object?> json) => _$BottomRightFromJson(json);
}
