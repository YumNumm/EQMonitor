// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'jma_map_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JmaMapPropertyImpl _$$JmaMapPropertyImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$JmaMapPropertyImpl',
      json,
      ($checkedConvert) {
        final val = _$JmaMapPropertyImpl(
          code: $checkedConvert('code', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          nameKana: $checkedConvert('namekana', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'nameKana': 'namekana'},
    );

Map<String, dynamic> _$$JmaMapPropertyImplToJson(
        _$JmaMapPropertyImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'namekana': instance.nameKana,
    };
