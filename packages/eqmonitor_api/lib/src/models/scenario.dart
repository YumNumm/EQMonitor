// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum Scenario {
  @JsonValue('noto_4reports')
  noto4reports('noto_4reports'),
  @JsonValue('one_point_growth')
  onePointGrowth('one_point_growth'),
  @JsonValue('shake_growth')
  shakeGrowth('shake_growth'),
  @JsonValue('shake_warning')
  shakeWarning('shake_warning');

  const Scenario(this.json);

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError(
        'Cannot convert enum value with null JSON representation to String. '
        'This usually happens for \$unknown or @JsonValue(null) entries.',
      );
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
