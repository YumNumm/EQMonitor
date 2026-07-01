// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'required_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequiredVersion _$RequiredVersionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_RequiredVersion', json, ($checkedConvert) {
      final val = _RequiredVersion(
        version: $checkedConvert('version', (v) => v as String?),
        buildNumber: $checkedConvert(
          'build_number',
          (v) => (v as num?)?.toInt(),
        ),
        message: $checkedConvert('message', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'buildNumber': 'build_number'});

Map<String, dynamic> _$RequiredVersionToJson(_RequiredVersion instance) =>
    <String, dynamic>{
      'version': ?instance.version,
      'build_number': ?instance.buildNumber,
      'message': ?instance.message,
    };
