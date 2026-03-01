// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum MagnitudeType {
  @JsonValue('NORMAL')
  normal('NORMAL'),
  @JsonValue('UNKNOWN')
  unknown('UNKNOWN'),
  @JsonValue('OVER_M8')
  overM8('OVER_M8');

  const MagnitudeType(this.json);

  final dynamic json;

  dynamic toJson() => json;

  @override
  String toString() => json?.toString() ?? super.toString();
}
