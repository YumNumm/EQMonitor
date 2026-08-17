import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hypocenter_manifest.freezed.dart';

@freezed
abstract class HypocenterManifest with _$HypocenterManifest {
  const factory({
    required List<HypocenterArchive> archives,
    required String datasetRevision,
    required DateTime dataUpdatedAt,
  }) = _HypocenterManifest;
}
