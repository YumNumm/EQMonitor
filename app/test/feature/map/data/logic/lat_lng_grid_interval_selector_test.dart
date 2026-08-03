import 'package:eqmonitor/feature/map/data/logic/lat_lng_grid_interval_selector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const selector = LatLngGridIntervalSelector();

  test('selects the smallest approved interval above tileSpan / 8', () {
    const expected = {
      0: 45.0,
      1: 30.0,
      2: 15.0,
      3: 10.0,
      4: 5.0,
      5: 2.0,
      6: 1.0,
      7: 0.5,
      8: 0.25,
      9: 0.1,
      10: 0.05,
      11: 0.025,
      12: 0.025,
      13: 0.01,
      30: 0.01,
    };

    for (final entry in expected.entries) {
      expect(selector.select(zoomLevel: entry.key), entry.value);
    }
  });

  test('rejects zoom levels below the supported range', () {
    expect(() => selector.select(zoomLevel: -1), throwsRangeError);
  });

  test('rejects zoom levels above the supported range', () {
    expect(() => selector.select(zoomLevel: 31), throwsRangeError);
  });
}
