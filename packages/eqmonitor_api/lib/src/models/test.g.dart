// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Test _$TestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Test', json, ($checkedConvert) {
      final val = _Test(
        targetDeviceId: $checkedConvert('targetDeviceId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$TestToJson(_Test instance) => <String, dynamic>{
  'targetDeviceId': instance.targetDeviceId,
};
