import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter_manifest.freezed.dart';
part 'parameter_manifest.g.dart';

@freezed
abstract class ParameterManifest with _$ParameterManifest {
  const factory ParameterManifest({
    required List<ParameterManifestItem> parameters,
  }) = _ParameterManifest;

  factory ParameterManifest.fromJson(Map<String, dynamic> json) =>
      _$ParameterManifestFromJson(json);
}

@freezed
abstract class ParameterManifestItem with _$ParameterManifestItem {
  const factory ParameterManifestItem({
    required ParameterType type,
    required String schemaVersion,
    required String sourceVersion,
    required String? sourceUpdatedAt,
    required String generatedAt,
    required List<String> sourceUrls,
    required String sha256,
    required int sizeBytes,
    required String url,
  }) = _ParameterManifestItem;

  factory ParameterManifestItem.fromJson(Map<String, dynamic> json) =>
      _$ParameterManifestItemFromJson(json);
}
