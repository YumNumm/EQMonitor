import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter_metadata.freezed.dart';
part 'parameter_metadata.g.dart';

@freezed
abstract class ParameterMetadata with _$ParameterMetadata {
  const factory ParameterMetadata({
    required ParameterType type,
    required String schemaVersion,
    required String sourceVersion,
    required String? sourceUpdatedAt,
    required String generatedAt,
    required List<String> sourceUrls,
    required String sha256,
  }) = _ParameterMetadata;

  factory ParameterMetadata.fromJson(Map<String, dynamic> json) =>
      _$ParameterMetadataFromJson(json);
}
