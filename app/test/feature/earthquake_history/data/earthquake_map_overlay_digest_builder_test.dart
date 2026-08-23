import 'dart:ui';

import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_map_overlay_digest_builder.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const builder = EarthquakeMapOverlayDigestBuilder();
  const regionA = (stableId: 'R-A', intensityOrder: 4);
  const regionB = (stableId: 'R-B', intensityOrder: 3);
  const cityA = (stableId: 'C-A', intensityOrder: 3);
  const stationA = (
    stableId: 'S-A',
    longitude: 139.75,
    latitude: 35.25,
    intensityOrder: 4,
    isMaximum: true,
  );

  String dataDigest({
    List<({String stableId, int intensityOrder})> regions = const [
      regionA,
    ],
    List<({String stableId, int intensityOrder})> cities = const [cityA],
    List<
      ({
        String stableId,
        double longitude,
        double latitude,
        int intensityOrder,
        bool isMaximum,
      })
    >
    stations = const [
      stationA,
    ],
  }) => builder.buildDataDigest(
    regions: regions,
    cities: cities,
    stations: stations,
    hypocenterState: .latLng,
    hypocenterLongitude: 140,
    hypocenterLatitude: 36,
  );

  test('canonical UTF-8 records produce the known SHA-256 digest', () {
    expect(
      dataDigest(),
      '231122c122f035a97707f693a880a148b57ffc8e03e246606cacb2475716e546',
    );
  });

  test('region city and station input order does not affect data digest', () {
    final forward = dataDigest(
      regions: const [regionA, regionB],
      cities: const [cityA, (stableId: 'C-B', intensityOrder: 2)],
      stations: const [
        stationA,
        (
          stableId: 'S-B',
          longitude: 141,
          latitude: 37,
          intensityOrder: 2,
          isMaximum: false,
        ),
      ],
    );
    final reversed = dataDigest(
      regions: const [regionB, regionA],
      cities: const [(stableId: 'C-B', intensityOrder: 2), cityA],
      stations: const [
        (
          stableId: 'S-B',
          longitude: 141,
          latitude: 37,
          intensityOrder: 2,
          isMaximum: false,
        ),
        stationA,
      ],
    );

    expect(reversed, forward);
    expect(
      dataDigest(regions: const [(stableId: 'R-A', intensityOrder: 5)]),
      isNot(forward),
    );
  });

  test('theme-only color change affects render digest but not data digest', () {
    final data = dataDigest();
    final red = builder.buildRenderDigest(
      dataSequence: 0,
      dataDigest: data,
      regionToCityZoom: 6,
      stationMinZoom: 6,
      regionStyles: const [
        EarthquakeAreaStyle(
          code: 'R-A',
          color: Color(0xFFFF0000),
          opacity: 0.6,
        ),
      ],
      cityStyles: const [],
      stations: const [],
    );
    final blue = builder.buildRenderDigest(
      dataSequence: 0,
      dataDigest: data,
      regionToCityZoom: 6,
      stationMinZoom: 6,
      regionStyles: const [
        EarthquakeAreaStyle(
          code: 'R-A',
          color: Color(0xFF0000FF),
          opacity: 0.6,
        ),
      ],
      cityStyles: const [],
      stations: const [],
    );

    expect(blue, isNot(red));
    expect(dataDigest(), data);
  });
}
