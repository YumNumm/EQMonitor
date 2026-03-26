// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_User', json, ($checkedConvert) {
      final val = _User(
        name: $checkedConvert(
          'name',
          (v) => v == null ? null : Name.fromJson(v as Map<String, dynamic>),
        ),
        email: $checkedConvert('email', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
};
