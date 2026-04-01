// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestNotificationResponse _$TestNotificationResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TestNotificationResponse', json, ($checkedConvert) {
  final val = _TestNotificationResponse(
    message: $checkedConvert('message', (v) => v as String),
    framework: $checkedConvert(
      'framework',
      (v) => $enumDecode(_$FrameworkEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$TestNotificationResponseToJson(
  _TestNotificationResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'framework': instance.framework,
};

const _$FrameworkEnumMap = {Framework.fcm: 'FCM', Framework.apns: 'APNS'};
