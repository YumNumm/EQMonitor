// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// 地域別地震履歴のソートキー。intensity は指定地点、max_intensity は地震全体の最大観測震度
@JsonEnum()
enum IntensitySearchSortBy {
  @JsonValue('event_id')
  eventId('event_id'),
  @JsonValue('magnitude')
  magnitude('magnitude'),
  @JsonValue('max_intensity')
  maxIntensity('max_intensity'),
  @JsonValue('max_lpgm_intensity')
  maxLpgmIntensity('max_lpgm_intensity'),
  @JsonValue('depth')
  depth('depth'),
  @JsonValue('origin_time')
  originTime('origin_time'),
  @JsonValue('intensity')
  intensity('intensity');

  const IntensitySearchSortBy(this.json);

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
