// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Device _$DeviceFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Device',
  json,
  ($checkedConvert) {
    final val = _Device(
      id: $checkedConvert('id', (v) => v as String),
      type: $checkedConvert('type', (v) => $enumDecode(_$DeviceTypeEnumMap, v)),
      userId: $checkedConvert('user_id', (v) => v as String),
      createdAt: $checkedConvert('created_at', (v) => v as String),
      updatedAt: $checkedConvert('updated_at', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'userId': 'user_id',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$DeviceToJson(_Device instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$DeviceTypeEnumMap[instance.type]!,
  'user_id': instance.userId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

const _$DeviceTypeEnumMap = {
  DeviceType.ios: 'IOS',
  DeviceType.android: 'ANDROID',
};

_DeviceUpsertRequest _$DeviceUpsertRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_DeviceUpsertRequest', json, ($checkedConvert) {
      final val = _DeviceUpsertRequest(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$DeviceTypeEnumMap, v),
        ),
        userId: $checkedConvert('user_id', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'userId': 'user_id'});

Map<String, dynamic> _$DeviceUpsertRequestToJson(
  _DeviceUpsertRequest instance,
) => <String, dynamic>{
  'type': _$DeviceTypeEnumMap[instance.type]!,
  'user_id': instance.userId,
};

_ApnsToken _$ApnsTokenFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ApnsToken', json, ($checkedConvert) {
      final val = _ApnsToken(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$ApnsTokenTypeEnumMap, v),
        ),
        token: $checkedConvert('token', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ApnsTokenToJson(_ApnsToken instance) =>
    <String, dynamic>{
      'type': _$ApnsTokenTypeEnumMap[instance.type]!,
      'token': instance.token,
    };

const _$ApnsTokenTypeEnumMap = {
  ApnsTokenType.notification: 'NOTIFICATION',
  ApnsTokenType.liveActivityStart: 'LIVE_ACTIVITY_START',
};

_ApnsTokenRequest _$ApnsTokenRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ApnsTokenRequest', json, ($checkedConvert) {
      final val = _ApnsTokenRequest(
        token: $checkedConvert('token', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ApnsTokenRequestToJson(_ApnsTokenRequest instance) =>
    <String, dynamic>{'token': instance.token};

_FcmToken _$FcmTokenFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_FcmToken',
  json,
  ($checkedConvert) {
    final val = _FcmToken(token: $checkedConvert('token', (v) => v as String));
    return val;
  },
);

Map<String, dynamic> _$FcmTokenToJson(_FcmToken instance) => <String, dynamic>{
  'token': instance.token,
};

_FcmTokenRequest _$FcmTokenRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FcmTokenRequest', json, ($checkedConvert) {
      final val = _FcmTokenRequest(
        token: $checkedConvert('token', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$FcmTokenRequestToJson(_FcmTokenRequest instance) =>
    <String, dynamic>{'token': instance.token};

_LiveActivityTokenRequest _$LiveActivityTokenRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_LiveActivityTokenRequest',
  json,
  ($checkedConvert) {
    final val = _LiveActivityTokenRequest(
      token: $checkedConvert('token', (v) => v as String),
      eventId: $checkedConvert('event_id', (v) => v as String),
      startTrigger: $checkedConvert(
        'start_trigger',
        (v) => $enumDecode(_$LiveActivityStartTriggerEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'eventId': 'event_id', 'startTrigger': 'start_trigger'},
);

Map<String, dynamic> _$LiveActivityTokenRequestToJson(
  _LiveActivityTokenRequest instance,
) => <String, dynamic>{
  'token': instance.token,
  'event_id': instance.eventId,
  'start_trigger': _$LiveActivityStartTriggerEnumMap[instance.startTrigger]!,
};

const _$LiveActivityStartTriggerEnumMap = {
  LiveActivityStartTrigger.shakeDetection: 'shake_detection',
  LiveActivityStartTrigger.eew: 'eew',
};

_LiveActivityInfo _$LiveActivityInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_LiveActivityInfo',
      json,
      ($checkedConvert) {
        final val = _LiveActivityInfo(
          liveActivityId: $checkedConvert(
            'live_activity_id',
            (v) => v as String,
          ),
          eventId: $checkedConvert('event_id', (v) => v as String),
          startTrigger: $checkedConvert(
            'start_trigger',
            (v) => $enumDecode(_$LiveActivityStartTriggerEnumMap, v),
          ),
          createdAt: $checkedConvert('created_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'liveActivityId': 'live_activity_id',
        'eventId': 'event_id',
        'startTrigger': 'start_trigger',
        'createdAt': 'created_at',
      },
    );

Map<String, dynamic> _$LiveActivityInfoToJson(
  _LiveActivityInfo instance,
) => <String, dynamic>{
  'live_activity_id': instance.liveActivityId,
  'event_id': instance.eventId,
  'start_trigger': _$LiveActivityStartTriggerEnumMap[instance.startTrigger]!,
  'created_at': instance.createdAt,
};
