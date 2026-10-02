// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 原記録の時刻精度。MINUTEのtimestampは分区間の下端を表し、秒は未観測。精度未指定の場合は不明
@JsonEnum()
enum CatalogTimePrecision {
  @JsonValue('MINUTE')
  minute('MINUTE'),
  @JsonValue('SECOND')
  second('SECOND'),
  @JsonValue('DECISECOND')
  decisecond('DECISECOND');

  const CatalogTimePrecision(this.json);

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
