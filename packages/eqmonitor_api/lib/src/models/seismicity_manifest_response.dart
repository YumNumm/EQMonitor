// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'seismicity_manifest_layer.dart';

part 'seismicity_manifest_response.freezed.dart';
part 'seismicity_manifest_response.g.dart';

@Freezed()
abstract class SeismicityManifestResponse with _$SeismicityManifestResponse {
  const factory SeismicityManifestResponse({
    required List<SeismicityManifestLayer> layers,
  }) = _SeismicityManifestResponse;
  
  factory SeismicityManifestResponse.fromJson(Map<String, Object?> json) => _$SeismicityManifestResponseFromJson(json);
}
