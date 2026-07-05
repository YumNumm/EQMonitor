// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 震度階級コード。1〜7:震度1〜7、9:有感であるが震度不明、A:震度5弱、B:震度5強、C:震度6弱、D:震度6強（1996年10月以降の細分化震度）。歴史的階級（それ以前の期間のみ出現）— L:局発地震(最大有感距離100km未満)、S:小局発地震(100km以上200km未満)、M:やや顕著地震(200km以上300km未満)、R:顕著地震(300km以上)、F:有感地震(1984年まで)、X:付近有感(1996年9月まで)
@JsonEnum()
enum CatalogIntensityClass {
  @JsonValue('1')
  value1('1'),
  @JsonValue('2')
  value2('2'),
  @JsonValue('3')
  value3('3'),
  @JsonValue('4')
  value4('4'),
  @JsonValue('5')
  value5('5'),
  @JsonValue('6')
  value6('6'),
  @JsonValue('7')
  value7('7'),
  @JsonValue('9')
  value9('9'),
  @JsonValue('A')
  a('A'),
  @JsonValue('B')
  b('B'),
  @JsonValue('C')
  c('C'),
  @JsonValue('D')
  d('D'),
  @JsonValue('L')
  l('L'),
  @JsonValue('S')
  s('S'),
  @JsonValue('M')
  m('M'),
  @JsonValue('R')
  r('R'),
  @JsonValue('F')
  f('F'),
  @JsonValue('X')
  x('X');

  const CatalogIntensityClass(this.json);

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
