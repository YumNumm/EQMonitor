// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'user3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User3 _$User3FromJson(Map<String, dynamic> json) => $checkedCreate(
  '_User3',
  json,
  ($checkedConvert) {
    final val = _User3(
      id: $checkedConvert('id', (v) => v as String),
      email: $checkedConvert('email', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      emailVerified: $checkedConvert('email_verified', (v) => v as bool),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
      image: $checkedConvert('image', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'emailVerified': 'email_verified',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$User3ToJson(_User3 instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'email_verified': instance.emailVerified,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'image': ?instance.image,
};
