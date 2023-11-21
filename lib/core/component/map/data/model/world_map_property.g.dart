// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'world_map_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorldMapPropertyImpl _$$WorldMapPropertyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$WorldMapPropertyImpl',
      json,
      ($checkedConvert) {
        final val = _$WorldMapPropertyImpl(
          name: $checkedConvert('NAME', (v) => v as String),
          nameJa: $checkedConvert('NAME_JA', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'name': 'NAME', 'nameJa': 'NAME_JA'},
    );

Map<String, dynamic> _$$WorldMapPropertyImplToJson(
        _$WorldMapPropertyImpl instance) =>
    <String, dynamic>{
      'NAME': instance.name,
      'NAME_JA': instance.nameJa,
    };
