// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 震源決定フラグ。K:気象庁震源、S:気象庁参考震源、k:簡易気象庁震源、s:簡易参考震源、A:自動気象庁震源、a:自動参考震源、N:震源固定・震源不定・未計算、U:USGS震源、I:ISC震源、H:震度観測時刻が時間単位までのデータ、D:日単位までのデータ、M:月単位までのデータ
@JsonEnum()
enum CatalogDeterminationFlag {
  @JsonValue('K')
  upperK('K'),
  @JsonValue('S')
  upperS('S'),
  @JsonValue('k')
  lowerK('k'),
  @JsonValue('s')
  lowerS('s'),
  @JsonValue('A')
  upperA('A'),
  @JsonValue('a')
  lowerA('a'),
  @JsonValue('N')
  n('N'),
  @JsonValue('U')
  u('U'),
  @JsonValue('I')
  i('I'),
  @JsonValue('H')
  h('H'),
  @JsonValue('D')
  d('D'),
  @JsonValue('M')
  m('M');

  const CatalogDeterminationFlag(this.json);

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
