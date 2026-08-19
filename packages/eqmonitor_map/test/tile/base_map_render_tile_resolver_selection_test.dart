import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_render_tile_resolver.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/base_map_render_tile_test_support.dart';

void main() {
  test('keeps exact hits in requested cover order', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const first = CanonicalTileId(z: 5, x: 3, y: 4);
    const second = CanonicalTileId(z: 5, x: 2, y: 4);
    putGeometry(cache: cache, tileId: first);
    putGeometry(cache: cache, tileId: second);

    final rendered = const BaseMapRenderTileResolver().resolve(
      requestedCover: [
        requested(tileId: first),
        requested(tileId: second),
      ],
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );

    expect(rendered.map((tile) => tile.tileId), [
      const UnwrappedTileId(wrap: 0, canonical: first),
      const UnwrappedTileId(wrap: 0, canonical: second),
    ]);
  });

  test('omits a fallback miss', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const tileId = CanonicalTileId(z: 5, x: 3, y: 4);

    final rendered = const BaseMapRenderTileResolver().resolve(
      requestedCover: [requested(tileId: tileId)],
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );

    expect(rendered, isEmpty);
  });

  test('expands a four-child fallback in CanonicalTileId.children order', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const parent = CanonicalTileId(z: 4, x: 1, y: 2);
    final children = parent.children();
    for (final child in children) {
      putGeometry(cache: cache, tileId: child);
    }

    final rendered = const BaseMapRenderTileResolver().resolve(
      requestedCover: [requested(tileId: parent, wrap: 2)],
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );

    expect(rendered.map((tile) => tile.tileId), [
      for (final child in children) UnwrappedTileId(wrap: 2, canonical: child),
    ]);
  });
}
