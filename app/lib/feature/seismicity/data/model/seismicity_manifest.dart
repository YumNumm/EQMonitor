import 'package:eqmonitor/feature/seismicity/data/model/seismicity_manifest_layer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_manifest.freezed.dart';
part 'seismicity_manifest.g.dart';

@freezed
abstract class SeismicityManifest with _$SeismicityManifest {
  const factory({
    required List<SeismicityManifestLayer> layers,
  }) = _SeismicityManifest;

  factory fromJson(Map<String, dynamic> json) =>
      _$SeismicityManifestFromJson(json);
}
