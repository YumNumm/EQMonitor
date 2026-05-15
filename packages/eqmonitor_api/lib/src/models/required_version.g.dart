// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'required_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequiredVersion _$RequiredVersionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_RequiredVersion', json, ($checkedConvert) {
      final val = _RequiredVersion(
        version: $checkedConvert('version', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$RequiredVersionToJson(_RequiredVersion instance) =>
    <String, dynamic>{
      'version': instance.version,
      'message': ?instance.message,
    };
