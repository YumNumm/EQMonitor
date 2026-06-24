// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum ObservationMaxHeightCondition {
  /// 微弱
  @JsonValue('MINOR')
  minor('MINOR'),
  /// 観測中
  @JsonValue('OBSERVING')
  observing('OBSERVING'),
  /// 重要
  @JsonValue('IMPORTANT')
  important('IMPORTANT');

  const ObservationMaxHeightCondition(this.json);

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
