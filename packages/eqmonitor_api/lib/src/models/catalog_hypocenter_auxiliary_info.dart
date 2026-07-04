// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 震源補助情報（気象庁決定震源の情報）。1:通常地震、2:他機関依存、3:人工地震、4:噴火に伴う地震動等、5:低周波イベント
@JsonEnum()
enum CatalogHypocenterAuxiliaryInfo {
  @JsonValue('1')
  value1('1'),
  @JsonValue('2')
  value2('2'),
  @JsonValue('3')
  value3('3'),
  @JsonValue('4')
  value4('4'),
  @JsonValue('5')
  value5('5');

  const CatalogHypocenterAuxiliaryInfo(this.json);

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
