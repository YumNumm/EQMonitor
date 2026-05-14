// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 発生時刻の精度
@JsonEnum()
enum OriginTimePrecision {
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

  const OriginTimePrecision(this.json);

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError('Cannot convert enum value with null JSON representation to String. '
          'This usually happens for \$unknown or @JsonValue(null) entries.');
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
