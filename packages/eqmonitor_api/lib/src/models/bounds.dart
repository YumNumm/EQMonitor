// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bounds.freezed.dart';
part 'bounds.g.dart';

@Freezed()
abstract class Bounds with _$Bounds {
  const factory Bounds({
    @JsonKey(name: 'min_longitude')
    required num minLongitude,
    @JsonKey(name: 'min_latitude')
    required num minLatitude,
    @JsonKey(name: 'max_longitude')
    required num maxLongitude,
    @JsonKey(name: 'max_latitude')
    required num maxLatitude,
  }) = _Bounds;
  
  factory Bounds.fromJson(Map<String, Object?> json) => _$BoundsFromJson(json);
}
