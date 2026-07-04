// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 宇津(1999)の定義による被害規模。1:壁や地面に亀裂が生じる程度の微小被害、2:家屋の破損・道路の破損など小被害、3:複数の死者または複数の全壊家屋、4:死者20人以上または家屋全壊1千戸以上、5:死者200人以上または家屋全壊1万戸以上、6:死者2000人以上または家屋全壊10万戸以上、7:死者2万人以上または家屋全壊100万戸以上、X:被害があったが程度がわからないもの(1988年まで)、Y:直前・直後の地震の被害と一緒になったもの(1988年まで)
@JsonEnum()
enum CatalogDamageScale {
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
  @JsonValue('X')
  x('X'),
  @JsonValue('Y')
  y('Y');

  const CatalogDamageScale(this.json);

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
