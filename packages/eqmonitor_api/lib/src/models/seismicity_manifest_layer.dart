// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'seismicity_layer_span.dart';

part 'seismicity_manifest_layer.freezed.dart';
part 'seismicity_manifest_layer.g.dart';

@Freezed()
abstract class SeismicityManifestLayer with _$SeismicityManifestLayer {
  const factory SeismicityManifestLayer({
    /// const: "geojson"
    required String type,
    required SeismicityLayerSpan span,
    required String url,
    @JsonKey(name: 'generated_at')
    required String generatedAt,
    required int count,
  }) = _SeismicityManifestLayer;
  
  factory SeismicityManifestLayer.fromJson(Map<String, Object?> json) => _$SeismicityManifestLayerFromJson(json);
}
