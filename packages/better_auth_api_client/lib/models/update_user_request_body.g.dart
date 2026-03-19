// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'update_user_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateUserRequestBody _$UpdateUserRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_UpdateUserRequestBody', json, ($checkedConvert) {
  final val = _UpdateUserRequestBody(
    name: $checkedConvert('name', (v) => v as String),
    image: $checkedConvert('image', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$UpdateUserRequestBodyToJson(
  _UpdateUserRequestBody instance,
) => <String, dynamic>{'name': instance.name, 'image': ?instance.image};
