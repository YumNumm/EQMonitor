// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 震源レコード種別。A:震源レコード、B:群発地震時の震源レコード、D:震源が離れた地震の組の震源レコード
@JsonEnum()
enum CatalogHypocenterRecordType {
  @JsonValue('A')
  a('A'),
  @JsonValue('B')
  b('B'),
  @JsonValue('D')
  d('D');

  const CatalogHypocenterRecordType(this.json);

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
