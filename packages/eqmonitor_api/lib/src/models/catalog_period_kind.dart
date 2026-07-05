// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 周期・周波数の記録形式。FREQUENCY:周波数(Hz)で記録、PERIOD:周期(秒)で記録
@JsonEnum()
enum CatalogPeriodKind {
  @JsonValue('FREQUENCY')
  frequency('FREQUENCY'),
  @JsonValue('PERIOD')
  period('PERIOD');

  const CatalogPeriodKind(this.json);

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
