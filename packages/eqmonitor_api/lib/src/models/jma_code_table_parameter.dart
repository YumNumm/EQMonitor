// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_code_table_parameter_code_tables.dart';
import 'jma_code_table_parameter_metadata.dart';

part 'jma_code_table_parameter.freezed.dart';
part 'jma_code_table_parameter.g.dart';

@Freezed()
abstract class JmaCodeTableParameter with _$JmaCodeTableParameter {
  const factory JmaCodeTableParameter({
    required JmaCodeTableParameterMetadata metadata,
    @JsonKey(name: 'code_tables')
    required JmaCodeTableParameterCodeTables codeTables,
  }) = _JmaCodeTableParameter;

  factory JmaCodeTableParameter.fromJson(Map<String, Object?> json) => _$JmaCodeTableParameterFromJson(json);
}
