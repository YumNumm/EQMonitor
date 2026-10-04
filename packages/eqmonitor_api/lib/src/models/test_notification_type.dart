// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum TestNotificationType {
  @JsonValue('SILENT')
  silent('SILENT'),
  @JsonValue('NORMAL')
  normal('NORMAL'),
  @JsonValue('CRITICAL')
  critical('CRITICAL'),
  @JsonValue('SHINDO_REPORT')
  shindoReport('SHINDO_REPORT'),
  @JsonValue('SHINDO_REPORT_WITH_HYPOCENTER')
  shindoReportWithHypocenter('SHINDO_REPORT_WITH_HYPOCENTER'),
  @JsonValue('HYPOCENTER_AND_INTENSITY')
  hypocenterAndIntensity('HYPOCENTER_AND_INTENSITY'),
  @JsonValue('LONG_PERIOD_GROUND_MOTION')
  longPeriodGroundMotion('LONG_PERIOD_GROUND_MOTION'),
  @JsonValue('EEW_FORECAST')
  eewForecast('EEW_FORECAST'),
  @JsonValue('EEW_WARNING')
  eewWarning('EEW_WARNING');

  const TestNotificationType(this.json);

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
