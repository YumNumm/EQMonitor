// GENERATED CODE - DO NOT MODIFY BY HAND

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
          latitude: $checkedConvert('latitude', (v) => (v as num?)?.toDouble()),
          longitude:
              $checkedConvert('longitude', (v) => (v as num?)?.toDouble()),
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_EewHypocenterToJson(_$_EewHypocenter instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'code': instance.code,
      'name': instance.name,
    };
