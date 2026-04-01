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
    type: $checkedConvert('type', (v) => $enumDecode(_$Type2EnumMap, v)),
  );
  return val;
});

Map<String, dynamic> _$TestNotificationRequestToJson(
  _TestNotificationRequest instance,
) => <String, dynamic>{'type': instance.type};

const _$Type2EnumMap = {
  Type2.silent: 'silent',
  Type2.normal: 'normal',
  Type2.critical: 'critical',
};
