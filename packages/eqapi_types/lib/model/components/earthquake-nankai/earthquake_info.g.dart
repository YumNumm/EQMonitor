// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'earthquake_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarthquakeNankaiInfoImpl _$$EarthquakeNankaiInfoImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeNankaiInfoImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeNankaiInfoImpl(
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

Map<String, dynamic> _$$EarthquakeNankaiInfoImplToJson(
        _$EarthquakeNankaiInfoImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'appendix': instance.appendix,
      'kind': instance.kind,
    };

_$EarthquakeNankaiKindImpl _$$EarthquakeNankaiKindImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeNankaiKindImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeNankaiKindImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeNankaiKindImplToJson(
        _$EarthquakeNankaiKindImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
