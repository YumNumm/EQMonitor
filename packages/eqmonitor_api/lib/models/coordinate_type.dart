// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum CoordinateType {
  @JsonValue('LAT_LNG')
  latLng('LAT_LNG'),
  @JsonValue('UNKNOWN')
  unknown('UNKNOWN');

  const CoordinateType(this.json);

  final dynamic json;

  dynamic toJson() => json;

  @override
  String toString() => json?.toString() ?? super.toString();
}
