import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_overlay_coverage.dart';
import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final versionStamp = createMapOverlayVersionStamp(
    sourceIdentity: createMapSourceIdentity(value: 'event-a'),
    sourceIncarnation: createMapSourceIncarnation(value: 'incarnation-a'),
    dataSequence: 3,
    dataDigest: 'data-a',
    renderGeneration: 5,
    renderDigest: 'render-a',
  );

  test('only the hidden snapshot omits a committed version stamp', () {
    const hidden = EarthquakeOverlayCoverageSnapshot.hidden();
    final loading = EarthquakeOverlayCoverageSnapshot(
      versionStamp: versionStamp,
      coverage: const EarthquakeOverlayCoverage.loading(),
    );

    expect(hidden.versionStamp, isNull);
    expect(hidden.coverage, isA<EarthquakeOverlayHidden>());
    expect(loading.versionStamp, versionStamp);
    expect(loading.coverage, isA<EarthquakeOverlayLoading>());
  });

  test('is hidden when no tiles are requested', () {
    final coverage = EarthquakeOverlayCoverage.fromCounts(
      requestedTileCount: 0,
      readyTileCount: 0,
      missingOrInvalidCodeCount: 0,
    );

    expect(coverage, isA<EarthquakeOverlayHidden>());
  });

  test('is incomplete when one requested tile is missing', () {
    final coverage = EarthquakeOverlayCoverage.fromCounts(
      requestedTileCount: 2,
      readyTileCount: 1,
      missingOrInvalidCodeCount: 0,
    );

    expect(coverage, isA<EarthquakeOverlayIncomplete>());
    expect((coverage as EarthquakeOverlayIncomplete).requestedTileCount, 2);
    expect(coverage.readyTileCount, 1);
    expect(coverage.missingOrInvalidCodeCount, 0);
  });

  test('is incomplete when one code is missing or invalid', () {
    final coverage = EarthquakeOverlayCoverage.fromCounts(
      requestedTileCount: 2,
      readyTileCount: 2,
      missingOrInvalidCodeCount: 1,
    );

    expect(coverage, isA<EarthquakeOverlayIncomplete>());
    expect(
      (coverage as EarthquakeOverlayIncomplete).missingOrInvalidCodeCount,
      1,
    );
  });

  test(
    'is complete only when every requested tile is ready with valid codes',
    () {
      final coverage = EarthquakeOverlayCoverage.fromCounts(
        requestedTileCount: 2,
        readyTileCount: 2,
        missingOrInvalidCodeCount: 0,
      );

      expect(coverage, isA<EarthquakeOverlayComplete>());
      expect((coverage as EarthquakeOverlayComplete).requestedTileCount, 2);
    },
  );
}
