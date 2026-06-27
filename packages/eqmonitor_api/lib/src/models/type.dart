// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// const: "１時間地震回数" | const: "累積地震回数" | const: "地震回数"
@JsonEnum()
enum Type {
  /// Incorrect name has been replaced. Original name: `１時間地震回数`.
  @JsonValue('１時間地震回数')
  undefined0('１時間地震回数'),
  /// Incorrect name has been replaced. Original name: `累積地震回数`.
  @JsonValue('累積地震回数')
  undefined1('累積地震回数'),
  /// Incorrect name has been replaced. Original name: `地震回数`.
  @JsonValue('地震回数')
  undefined2('地震回数');

  const Type(this.json);

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
