// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'app_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppInformation _$AppInformationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AppInformation', json, ($checkedConvert) {
      final val = _AppInformation(
        version: $checkedConvert('version', (v) => v as String),
        buildNumber: $checkedConvert('build_number', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'buildNumber': 'build_number'});

Map<String, dynamic> _$AppInformationToJson(_AppInformation instance) =>
    <String, dynamic>{
      'version': instance.version,
      'build_number': instance.buildNumber,
      'message': instance.message,
    };
