// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_state_hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiStateHypocenter _$TsunamiStateHypocenterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiStateHypocenter', json, ($checkedConvert) {
  final val = _TsunamiStateHypocenter(
    value: $checkedConvert(
      'value',
      (v) => CodeName.fromJson(v as Map<String, dynamic>),
    ),
    depth: $checkedConvert(
      'depth',
      (v) => Depth.fromJson(v as Map<String, dynamic>),
    ),
    magnitude: $checkedConvert(
      'magnitude',
      (v) => Magnitude.fromJson(v as Map<String, dynamic>),
    ),
    coordinates: $checkedConvert(
      'coordinates',
      (v) => v == null ? null : Coordinate.fromJson(v as Map<String, dynamic>),
    ),
    auxiliary: $checkedConvert(
      'auxiliary',
      (v) => v == null
          ? null
          : HypocenterAuxiliary.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiStateHypocenterToJson(
  _TsunamiStateHypocenter instance,
) => <String, dynamic>{
  'value': instance.value,
  'depth': instance.depth,
  'magnitude': instance.magnitude,
  'coordinates': ?instance.coordinates,
  'auxiliary': ?instance.auxiliary,
};
