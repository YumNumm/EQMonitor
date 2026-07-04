// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 津波規模。年代により定義が異なる。1923〜1988年: 1:検潮器では観測されたが被害なし、T:津波あり。1989年以降（今村・飯田(1958)による波高）: 1:波高50cm以下、2:波高1m前後、3:波高2m前後、4:波高4〜6m程度、5:波高10〜20m程度、6:波高30m以上
@JsonEnum()
enum CatalogTsunamiScale {
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
  @JsonValue('T')
  t('T');

  const CatalogTsunamiScale(this.json);

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
