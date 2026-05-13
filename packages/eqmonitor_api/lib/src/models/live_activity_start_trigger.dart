// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Live Activity開始トリガー
@JsonEnum()
enum LiveActivityStartTrigger {
  @JsonValue('shake_detection')
  shakeDetection('shake_detection'),
  @JsonValue('eew')
  eew('eew');

  const LiveActivityStartTrigger(this.json);

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError('Cannot convert enum value with null JSON representation to String. '
          'This usually happens for \\\$unknown or @JsonValue(null) entries.');
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
