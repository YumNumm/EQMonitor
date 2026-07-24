// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Test2 _$Test2FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Test2', json, ($checkedConvert) {
      final val = _Test2(
        targetDeviceId: $checkedConvert('targetDeviceId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$Test2ToJson(_Test2 instance) => <String, dynamic>{
  'targetDeviceId': instance.targetDeviceId,
};
