// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'eew_hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EewHypocenter _$$_EewHypocenterFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_EewHypocenter',
      json,
      ($checkedConvert) {
        final val = _$_EewHypocenter(
          coordinate: $checkedConvert(
              'coordinate',
              (v) => v == null
                  ? null
                  : LatLng.fromJson(v as Map<String, dynamic>)),
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_EewHypocenterToJson(_$_EewHypocenter instance) =>
    <String, dynamic>{
      'coordinate': instance.coordinate,
      'code': instance.code,
      'name': instance.name,
    };
