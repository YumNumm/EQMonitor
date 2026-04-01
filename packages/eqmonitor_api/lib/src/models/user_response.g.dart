// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserResponse _$UserResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_UserResponse',
      json,
      ($checkedConvert) {
        final val = _UserResponse(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String?),
          role: $checkedConvert('role', (v) => v as String?),
          isAnonymous: $checkedConvert('is_anonymous', (v) => v as bool?),
          banned: $checkedConvert('banned', (v) => v as bool?),
          createdAt: $checkedConvert('created_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'isAnonymous': 'is_anonymous',
        'createdAt': 'created_at',
      },
    );

Map<String, dynamic> _$UserResponseToJson(_UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'image': instance.image,
      'role': instance.role,
      'is_anonymous': instance.isAnonymous,
      'banned': instance.banned,
      'created_at': instance.createdAt,
    };
