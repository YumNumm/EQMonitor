// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 震度
@JsonEnum()
enum JmaIntensity {
  @JsonValue('0')
  value0('0'),
  @JsonValue('1')
  value1('1'),
  @JsonValue('2')
  value2('2'),
  @JsonValue('3')
  value3('3'),
  @JsonValue('4')
  value4('4'),
  @JsonValue('!5-')
  value5unknown('!5-'),
  @JsonValue('5-')
  value5minus('5-'),
  @JsonValue('5+')
  value5plus('5+'),
  @JsonValue('6-')
  value6minus('6-'),
  @JsonValue('6+')
  value6plus('6+'),
  @JsonValue('7')
  value7('7');

  const JmaIntensity(this.json);

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
