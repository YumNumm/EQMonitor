// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'earthquake_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EarthquakeNankaiInfo _$$_EarthquakeNankaiInfoFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_EarthquakeNankaiInfo',
      json,
      ($checkedConvert) {
        final val = _$_EarthquakeNankaiInfo(
          text: $checkedConvert('text', (v) => v as String),
          appendix: $checkedConvert('appendix', (v) => v as String?),
          kind: $checkedConvert(
              'kind',
              (v) => v == null
                  ? null
                  : EarthquakeNankaiKind.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_EarthquakeNankaiInfoToJson(
        _$_EarthquakeNankaiInfo instance) =>
    <String, dynamic>{
      'text': instance.text,
      'appendix': instance.appendix,
      'kind': instance.kind,
    };

_$_EarthquakeNankaiKind _$$_EarthquakeNankaiKindFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_EarthquakeNankaiKind',
      json,
      ($checkedConvert) {
        final val = _$_EarthquakeNankaiKind(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_EarthquakeNankaiKindToJson(
        _$_EarthquakeNankaiKind instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
