// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 震源評価（震源決定時の初期条件）。1:深さフリー、2:深さ刻み条件で最適解を求めた、3:深さ固定等、人の判断による、4:Depth phaseを用いた、5:S-Pを用いた、7:参考、8:決定不能または不採用
@JsonEnum()
enum CatalogHypocenterEvaluation {
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
  @JsonValue('7')
  value7('7'),
  @JsonValue('8')
  value8('8');

  const CatalogHypocenterEvaluation(this.json);

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
