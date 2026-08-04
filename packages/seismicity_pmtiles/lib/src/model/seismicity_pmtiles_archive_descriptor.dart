import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';

part 'seismicity_pmtiles_archive_descriptor.freezed.dart';
part 'seismicity_pmtiles_archive_descriptor.g.dart';

@freezed
abstract class SeismicityPmTilesArchiveDescriptor
    with _$SeismicityPmTilesArchiveDescriptor {
  // Freezed applies this constructor annotation to the generated class.
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SeismicityPmTilesArchiveDescriptor({
    required SeismicityPmTilesSource source,
    required int schemaVersion,
    required int dataZoom,
    required int expectedSizeBytes,
    required int expectedFeatureCount,
    required String archiveRevision,
    required DateTime periodFrom,
    required DateTime periodTo,
  }) = _SeismicityPmTilesArchiveDescriptor;

  factory SeismicityPmTilesArchiveDescriptor.fromJson(
    Map<String, dynamic> json,
  ) => _$SeismicityPmTilesArchiveDescriptorFromJson(json);
}
