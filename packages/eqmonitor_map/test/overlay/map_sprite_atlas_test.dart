import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const generousLimits = MapSpriteAtlasLimits(
    maxWidth: 64,
    maxHeight: 64,
    maxPixelBytes: 64 * 64 * 4,
    maxRegions: 8,
  );

  MapSpriteAtlas atlas({
    int width = 2,
    int height = 2,
    Uint8List? rgbaBytes,
    List<MapSpriteRegion> regions = const [],
    MapSpriteAtlasLimits limits = generousLimits,
  }) => createMapSpriteAtlas(
    identity: createMapSourceIdentity(value: 'sha256:atlas'),
    width: width,
    height: height,
    rgbaBytes:
        rgbaBytes ??
        Uint8List.fromList(const [
          255,
          0,
          0,
          255,
          0,
          255,
          0,
          255,
          0,
          0,
          255,
          255,
          255,
          255,
          255,
          255,
        ]),
    regions: regions,
    limits: limits,
  );

  test('preserves top-left row-major tight RGBA8888 bytes', () {
    final result = atlas();

    expect(result.width, 2);
    expect(result.height, 2);
    expect(result.rowStrideBytes, 8);
    expect(MapSpriteAtlas.bytesPerPixel, 4);
    expect(result.rgbaBytes, const [
      255,
      0,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      0,
      255,
      255,
      255,
      255,
      255,
      255,
    ]);
  });

  test('keeps sRGB color channels straight when alpha is one half', () {
    final result = atlas(
      width: 1,
      height: 1,
      rgbaBytes: Uint8List.fromList(const [200, 100, 50, 128]),
    );

    expect(result.rgbaBytes, const [200, 100, 50, 128]);
  });

  test('takes unmodifiable defensive copies of bytes and regions', () {
    final bytes = Uint8List.fromList(const [10, 20, 30, 40]);
    final regions = <MapSpriteRegion>[
      const MapSpriteRegion(
        id: 'normal',
        normalizedUv: Rect.fromLTRB(0.5, 0.5, 0.5, 0.5),
        logicalSize: Size(1, 1),
      ),
    ];
    final result = atlas(
      width: 1,
      height: 1,
      rgbaBytes: bytes,
      regions: regions,
    );

    bytes[0] = 255;
    regions.clear();

    expect(result.rgbaBytes, const [10, 20, 30, 40]);
    expect(result.regions.single.id, 'normal');
    expect(() => result.rgbaBytes[0] = 0, throwsUnsupportedError);
    expect(
      () => result.regions.add(result.regions.single),
      throwsUnsupportedError,
    );
  });

  test('rejects non-positive dimensions and non-tight byte counts', () {
    expect(() => atlas(width: 0, height: 1), throwsArgumentError);
    expect(() => atlas(width: 1, height: -1), throwsArgumentError);
    expect(
      () => atlas(rgbaBytes: Uint8List.fromList(List.filled(15, 0))),
      throwsArgumentError,
    );
    expect(
      () => atlas(rgbaBytes: Uint8List.fromList(List.filled(17, 0))),
      throwsArgumentError,
    );
  });

  test('rejects invalid caller limits before accepting an atlas', () {
    for (final limits in const [
      MapSpriteAtlasLimits(
        maxWidth: 0,
        maxHeight: 2,
        maxPixelBytes: 16,
        maxRegions: 1,
      ),
      MapSpriteAtlasLimits(
        maxWidth: 2,
        maxHeight: 0,
        maxPixelBytes: 16,
        maxRegions: 1,
      ),
      MapSpriteAtlasLimits(
        maxWidth: 2,
        maxHeight: 2,
        maxPixelBytes: 0,
        maxRegions: 1,
      ),
      MapSpriteAtlasLimits(
        maxWidth: 2,
        maxHeight: 2,
        maxPixelBytes: 16,
        maxRegions: 0,
      ),
    ]) {
      expect(() => atlas(limits: limits), throwsArgumentError);
    }
  });

  test('enforces caller dimension byte and region limits', () {
    expect(
      () => atlas(
        limits: const MapSpriteAtlasLimits(
          maxWidth: 1,
          maxHeight: 2,
          maxPixelBytes: 16,
          maxRegions: 1,
        ),
      ),
      throwsArgumentError,
    );
    expect(
      () => atlas(
        limits: const MapSpriteAtlasLimits(
          maxWidth: 2,
          maxHeight: 1,
          maxPixelBytes: 16,
          maxRegions: 1,
        ),
      ),
      throwsArgumentError,
    );
    expect(
      () => atlas(
        limits: const MapSpriteAtlasLimits(
          maxWidth: 2,
          maxHeight: 2,
          maxPixelBytes: 15,
          maxRegions: 1,
        ),
      ),
      throwsArgumentError,
    );
    expect(
      () => atlas(
        regions: const [
          MapSpriteRegion(
            id: 'normal',
            normalizedUv: Rect.fromLTRB(0.25, 0.25, 0.75, 0.75),
            logicalSize: Size(2, 2),
          ),
          MapSpriteRegion(
            id: 'low-precision',
            normalizedUv: Rect.fromLTRB(0.25, 0.25, 0.75, 0.75),
            logicalSize: Size(2, 2),
          ),
        ],
        limits: const MapSpriteAtlasLimits(
          maxWidth: 2,
          maxHeight: 2,
          maxPixelBytes: 16,
          maxRegions: 1,
        ),
      ),
      throwsArgumentError,
    );
  });

  test('rejects blank or duplicate region IDs', () {
    const valid = MapSpriteRegion(
      id: 'normal',
      normalizedUv: Rect.fromLTRB(0.25, 0.25, 0.75, 0.75),
      logicalSize: Size(2, 2),
    );
    expect(
      () => atlas(
        regions: const [
          MapSpriteRegion(
            id: ' ',
            normalizedUv: Rect.fromLTRB(0.25, 0.25, 0.75, 0.75),
            logicalSize: Size(2, 2),
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => atlas(regions: const [valid, valid]),
      throwsArgumentError,
    );
  });

  test('rejects non-finite out-of-range or inverted UV coordinates', () {
    for (final uv in const [
      Rect.fromLTRB(double.nan, 0, 1, 1),
      Rect.fromLTRB(0, 0, double.infinity, 1),
      Rect.fromLTRB(-0.01, 0, 1, 1),
      Rect.fromLTRB(0, 0, 1.01, 1),
      Rect.fromLTRB(0.75, 0, 0.25, 1),
      Rect.fromLTRB(0, 0.75, 1, 0.25),
    ]) {
      expect(
        () => atlas(
          regions: [
            MapSpriteRegion(
              id: 'normal',
              normalizedUv: uv,
              logicalSize: const Size(2, 2),
            ),
          ],
        ),
        throwsArgumentError,
      );
    }
  });

  test('rejects non-finite or non-positive logical size', () {
    for (final size in const [
      Size(double.nan, 1),
      Size(1, double.infinity),
      Size(0, 1),
      Size(1, -1),
    ]) {
      expect(
        () => atlas(
          regions: [
            MapSpriteRegion(
              id: 'normal',
              normalizedUv: const Rect.fromLTRB(0.25, 0.25, 0.75, 0.75),
              logicalSize: size,
            ),
          ],
        ),
        throwsArgumentError,
      );
    }
  });

  test('describes two-pixel extrusion with texel-center UVs', () {
    const extrudedBytes = [
      255,
      0,
      0,
      255,
      255,
      0,
      0,
      255,
      255,
      0,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      255,
      255,
      0,
      0,
      255,
      255,
      0,
      0,
      255,
      255,
      0,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      255,
      255,
      0,
      0,
      255,
      255,
      0,
      0,
      255,
      255,
      0,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      255,
      0,
      0,
      255,
      255,
      0,
      0,
      255,
      255,
      0,
      0,
      255,
      255,
      255,
      255,
      0,
      255,
      255,
      255,
      0,
      255,
      255,
      255,
      0,
      255,
      0,
      0,
      255,
      255,
      0,
      0,
      255,
      255,
      0,
      0,
      255,
      255,
      255,
      255,
      0,
      255,
      255,
      255,
      0,
      255,
      255,
      255,
      0,
      255,
      0,
      0,
      255,
      255,
      0,
      0,
      255,
      255,
      0,
      0,
      255,
      255,
      255,
      255,
      0,
      255,
      255,
      255,
      0,
      255,
      255,
      255,
      0,
      255,
    ];
    final result = atlas(
      width: 6,
      height: 6,
      rgbaBytes: Uint8List.fromList(extrudedBytes),
      regions: const [
        MapSpriteRegion(
          id: 'normal',
          normalizedUv: Rect.fromLTRB(2.5 / 6, 2.5 / 6, 3.5 / 6, 3.5 / 6),
          logicalSize: Size(2, 2),
        ),
      ],
    );

    expect(MapSpriteAtlas.regionExtrusionPixels, 2);
    expect(result.rgbaBytes, extrudedBytes);
    expect(
      result.regions.single.normalizedUv,
      const Rect.fromLTRB(2.5 / 6, 2.5 / 6, 3.5 / 6, 3.5 / 6),
    );
  });
}
