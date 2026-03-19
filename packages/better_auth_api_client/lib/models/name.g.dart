// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Name _$NameFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Name', json, ($checkedConvert) {
      final val = _Name(
        firstName: $checkedConvert('first_name', (v) => v as String?),
        lastName: $checkedConvert('last_name', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'firstName': 'first_name', 'lastName': 'last_name'});

Map<String, dynamic> _$NameToJson(_Name instance) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
};
