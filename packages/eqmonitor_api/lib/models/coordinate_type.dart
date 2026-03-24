// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 震源座標の種別
@JsonEnum()
enum CoordinateType {
  @JsonValue('LAT_LNG')
  latLng('LAT_LNG'),
  @JsonValue('UNKNOWN')
  unknown('UNKNOWN');

  const CoordinateType(this.json);

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError('Cannot convert enum value with null JSON representation to String. '
          'This usually happens for \$unknown or @JsonValue(null) entries.');
    }
    return value;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
