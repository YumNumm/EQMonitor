import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

const supportedSchemaVersion = 1;
const schemaV1Properties = <String>{
  'hypocenter_id',
  'origin_time_unix_ms',
  'magnitude',
  'depth_km',
  'max_intensity',
  'determination_flag',
  'earthquake_event_id',
  'geometry_clamped',
};

final class SeismicitySchemaV1Validator {
  const SeismicitySchemaV1Validator();

  void validateDescriptor({
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) {
    if (descriptor.schemaVersion != supportedSchemaVersion) {
      throw SeismicityPmTilesException.unsupportedSchema(
        expected: supportedSchemaVersion,
        actual: descriptor.schemaVersion,
      );
    }
    if (descriptor.expectedFeatureCount < 0 ||
        descriptor.expectedFeatureCount > 0x3fffffff ||
        descriptor.archiveRevision.isEmpty ||
        descriptor.periodFrom.isAfter(descriptor.periodTo) ||
        descriptor.dataZoom < 0 ||
        descriptor.dataZoom > PmTilesV3TileId.maxZoom) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Invalid schema 1 archive descriptor.',
      );
    }
  }

  void validatePropertyName({
    required String name,
    required int tileId,
    required int featureIndex,
  }) {
    if (!schemaV1Properties.contains(name)) {
      throw SeismicityPmTilesException.invalidHypocenterFeature(
        tileId: tileId,
        featureIndex: featureIndex,
        field: name,
        reason: 'unknown_property',
      );
    }
  }
}
