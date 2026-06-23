// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter_point.freezed.dart';
part 'parameter_point.g.dart';

@Freezed()
abstract class ParameterPoint with _$ParameterPoint {
  const factory ParameterPoint({
    required num x,
    required num y,
  }) = _ParameterPoint;

  factory ParameterPoint.fromJson(Map<String, Object?> json) =>
      _$ParameterPointFromJson(json);
}
