// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'jma_code_table_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JmaCodeTableParameter _$JmaCodeTableParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_JmaCodeTableParameter', json, ($checkedConvert) {
  final val = _JmaCodeTableParameter(
    metadata: $checkedConvert(
      'metadata',
      (v) => JmaCodeTableParameterMetadata.fromJson(v as Map<String, dynamic>),
    ),
    codeTables: $checkedConvert(
      'code_tables',
      (v) =>
          JmaCodeTableParameterCodeTables.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'codeTables': 'code_tables'});

Map<String, dynamic> _$JmaCodeTableParameterToJson(
  _JmaCodeTableParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'code_tables': instance.codeTables,
};
