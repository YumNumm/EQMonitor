// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionResponse _$SessionResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_SessionResponse',
      json,
      ($checkedConvert) {
        final val = _SessionResponse(
          id: $checkedConvert('id', (v) => v as String),
          token: $checkedConvert('token', (v) => v as String),
          expiresAt: $checkedConvert('expires_at', (v) => v as String),
          createdAt: $checkedConvert('created_at', (v) => v as String),
          updatedAt: $checkedConvert('updated_at', (v) => v as String),
          ipAddress: $checkedConvert('ip_address', (v) => v as String?),
          userAgent: $checkedConvert('user_agent', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'expiresAt': 'expires_at',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at',
        'ipAddress': 'ip_address',
        'userAgent': 'user_agent',
      },
    );

Map<String, dynamic> _$SessionResponseToJson(_SessionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'expires_at': instance.expiresAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'ip_address': instance.ipAddress,
      'user_agent': instance.userAgent,
    };
