// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'parameter_type.dart';

part 'parameter_manifest_item.freezed.dart';
part 'parameter_manifest_item.g.dart';

@Freezed()
abstract class ParameterManifestItem with _$ParameterManifestItem {
  const factory ParameterManifestItem({
    required ParameterType type,
    @JsonKey(name: 'schema_version')
    required dynamic schemaVersion,
    @JsonKey(name: 'source_version')
    required String sourceVersion,
    @JsonKey(includeIfNull: true,name: 'source_updated_at')
    required String? sourceUpdatedAt,
    @JsonKey(name: 'generated_at')
    required String generatedAt,
    @JsonKey(name: 'source_urls')
    required List<String> sourceUrls,
    required String sha256,
    @JsonKey(name: 'size_bytes')
    required num sizeBytes,
    required String url,
  }) = _ParameterManifestItem;
  
  factory ParameterManifestItem.fromJson(Map<String, Object?> json) => _$ParameterManifestItemFromJson(json);
}
