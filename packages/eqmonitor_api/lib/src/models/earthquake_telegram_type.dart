// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 地震イベントに紐づく電文タイプ
@JsonEnum()
enum EarthquakeTelegramType {
  @JsonValue('VXSE51')
  vxse51('VXSE51'),
  @JsonValue('VXSE52')
  vxse52('VXSE52'),
  @JsonValue('VXSE53')
  vxse53('VXSE53'),
  @JsonValue('VXSE61')
  vxse61('VXSE61'),
  @JsonValue('VXSE62')
  vxse62('VXSE62'),
  @JsonValue('VXSE45_FORECAST')
  vxse45Forecast('VXSE45_FORECAST'),
  @JsonValue('VXSE45_WARNING')
  vxse45Warning('VXSE45_WARNING');

  const EarthquakeTelegramType(this.json);

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
