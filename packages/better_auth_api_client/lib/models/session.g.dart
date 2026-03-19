// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Session _$SessionFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Session',
  json,
  ($checkedConvert) {
    final val = _Session(
      expiresAt: $checkedConvert(
        'expires_at',
        (v) => DateTime.parse(v as String),
      ),
      token: $checkedConvert('token', (v) => v as String),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
      userId: $checkedConvert('user_id', (v) => v as String),
      createdAt: $checkedConvert(
        'created_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      id: $checkedConvert('id', (v) => v as String?),
      ipAddress: $checkedConvert('ip_address', (v) => v as String?),
      userAgent: $checkedConvert('user_agent', (v) => v as String?),
      impersonatedBy: $checkedConvert('impersonated_by', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'expiresAt': 'expires_at',
    'updatedAt': 'updated_at',
    'userId': 'user_id',
    'createdAt': 'created_at',
    'ipAddress': 'ip_address',
    'userAgent': 'user_agent',
    'impersonatedBy': 'impersonated_by',
  },
);

Map<String, dynamic> _$SessionToJson(_Session instance) => <String, dynamic>{
  'expires_at': instance.expiresAt.toIso8601String(),
  'token': instance.token,
  'updated_at': instance.updatedAt.toIso8601String(),
  'user_id': instance.userId,
  'created_at': instance.createdAt?.toIso8601String(),
  'id': ?instance.id,
  'ip_address': ?instance.ipAddress,
  'user_agent': ?instance.userAgent,
  'impersonated_by': ?instance.impersonatedBy,
};
