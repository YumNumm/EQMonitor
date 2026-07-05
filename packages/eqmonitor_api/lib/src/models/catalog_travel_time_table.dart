// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 震源決定に使用した走時表。1:市川・望月(1971)または浜田(1984)など、2:市川(1978)（三陸沖等）、3:複合走時表（北海道東方沖等）、4:複合走時表（千島列島付近等）、5:上野・他(2002)（JMA2001）、6:JMA2001とLL複合（千島列島付近等）、7:JMA2001A/2020A/2020B/2020Cいずれか
@JsonEnum()
enum CatalogTravelTimeTable {
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
  value7('7');

  const CatalogTravelTimeTable(this.json);

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
