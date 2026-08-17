// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum SchemaVersion {
  @JsonValue(1)
  value1(1),
  @JsonValue(2)
  value2(2);

  const SchemaVersion(this.json);

  final num? json;
  num toJson() {
    final value = json;
    if (value == null) {
      throw StateError('Cannot convert enum value with null JSON representation to num. '
          'This usually happens for \$unknown or @JsonValue(null) entries.');
    }
    return value as num;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
