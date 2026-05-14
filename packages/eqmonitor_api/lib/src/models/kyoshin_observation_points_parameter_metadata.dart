// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_observation_points_parameter_metadata.freezed.dart';
part 'kyoshin_observation_points_parameter_metadata.g.dart';

@Freezed()
abstract class KyoshinObservationPointsParameterMetadata with _$KyoshinObservationPointsParameterMetadata {
  const factory KyoshinObservationPointsParameterMetadata({
    required dynamic type,
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
  }) = _KyoshinObservationPointsParameterMetadata;
  
  factory KyoshinObservationPointsParameterMetadata.fromJson(Map<String, Object?> json) => _$KyoshinObservationPointsParameterMetadataFromJson(json);
}
