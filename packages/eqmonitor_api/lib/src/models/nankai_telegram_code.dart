// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// const: "VYSE50" | const: "VYSE51" | const: "VYSE52" | const: "VYSE60"
@JsonEnum()
enum NankaiTelegramCode {
  @JsonValue('VYSE50')
  vyse50('VYSE50'),
  @JsonValue('VYSE51')
  vyse51('VYSE51'),
  @JsonValue('VYSE52')
  vyse52('VYSE52'),
  @JsonValue('VYSE60')
  vyse60('VYSE60');

  const NankaiTelegramCode(this.json);

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
