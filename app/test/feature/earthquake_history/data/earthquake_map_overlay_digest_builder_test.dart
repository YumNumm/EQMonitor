import 'dart:ui';
import 'dart:typed_data';

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

  MapSpriteAtlas atlas(String identity) => createMapSpriteAtlas(
    identity: createMapSourceIdentity(value: identity),
    width: 1,
    height: 1,
    rgbaBytes: Uint8List.fromList(const [255, 255, 255, 255]),
    regions: const [],
    limits: const MapSpriteAtlasLimits(
      maxWidth: 1,
      maxHeight: 1,
      maxPixelBytes: 4,
      maxRegions: 1,
    ),
  );

  MapPointSpriteFeature sprite({
    double sizeAtZoom3 = 0.15,
    double fadeOpacity = 0.6,
  }) => createMapPointSpriteFeature(
    id: 'hypocenter:A',
    longitude: 140,
    latitude: 36,
    spriteRegionId: 'normal-hypocenter',
    sizeScale: createMapZoomLinearRange(
      startZoom: 3,
      startValue: sizeAtZoom3,
      endZoom: 20,
      endValue: 0.4,
    ),
    opacity: createMapZoomStep(
      thresholdZoom: 8,
      belowValue: 1,
      atOrAboveValue: fadeOpacity,
    ),
    priority: 0,
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
      spriteAtlas: atlas('atlas-a'),
      sprites: [sprite()],
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
      spriteAtlas: atlas('atlas-a'),
      sprites: [sprite()],
    );

    expect(blue, isNot(red));
    expect(dataDigest(), data);
  });

  test('atlas identityとsprite policy変更はdata digestを維持しrender digestを変える', () {
    final data = dataDigest();

    String render({
      String atlasIdentity = 'atlas-a',
      double sizeAtZoom3 = 0.15,
      double fadeOpacity = 0.6,
    }) => builder.buildRenderDigest(
      dataSequence: 0,
      dataDigest: data,
      regionToCityZoom: 6,
      stationMinZoom: 6,
      regionStyles: const [],
      cityStyles: const [],
      stations: const [],
      spriteAtlas: atlas(atlasIdentity),
      sprites: [
        sprite(
          sizeAtZoom3: sizeAtZoom3,
          fadeOpacity: fadeOpacity,
        ),
      ],
    );

    final baseline = render();

    expect(render(atlasIdentity: 'atlas-b'), isNot(baseline));
    expect(render(sizeAtZoom3: 0.2), isNot(baseline));
    expect(render(fadeOpacity: 0.5), isNot(baseline));
    expect(dataDigest(), data);
  });
}
