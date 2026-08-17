import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_render_tile_resolver.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/base_map_render_tile_test_support.dart';

void main() {
  test('deduplicates one ancestor selected by multiple requested tiles', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const ancestor = CanonicalTileId(z: 4, x: 7, y: 6);
    putGeometry(cache: cache, tileId: ancestor);
    final cover = [
      requested(tileId: ancestor.children()[0]),
      requested(tileId: ancestor.children()[1]),
    ];

    final rendered = const BaseMapRenderTileResolver().resolve(
      requestedCover: cover,
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );

    expect(cover, hasLength(2));
    expect(rendered.map((tile) => tile.tileId), [
      const UnwrappedTileId(wrap: 0, canonical: ancestor),
    ]);
  });
}
