import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_manifest_layer.freezed.dart';
part 'seismicity_manifest_layer.g.dart';

@freezed
abstract class SeismicityManifestLayer with _$SeismicityManifestLayer {
  const factory({
    required String type,
    required SeismicitySpan span,
    required String url,
    @JsonKey(name: 'generated_at') required DateTime generatedAt,
    required int count,
  }) = _SeismicityManifestLayer;

  factory fromJson(Map<String, dynamic> json) =>
      _$SeismicityManifestLayerFromJson(json);
}
