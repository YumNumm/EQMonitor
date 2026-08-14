// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'data2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Data2 _$Data2FromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Data2',
  json,
  ($checkedConvert) {
    final val = _Data2(
      schemaVersion: $checkedConvert(
        'schema_version',
        (v) => $enumDecode(_$SchemaVersionEnumMap, v),
      ),
      generatedAt: $checkedConvert(
        'generated_at',
        (v) => DateTime.parse(v as String),
      ),
      archives: $checkedConvert(
        'archives',
        (v) => (v as List<dynamic>)
            .map((e) => Archives.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'schemaVersion': 'schema_version',
    'generatedAt': 'generated_at',
  },
);

Map<String, dynamic> _$Data2ToJson(_Data2 instance) => <String, dynamic>{
  'schema_version': instance.schemaVersion,
  'generated_at': instance.generatedAt.toIso8601String(),
  'archives': instance.archives,
};

const _$SchemaVersionEnumMap = {
  SchemaVersion.value1: 1,
  SchemaVersion.value2: 2,
};
