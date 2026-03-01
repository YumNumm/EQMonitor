// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum RegionSettingPatchRequestMinJmaIntensity {
  @JsonValue(0)
  value0(0),
  @JsonValue(1)
  value1(1),
  @JsonValue(2)
  value2(2),
  @JsonValue(3)
  value3(3),
  @JsonValue(4)
  value4(4),

  /// Incorrect name has been replaced. Original name: `!5-`.
  @JsonValue('!5-')
  undefined0('!5-'),
  @JsonValue('5-')
  value5('5-'),
  @JsonValue('5+')
  value5('5+'),
  @JsonValue('6-')
  value6('6-'),
  @JsonValue('6+')
  value6('6+'),
  @JsonValue(7)
  value7(7);

  const RegionSettingPatchRequestMinJmaIntensity(this.json);

  final dynamic json;

  dynamic toJson() => json;

  @override
  String toString() => json?.toString() ?? super.toString();
}
