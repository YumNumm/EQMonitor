// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter_location.freezed.dart';
part 'parameter_location.g.dart';

@Freezed()
abstract class ParameterLocation with _$ParameterLocation {
  const factory ParameterLocation({
    required num latitude,
    required num longitude,
  }) = _ParameterLocation;
  
  factory ParameterLocation.fromJson(Map<String, Object?> json) => _$ParameterLocationFromJson(json);
}
