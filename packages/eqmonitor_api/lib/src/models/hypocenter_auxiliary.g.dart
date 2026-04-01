// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter_auxiliary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HypocenterAuxiliary _$HypocenterAuxiliaryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_HypocenterAuxiliary', json, ($checkedConvert) {
      final val = _HypocenterAuxiliary(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        direction: $checkedConvert('direction', (v) => v as String),
        distanceKm: $checkedConvert('distance_km', (v) => v as num),
      );
      return val;
    }, fieldKeyMap: const {'distanceKm': 'distance_km'});

Map<String, dynamic> _$HypocenterAuxiliaryToJson(
  _HypocenterAuxiliary instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'direction': instance.direction,
  'distance_km': instance.distanceKm,
};
