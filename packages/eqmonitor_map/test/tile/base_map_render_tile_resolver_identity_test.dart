import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_render_tile_resolver.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/base_map_render_tile_test_support.dart';

void main() {
  test('keeps the same canonical ancestor in distinct world wraps', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const ancestor = CanonicalTileId(z: 4, x: 1, y: 2);
    final child = ancestor.children().first;
    putGeometry(cache: cache, tileId: ancestor);

    final rendered = const BaseMapRenderTileResolver().resolve(
      requestedCover: [
        requested(tileId: child),
        requested(tileId: child, wrap: 1),
      ],
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );

    expect(rendered.map((tile) => tile.tileId), [
      const UnwrappedTileId(wrap: 0, canonical: ancestor),
      const UnwrappedTileId(wrap: 1, canonical: ancestor),
    ]);
  });

  test('returns the same ordered tile IDs for repeated resolution', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const first = CanonicalTileId(z: 5, x: 3, y: 4);
    const second = CanonicalTileId(z: 5, x: 2, y: 4);
    putGeometry(cache: cache, tileId: first);
    putGeometry(cache: cache, tileId: second);
    final cover = [requested(tileId: first), requested(tileId: second)];
    const resolver = BaseMapRenderTileResolver();

    final firstRun = resolver.resolve(
      requestedCover: cover,
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );
    final secondRun = resolver.resolve(
      requestedCover: cover,
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );

    expect(
      secondRun.map((tile) => tile.tileId),
      firstRun.map((tile) => tile.tileId).toList(),
    );
  });

  test('rejects a negative parent fallback limit', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );

    expect(
      () => const BaseMapRenderTileResolver().resolve(
        requestedCover: const [],
        sourceInstanceId: sourceId,
        cache: cache,
        maxParentSteps: -1,
      ),
      throwsArgumentError,
    );
  });
}
