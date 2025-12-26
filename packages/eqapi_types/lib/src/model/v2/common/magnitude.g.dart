// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'magnitude.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagnitudeNormal _$MagnitudeNormalFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MagnitudeNormal', json, ($checkedConvert) {
      final val = MagnitudeNormal(
        value: $checkedConvert('value', (v) => (v as num).toDouble()),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$MagnitudeNormalToJson(MagnitudeNormal instance) =>
    <String, dynamic>{'value': instance.value, 'type': instance.$type};

MagnitudeUnknown _$MagnitudeUnknownFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MagnitudeUnknown', json, ($checkedConvert) {
      final val = MagnitudeUnknown(
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$MagnitudeUnknownToJson(MagnitudeUnknown instance) =>
    <String, dynamic>{'type': instance.$type};

MagnitudeOverM8 _$MagnitudeOverM8FromJson(Map<String, dynamic> json) =>
    $checkedCreate('MagnitudeOverM8', json, ($checkedConvert) {
      final val = MagnitudeOverM8(
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$MagnitudeOverM8ToJson(MagnitudeOverM8 instance) =>
    <String, dynamic>{'type': instance.$type};
