import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const regionStyle = EarthquakeAreaStyle(
    code: '130',
    color: Color(0xfff44336),
    opacity: 0.6,
  );
  const cityStyle = EarthquakeAreaStyle(
    code: '131016',
    color: Color(0xffff9800),
    opacity: 0.7,
  );
  const station = EarthquakeObservationPoint(
    id: 'jma-44132',
    longitude: 139.6917,
    latitude: 35.6895,
    color: Color(0xffffeb3b),
    radiusLogicalPixels: 6.7,
  );

  MapSpriteAtlas spriteAtlas() => createMapSpriteAtlas(
    identity: createMapSourceIdentity(value: 'sha256:sprites'),
    width: 1,
    height: 1,
    rgbaBytes: Uint8List.fromList(const [255, 255, 255, 255]),
    regions: const [
      MapSpriteRegion(
        id: 'normal',
        normalizedUv: Rect.fromLTRB(0.5, 0.5, 0.5, 0.5),
        logicalSize: Size(32, 32),
      ),
    ],
    limits: const MapSpriteAtlasLimits(
      maxWidth: 1,
      maxHeight: 1,
      maxPixelBytes: 4,
      maxRegions: 1,
    ),
  );

  MapPointSpriteFeature sprite({
    String id = 'hypocenter:event-a',
    String spriteRegionId = 'normal',
    double endSize = 0.4,
  }) => createMapPointSpriteFeature(
    id: id,
    longitude: 139.6917,
    latitude: 35.6895,
    spriteRegionId: spriteRegionId,
    sizeScale: createMapZoomLinearRange(
      startZoom: 3,
      startValue: 0.15,
      endZoom: 20,
      endValue: endSize,
    ),
    opacity: createMapZoomStep(
      thresholdZoom: 8,
      belowValue: 1,
      atOrAboveValue: 0.6,
    ),
    priority: 10,
  );

  MapOverlayVersionStamp versionStamp({
    String sourceIdentity = 'earthquake-20260823',
    String sourceIncarnation = '019c8f5e-1f00-7000-8000-000000000001',
    int dataSequence = 42,
    String dataDigest = 'data-sha256',
    int renderGeneration = 7,
    String renderDigest = 'render-sha256',
  }) => createMapOverlayVersionStamp(
    sourceIdentity: createMapSourceIdentity(value: sourceIdentity),
    sourceIncarnation: createMapSourceIncarnation(value: sourceIncarnation),
    dataSequence: dataSequence,
    dataDigest: dataDigest,
    renderGeneration: renderGeneration,
    renderDigest: renderDigest,
  );

  EarthquakeMapOverlaySnapshot snapshot({
    MapOverlayVersionStamp? version,
    double regionToCityZoom = 6,
    double stationMinZoom = 6,
    List<EarthquakeAreaStyle> regionStyles = const [regionStyle],
    List<EarthquakeAreaStyle> cityStyles = const [cityStyle],
    List<EarthquakeObservationPoint> stations = const [station],
    MapSpriteAtlas? atlas,
    List<MapPointSpriteFeature> sprites = const [],
    int maxSpritePolicyBatches = 1,
  }) => createEarthquakeMapOverlaySnapshot(
    versionStamp: version ?? versionStamp(),
    regionToCityZoom: regionToCityZoom,
    stationMinZoom: stationMinZoom,
    regionStyles: regionStyles,
    cityStyles: cityStyles,
    stations: stations,
    spriteAtlas: atlas,
    sprites: sprites,
    maxSpritePolicyBatches: maxSpritePolicyBatches,
  );

  test('version stamp rejects blank typed identities and digests', () {
    expect(() => versionStamp(sourceIdentity: '  '), throwsArgumentError);
    expect(() => versionStamp(sourceIncarnation: '\n'), throwsArgumentError);
    expect(() => versionStamp(dataDigest: '\t'), throwsArgumentError);
    expect(() => versionStamp(renderDigest: ' '), throwsArgumentError);
  });

  test('version stamp rejects negative sequence and generation', () {
    expect(() => versionStamp(dataSequence: -1), throwsArgumentError);
    expect(() => versionStamp(renderGeneration: -1), throwsArgumentError);
  });

  test('version stamp normalizes values and supports value equality', () {
    final first = versionStamp(
      sourceIdentity: ' event-a ',
      sourceIncarnation: ' incarnation-a ',
      dataDigest: ' data-a ',
      renderDigest: ' render-a ',
    );
    final second = versionStamp(
      sourceIdentity: 'event-a',
      sourceIncarnation: 'incarnation-a',
      dataDigest: 'data-a',
      renderDigest: 'render-a',
    );

    expect(first, second);
    expect(first.hashCode, second.hashCode);
    expect(snapshot(version: first).versionStamp, first);
  });

  test('rejects non-finite zoom values', () {
    expect(() => snapshot(regionToCityZoom: double.nan), throwsArgumentError);
    expect(
      () => snapshot(stationMinZoom: double.infinity),
      throwsArgumentError,
    );
  });

  test('rejects blank area codes and opacity outside the unit interval', () {
    expect(
      () => snapshot(
        regionStyles: const [
          EarthquakeAreaStyle(
            code: ' ',
            color: Color(0xfff44336),
            opacity: 0.6,
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => snapshot(
        cityStyles: const [
          EarthquakeAreaStyle(
            code: '131016',
            color: Color(0xffff9800),
            opacity: 1.01,
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => snapshot(
        cityStyles: const [
          EarthquakeAreaStyle(
            code: '131016',
            color: Color(0xffff9800),
            opacity: double.nan,
          ),
        ],
      ),
      throwsArgumentError,
    );
  });

  test('rejects duplicate codes within either area layer', () {
    expect(
      () => snapshot(regionStyles: const [regionStyle, regionStyle]),
      throwsArgumentError,
    );
    expect(
      () => snapshot(cityStyles: const [cityStyle, cityStyle]),
      throwsArgumentError,
    );
  });

  test('allows a region and city to use the same code', () {
    final result = snapshot(
      cityStyles: const [
        EarthquakeAreaStyle(
          code: '130',
          color: Color(0xffff9800),
          opacity: 0.7,
        ),
      ],
    );

    expect(result.regionStyles.single.code, '130');
    expect(result.cityStyles.single.code, '130');
  });

  test('rejects invalid station identity, coordinates, and radius', () {
    expect(
      () => snapshot(
        stations: const [
          EarthquakeObservationPoint(
            id: ' ',
            longitude: 139.6917,
            latitude: 35.6895,
            color: Color(0xffffeb3b),
            radiusLogicalPixels: 6.7,
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => snapshot(
        stations: const [
          EarthquakeObservationPoint(
            id: 'invalid-longitude',
            longitude: 180.1,
            latitude: 35.6895,
            color: Color(0xffffeb3b),
            radiusLogicalPixels: 6.7,
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => snapshot(
        stations: const [
          EarthquakeObservationPoint(
            id: 'invalid-latitude',
            longitude: 139.6917,
            latitude: double.nan,
            color: Color(0xffffeb3b),
            radiusLogicalPixels: 6.7,
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => snapshot(
        stations: const [
          EarthquakeObservationPoint(
            id: 'invalid-radius',
            longitude: 139.6917,
            latitude: 35.6895,
            color: Color(0xffffeb3b),
            radiusLogicalPixels: 0,
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => snapshot(
        stations: const [
          EarthquakeObservationPoint(
            id: 'infinite-radius',
            longitude: 139.6917,
            latitude: 35.6895,
            color: Color(0xffffeb3b),
            radiusLogicalPixels: double.infinity,
          ),
        ],
      ),
      throwsArgumentError,
    );
  });

  test('rejects duplicate station IDs', () {
    expect(
      () => snapshot(stations: const [station, station]),
      throwsArgumentError,
    );
  });

  test('takes unmodifiable copies of every input collection', () {
    final regionStyles = <EarthquakeAreaStyle>[regionStyle];
    final cityStyles = <EarthquakeAreaStyle>[cityStyle];
    final stations = <EarthquakeObservationPoint>[station];
    final result = snapshot(
      regionStyles: regionStyles,
      cityStyles: cityStyles,
      stations: stations,
    );

    regionStyles.clear();
    cityStyles.clear();
    stations.clear();

    expect(result.regionStyles, const [regionStyle]);
    expect(result.cityStyles, const [cityStyle]);
    expect(result.stations, const [station]);
    expect(() => result.regionStyles.add(regionStyle), throwsUnsupportedError);
    expect(() => result.cityStyles.add(cityStyle), throwsUnsupportedError);
    expect(() => result.stations.add(station), throwsUnsupportedError);
  });

  test('allows an explicitly bounded snapshot without sprite input', () {
    final result = snapshot();

    expect(result.spriteAtlas, isNull);
    expect(result.sprites, isEmpty);
    expect(result.maxSpritePolicyBatches, 1);
  });

  test('takes an unmodifiable copy of sprite features', () {
    final sprites = <MapPointSpriteFeature>[sprite()];
    final atlas = spriteAtlas();
    final result = snapshot(atlas: atlas, sprites: sprites);

    sprites.clear();

    expect(result.spriteAtlas, same(atlas));
    expect(result.sprites.single.id, 'hypocenter:event-a');
    expect(() => result.sprites.add(sprite()), throwsUnsupportedError);
  });

  test('rejects sprites when the atlas is absent', () {
    expect(() => snapshot(sprites: [sprite()]), throwsArgumentError);
  });

  test('rejects a sprite that references an unknown atlas region', () {
    expect(
      () => snapshot(
        atlas: spriteAtlas(),
        sprites: [sprite(spriteRegionId: 'missing')],
      ),
      throwsArgumentError,
    );
  });

  test('rejects duplicate sprite feature IDs', () {
    expect(
      () => snapshot(
        atlas: spriteAtlas(),
        sprites: [sprite(), sprite()],
      ),
      throwsArgumentError,
    );
  });

  test('requires a positive caller sprite policy batch limit', () {
    expect(
      () => snapshot(maxSpritePolicyBatches: 0),
      throwsArgumentError,
    );
    expect(
      () => snapshot(maxSpritePolicyBatches: -1),
      throwsArgumentError,
    );
  });

  test('rejects policy pair count above the caller batch limit', () {
    expect(
      () => snapshot(
        atlas: spriteAtlas(),
        sprites: [
          sprite(id: 'first'),
          sprite(id: 'second', endSize: 0.5),
        ],
      ),
      throwsArgumentError,
    );
  });

  test('counts equal policy values as one batch pair', () {
    final result = snapshot(
      atlas: spriteAtlas(),
      sprites: [
        sprite(id: 'first'),
        sprite(id: 'second'),
      ],
    );

    expect(result.sprites, hasLength(2));
  });
}
