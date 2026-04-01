// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'top_left.dart';
import 'bottom_right.dart';

part 'region.freezed.dart';
part 'region.g.dart';

@Freezed()
abstract class Region with _$Region {
  const factory Region({
    required TopLeft topLeft,
    required BottomRight bottomRight,
  }) = _Region;
  
  factory Region.fromJson(Map<String, Object?> json) => _$RegionFromJson(json);
}
