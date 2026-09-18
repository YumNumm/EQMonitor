import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:eqmonitor_map/src/tile/earthquake_area_tile_geometry.dart';
import 'package:eqmonitor_map/src/tile/earthquake_overlay_exact_tile_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final cache = BaseMapTileCache(
    maxEntries: 16,
    maxParentFallbackSteps: 4,
  );

  BaseMapTileGeometry geometry({
    required int? regionExtent,
    required int? cityExtent,
  }) => BaseMapTileGeometry(
    layers: const [],
    earthquakeAreas: EarthquakeAreaTileGeometry(
      forecastRegions: EarthquakeAreaTileLayerGeometry(
        extent: regionExtent,
        features: const [],
      ),
      cities: EarthquakeAreaTileLayerGeometry(
        extent: cityExtent,
        features: const [],
      ),
    ),
  );

  void put({
    required String sourceInstanceId,
    required CanonicalTileId tileId,
    required BaseMapTileGeometry tileGeometry,
  }) {
    cache.put(
      sourceInstanceId: sourceInstanceId,
      tileId: tileId,
      geometry: tileGeometry,
      token: cache.beginDecode(),
    );
  }

  test('misses when only the parent tile is cached', () {
    const parent = CanonicalTileId(z: 6, x: 12, y: 23);
    final requested = UnwrappedTileId(
      wrap: 1,
      canonical: parent.children().first,
    );
    put(
      sourceInstanceId: 'source-a',
      tileId: parent,
      tileGeometry: geometry(regionExtent: 4096, cityExtent: null),
    );

    final result = resolveEarthquakeOverlayExactTile(
      requestedTile: requested,
      sourceInstanceId: 'source-a',
      cache: cache,
      mode: EarthquakeAreaLayerMode.region,
      missReason: EarthquakeOverlayExactTileMissReason.pending,
    );

    expect(result, isA<EarthquakeOverlayExactTilePending>());
    expect(result.canonicalTileId, requested.canonical);
  });

  test('uses only the exact source identity', () {
    const tile = CanonicalTileId(z: 7, x: 25, y: 46);
    const requested = UnwrappedTileId(wrap: -1, canonical: tile);
    put(
      sourceInstanceId: 'other-source',
      tileId: tile,
      tileGeometry: geometry(regionExtent: 2048, cityExtent: 2048),
    );
    put(
      sourceInstanceId: 'source-a',
      tileId: tile,
      tileGeometry: geometry(regionExtent: 4096, cityExtent: 4096),
    );

    final result = resolveEarthquakeOverlayExactTile(
      requestedTile: requested,
      sourceInstanceId: 'source-a',
      cache: cache,
      mode: EarthquakeAreaLayerMode.region,
      missReason: EarthquakeOverlayExactTileMissReason.decodeFailure,
    );

    expect(result, isA<EarthquakeOverlayExactTileHit>());
    final hit = result as EarthquakeOverlayExactTileHit;
    expect(hit.tileId, requested);
    expect(hit.sourceInstanceId, 'source-a');
    expect(hit.canonicalTileId, requested.canonical);
    expect(hit.areaGeometry.extent, 4096);
  });

  test('keeps the requested tile and selected region or city extent', () {
    const tile = CanonicalTileId(z: 7, x: 25, y: 46);
    const requested = UnwrappedTileId(wrap: -1, canonical: tile);
    put(
      sourceInstanceId: 'source-a',
      tileId: tile,
      tileGeometry: geometry(regionExtent: 4096, cityExtent: 512),
    );

    final region = resolveEarthquakeOverlayExactTile(
      requestedTile: requested,
      sourceInstanceId: 'source-a',
      cache: cache,
      mode: EarthquakeAreaLayerMode.region,
      missReason: EarthquakeOverlayExactTileMissReason.pending,
    );
    final city = resolveEarthquakeOverlayExactTile(
      requestedTile: requested,
      sourceInstanceId: 'source-a',
      cache: cache,
      mode: EarthquakeAreaLayerMode.city,
      missReason: EarthquakeOverlayExactTileMissReason.pending,
    );

    expect(region, isA<EarthquakeOverlayExactTileHit>());
    expect(city, isA<EarthquakeOverlayExactTileHit>());
    expect((region as EarthquakeOverlayExactTileHit).tileId, requested);
    expect(region.areaGeometry.extent, 4096);
    expect((city as EarthquakeOverlayExactTileHit).tileId, requested);
    expect(city.areaGeometry.extent, 512);
  });

  test('does not use the region layer when the city layer is missing', () {
    const tile = CanonicalTileId(z: 7, x: 25, y: 46);
    const requested = UnwrappedTileId(wrap: 0, canonical: tile);
    put(
      sourceInstanceId: 'source-a',
      tileId: tile,
      tileGeometry: geometry(regionExtent: 4096, cityExtent: null),
    );

    final result = resolveEarthquakeOverlayExactTile(
      requestedTile: requested,
      sourceInstanceId: 'source-a',
      cache: cache,
      mode: EarthquakeAreaLayerMode.city,
      missReason: EarthquakeOverlayExactTileMissReason.pending,
    );

    expect(result, isA<EarthquakeOverlayExactTileHit>());
    expect(
      (result as EarthquakeOverlayExactTileHit).areaGeometry.extent,
      isNull,
    );
  });

  test('distinguishes directory absence and decode failure', () {
    const requested = UnwrappedTileId(
      wrap: 0,
      canonical: CanonicalTileId(z: 7, x: 24, y: 46),
    );

    final absent = resolveEarthquakeOverlayExactTile(
      requestedTile: requested,
      sourceInstanceId: 'source-a',
      cache: cache,
      mode: EarthquakeAreaLayerMode.city,
      missReason: EarthquakeOverlayExactTileMissReason.authoritativeEmpty,
    );
    final failure = resolveEarthquakeOverlayExactTile(
      requestedTile: requested,
      sourceInstanceId: 'source-a',
      cache: cache,
      mode: EarthquakeAreaLayerMode.city,
      missReason: EarthquakeOverlayExactTileMissReason.decodeFailure,
    );

    expect(absent, isA<EarthquakeOverlayExactTileAuthoritativeEmpty>());
    expect(failure, isA<EarthquakeOverlayExactTileDecodeFailure>());
  });
}
