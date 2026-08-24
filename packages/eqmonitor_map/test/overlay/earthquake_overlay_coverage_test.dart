import 'package:eqmonitor_map/src/overlay/earthquake_overlay_coverage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
