// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'depth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepthShallow _$DepthShallowFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DepthShallow', json, ($checkedConvert) {
      final val = DepthShallow(
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$DepthShallowToJson(DepthShallow instance) =>
    <String, dynamic>{'type': instance.$type};

DepthNormal _$DepthNormalFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DepthNormal', json, ($checkedConvert) {
      final val = DepthNormal(
        value: $checkedConvert('value', (v) => (v as num).toInt()),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$DepthNormalToJson(DepthNormal instance) =>
    <String, dynamic>{'value': instance.value, 'type': instance.$type};

DepthOver700 _$DepthOver700FromJson(Map<String, dynamic> json) =>
    $checkedCreate('DepthOver700', json, ($checkedConvert) {
      final val = DepthOver700(
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$DepthOver700ToJson(DepthOver700 instance) =>
    <String, dynamic>{'type': instance.$type};

DepthUnknown _$DepthUnknownFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DepthUnknown', json, ($checkedConvert) {
      final val = DepthUnknown(
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$DepthUnknownToJson(DepthUnknown instance) =>
    <String, dynamic>{'type': instance.$type};
