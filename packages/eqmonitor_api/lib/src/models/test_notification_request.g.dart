// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestNotificationRequest _$TestNotificationRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TestNotificationRequest', json, ($checkedConvert) {
  final val = _TestNotificationRequest(
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$TestNotificationTypeEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$TestNotificationRequestToJson(
  _TestNotificationRequest instance,
) => <String, dynamic>{'type': instance.type};

const _$TestNotificationTypeEnumMap = {
  TestNotificationType.silent: 'SILENT',
  TestNotificationType.normal: 'NORMAL',
  TestNotificationType.critical: 'CRITICAL',
  TestNotificationType.shindoReport: 'SHINDO_REPORT',
  TestNotificationType.shindoReportWithHypocenter:
      'SHINDO_REPORT_WITH_HYPOCENTER',
  TestNotificationType.hypocenterAndIntensity: 'HYPOCENTER_AND_INTENSITY',
  TestNotificationType.longPeriodGroundMotion: 'LONG_PERIOD_GROUND_MOTION',
  TestNotificationType.eewForecast: 'EEW_FORECAST',
  TestNotificationType.eewWarning: 'EEW_WARNING',
};
