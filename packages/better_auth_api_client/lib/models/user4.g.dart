// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'user4.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User4 _$User4FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_User4', json, ($checkedConvert) {
      final val = _User4(
        id: $checkedConvert('id', (v) => v as String),
        emailVerified: $checkedConvert('email_verified', (v) => v as bool),
        name: $checkedConvert('name', (v) => v as String?),
        email: $checkedConvert('email', (v) => v as String?),
        image: $checkedConvert('image', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'emailVerified': 'email_verified'});

Map<String, dynamic> _$User4ToJson(_User4 instance) => <String, dynamic>{
  'id': instance.id,
  'email_verified': instance.emailVerified,
  'name': ?instance.name,
  'email': ?instance.email,
  'image': ?instance.image,
};
