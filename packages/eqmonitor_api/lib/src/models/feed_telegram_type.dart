// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum FeedTelegramType {
  @JsonValue('ONE_HOUR_EARTHQUAKE_COUNT')
  oneHourEarthquakeCount('ONE_HOUR_EARTHQUAKE_COUNT'),
  @JsonValue('ACCUMULATIVE_EARTHQUAKE_COUNT')
  accumulativeEarthquakeCount('ACCUMULATIVE_EARTHQUAKE_COUNT'),
  @JsonValue('EARTHQUAKE_COUNT')
  earthquakeCount('EARTHQUAKE_COUNT');

  const FeedTelegramType(this.json);

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
