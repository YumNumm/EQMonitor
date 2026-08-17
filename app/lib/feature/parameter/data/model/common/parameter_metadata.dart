import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter_metadata.freezed.dart';
part 'parameter_metadata.g.dart';

@freezed
abstract class ParameterMetadata with _$ParameterMetadata {
  const factory({
    required ParameterType type,
    required int schemaVersion,
    required String sourceVersion,
    required String? sourceUpdatedAt,
    required List<String> sourceUrls,
    required String sha256,
  }) = _ParameterMetadata;

  factory fromJson(Map<String, dynamic> json) =>
      _$ParameterMetadataFromJson(json);
}
