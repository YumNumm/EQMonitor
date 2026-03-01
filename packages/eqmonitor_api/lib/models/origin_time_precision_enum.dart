// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 発生時刻の精度
@JsonEnum()
enum OriginTimePrecisionEnum {
  @JsonValue('MILLISECOND')
  millisecond('MILLISECOND'),
  @JsonValue('SECOND')
  second('SECOND'),
  @JsonValue('MINUTE')
  minute('MINUTE'),
  @JsonValue('HOUR')
  hour('HOUR'),
  @JsonValue('DAY')
  day('DAY'),
  @JsonValue('MONTH')
  month('MONTH');

  const OriginTimePrecisionEnum(this.json);

  final dynamic json;

  dynamic toJson() => json;

  @override
  String toString() => json?.toString() ?? super.toString();
}
