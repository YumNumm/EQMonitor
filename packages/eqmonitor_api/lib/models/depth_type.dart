// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum DepthType {
  @JsonValue('SHALLOW')
  shallow('SHALLOW'),
  @JsonValue('NORMAL')
  normal('NORMAL'),
  @JsonValue('OVER_700')
  over700('OVER_700'),
  @JsonValue('UNKNOWN')
  unknown('UNKNOWN');

  const DepthType(this.json);

  final dynamic json;

  dynamic toJson() => json;

  @override
  String toString() => json?.toString() ?? super.toString();
}
