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
    expect(
      loading.diagnostic,
      const EarthquakeOverlayCoverageDiagnostic.empty(),
    );
  });

  test(
    'derives loading, incomplete, and complete only from explicit evidence',
    () {
      final pending = EarthquakeOverlayCoverageDiagnostic(
        visibleCanonicalTileCount: 2,
        pendingTileCount: 1,
        authoritativeEmptyTileCount: 1,
        sourceLayerAbsentTileCount: 0,
        missingOrInvalidPropertyFeatureCount: 0,
        decodeOrSchemaFailureTileCount: 0,
        requiredCodeUnresolvedCount: 0,
        stationCount: 3,
        spriteCount: 1,
      );
      final invalid = EarthquakeOverlayCoverageDiagnostic(
        visibleCanonicalTileCount: 3,
        pendingTileCount: 0,
        authoritativeEmptyTileCount: 1,
        sourceLayerAbsentTileCount: 1,
        missingOrInvalidPropertyFeatureCount: 2,
        decodeOrSchemaFailureTileCount: 1,
        requiredCodeUnresolvedCount: 1,
        stationCount: 3,
        spriteCount: 1,
      );
      final complete = EarthquakeOverlayCoverageDiagnostic(
        visibleCanonicalTileCount: 2,
        pendingTileCount: 0,
        authoritativeEmptyTileCount: 2,
        sourceLayerAbsentTileCount: 0,
        missingOrInvalidPropertyFeatureCount: 0,
        decodeOrSchemaFailureTileCount: 0,
        requiredCodeUnresolvedCount: 0,
        stationCount: 0,
        spriteCount: 0,
      );

      expect(
        EarthquakeOverlayCoverage.fromDiagnostic(pending),
        isA<EarthquakeOverlayLoading>(),
      );
      expect(
        EarthquakeOverlayCoverage.fromDiagnostic(invalid),
        isA<EarthquakeOverlayIncomplete>(),
      );
      expect(
        EarthquakeOverlayCoverage.fromDiagnostic(complete),
        isA<EarthquakeOverlayComplete>(),
      );
    },
  );

  test('snapshot equality includes the diagnostic in the same stamp', () {
    final diagnostic = EarthquakeOverlayCoverageDiagnostic(
      visibleCanonicalTileCount: 1,
      pendingTileCount: 0,
      authoritativeEmptyTileCount: 1,
      sourceLayerAbsentTileCount: 0,
      missingOrInvalidPropertyFeatureCount: 0,
      decodeOrSchemaFailureTileCount: 0,
      requiredCodeUnresolvedCount: 0,
      stationCount: 2,
      spriteCount: 1,
    );
    final snapshot = EarthquakeOverlayCoverageSnapshot(
      versionStamp: versionStamp,
      coverage: const EarthquakeOverlayCoverage.complete(
        requestedTileCount: 1,
      ),
      diagnostic: diagnostic,
    );

    expect(snapshot.diagnostic, diagnostic);
    expect(
      snapshot,
      isNot(
        EarthquakeOverlayCoverageSnapshot(
          versionStamp: versionStamp,
          coverage: snapshot.coverage,
        ),
      ),
    );
  });

  test(
    'rejects overlapping tile categories before ready count can go negative',
    () {
      expect(
        () => EarthquakeOverlayCoverageDiagnostic(
          visibleCanonicalTileCount: 1,
          pendingTileCount: 0,
          authoritativeEmptyTileCount: 0,
          sourceLayerAbsentTileCount: 1,
          missingOrInvalidPropertyFeatureCount: 0,
          decodeOrSchemaFailureTileCount: 1,
          requiredCodeUnresolvedCount: 0,
          stationCount: 0,
          spriteCount: 0,
        ),
        throwsArgumentError,
      );
    },
  );

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
