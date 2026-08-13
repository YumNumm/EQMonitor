import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_schema_v1_validator.dart';
import 'package:test/test.dart';

typedef Descriptor = SeismicityPmTilesArchiveDescriptor;
typedef UnsupportedSchema = SeismicityPmTilesUnsupportedSchemaException;
typedef InvalidDescriptor = SeismicityPmTilesInvalidDescriptorException;
typedef InvalidFeature = SeismicityPmTilesInvalidHypocenterFeatureException;

void main() {
  const validator = SeismicitySchemaV1Validator();
  final accepted = descriptor();
  void check(Descriptor value) =>
      validator.validateDescriptor(descriptor: value);
  void checkName(String name) =>
      validator.validatePropertyName(name: name, tileId: 5, featureIndex: 0);

  test('validates caller-complete schema 1 descriptor', () {
    expect(() => check(accepted), returnsNormally);
    for (final version in [0, 2]) {
      final candidate = accepted.copyWith(schemaVersion: version);
      expect(() => check(candidate), throwsA(isA<UnsupportedSchema>()));
    }
    final invalid = [
      accepted.copyWith(expectedFeatureCount: -1),
      accepted.copyWith(expectedFeatureCount: 0x40000000),
      accepted.copyWith(archiveRevision: ''),
      accepted.copyWith(periodFrom: DateTime.utc(2027)),
      accepted.copyWith(dataZoom: -1),
      accepted.copyWith(dataZoom: 32),
    ];
    for (final value in invalid) {
      expect(() => check(value), throwsA(isA<InvalidDescriptor>()));
    }
  });
  test('accepts only schema 1 producer properties', () {
    final producerProperties =
        'hypocenter_id origin_time_unix_ms magnitude depth_km max_intensity '
                'determination_flag earthquake_event_id geometry_clamped'
            .split(' ');
    for (final name in producerProperties) {
      expect(() => checkName(name), returnsNormally);
    }
    for (final name in ['source_kind', 'unknown']) {
      expect(() => checkName(name), throwsA(invalidProperty(name)));
    }
  });
}

Matcher invalidProperty(String name) => isA<InvalidFeature>()
    .having((exception) => exception.tileId, 'tileId', 5)
    .having((exception) => exception.featureIndex, 'featureIndex', 0)
    .having((exception) => exception.field, 'field', name)
    .having((exception) => exception.reason, 'reason', 'unknown_property');

Descriptor descriptor() => Descriptor(
  source: const SeismicityPmTilesSource.asset(assetKey: 'archive.pmtiles'),
  schemaVersion: 1,
  dataZoom: 12,
  expectedSizeBytes: 1,
  expectedFeatureCount: 0x3fffffff,
  archiveRevision: 'revision-1',
  periodFrom: DateTime.utc(2025),
  periodTo: DateTime.utc(2026),
);
