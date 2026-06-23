// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'parameter_type.dart';

part 'parameter_metadata.freezed.dart';
part 'parameter_metadata.g.dart';

@Freezed()
abstract class ParameterMetadata with _$ParameterMetadata {
  const factory ParameterMetadata({
    required ParameterType type,
    @JsonKey(name: 'schema_version') required dynamic schemaVersion,
    @JsonKey(name: 'source_version') required String sourceVersion,
    @JsonKey(includeIfNull: true, name: 'source_updated_at')
    required String? sourceUpdatedAt,
    @JsonKey(name: 'generated_at') required String generatedAt,
    @JsonKey(name: 'source_urls') required List<String> sourceUrls,
    required String sha256,
  }) = _ParameterMetadata;

  factory ParameterMetadata.fromJson(Map<String, Object?> json) =>
      _$ParameterMetadataFromJson(json);
}
