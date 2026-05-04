// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'target_union.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TargetUnionVariant1 _$TargetUnionVariant1FromJson(Map<String, dynamic> json) =>
    $checkedCreate('TargetUnionVariant1', json, ($checkedConvert) {
      final val = TargetUnionVariant1(
        type: $checkedConvert('type', (v) => v),
        deviceId: $checkedConvert('deviceId', (v) => v as String),
        $type: $checkedConvert('runtimeType', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$TargetUnionVariant1ToJson(
  TargetUnionVariant1 instance,
) => <String, dynamic>{
  'type': instance.type,
  'deviceId': instance.deviceId,
  'runtimeType': instance.$type,
};

TargetUnionVariant2 _$TargetUnionVariant2FromJson(Map<String, dynamic> json) =>
    $checkedCreate('TargetUnionVariant2', json, ($checkedConvert) {
      final val = TargetUnionVariant2(
        type: $checkedConvert('type', (v) => v),
        token: $checkedConvert('token', (v) => v as String),
        environment: $checkedConvert(
          'environment',
          (v) => $enumDecode(_$EnvironmentEnumMap, v),
        ),
        $type: $checkedConvert('runtimeType', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$TargetUnionVariant2ToJson(
  TargetUnionVariant2 instance,
) => <String, dynamic>{
  'type': instance.type,
  'token': instance.token,
  'environment': instance.environment,
  'runtimeType': instance.$type,
};

const _$EnvironmentEnumMap = {
  Environment.development: 'development',
  Environment.production: 'production',
};
