// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Test3 _$Test3FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Test3', json, ($checkedConvert) {
      final val = _Test3(
        targetDeviceId: $checkedConvert('targetDeviceId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$Test3ToJson(_Test3 instance) => <String, dynamic>{
  'targetDeviceId': instance.targetDeviceId,
};
