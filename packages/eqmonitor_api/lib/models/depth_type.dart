// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 震源の深さの種別
@JsonEnum()
enum DepthType {
  @JsonValue('SHALLOW')
  shallow('SHALLOW'),
  @JsonValue('NORMAL')
  normal('NORMAL'),
  @JsonValue('OVER_700')
  over700('OVER_700'),
  @JsonValue('UNKNOWN')
  unknown('UNKNOWN');

  const DepthType(this.json);

  final dynamic json;
  dynamic toJson() {
    final value = json;
    if (value == null) {
      throw StateError(
        'Cannot convert enum value with null JSON representation to dynamic. '
        'This usually happens for \$unknown or @JsonValue(null) entries.',
      );
    }
    return value as dynamic;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
