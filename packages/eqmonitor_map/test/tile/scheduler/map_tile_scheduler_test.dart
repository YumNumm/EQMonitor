import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/map_tile_pipeline_budget.dart';
import 'package:eqmonitor_map/src/tile/scheduler/map_tile_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MapTilePipelineBudget budget({int maxInFlight = 2}) =>
      createMapTilePipelineBudget(
        schemaVersion: 1,
        maxInFlightDecodes: maxInFlight,
        maxCacheEntries: 64,
        maxPinnedEntries: 8,
        cpuWorkUnitsPerFrame: 4,
        maxGpuUploadBytesPerFrame: null,
      );

  UnwrappedTileId tile(int x, int y, {int wrap = 0}) => UnwrappedTileId(
    wrap: wrap,
    canonical: CanonicalTileId(z: 5, x: x, y: y),
  );

  group('MapTileScheduler.selectNext', () {
    test('keeps the wrap-aware order produced by the cover calculator', () {
      final scheduler = MapTileScheduler(budget: budget());
      // date line 跨ぎ: 視覚的に中心の隣なのは wrap:-1 の x=31 で、
      // canonical x の差だけで測ると最遠と誤判定される並び。
      final selected = scheduler.selectNext(
        coverOrdered: [tile(0, 0), tile(31, 0, wrap: -1), tile(8, 0)],
        inFlight: const {},
        completed: const {},
      );
      expect(selected, [tile(0, 0), tile(31, 0, wrap: -1)]);
    });

    test('treats another world copy of a canonical tile as distinct', () {
      final scheduler = MapTileScheduler(budget: budget());
      final selected = scheduler.selectNext(
        coverOrdered: [tile(3, 3), tile(3, 3, wrap: 1)],
        inFlight: {tile(3, 3)},
        completed: const {},
      );
      expect(selected, [tile(3, 3, wrap: 1)]);
    });

    test('coalesces tiles already in flight or completed', () {
      final scheduler = MapTileScheduler(budget: budget(maxInFlight: 4));
      final selected = scheduler.selectNext(
        coverOrdered: [tile(1, 1), tile(2, 2), tile(3, 3), tile(1, 1)],
        inFlight: {tile(2, 2)},
        completed: {tile(3, 3)},
      );
      expect(selected, [tile(1, 1)]);
    });

    test('applies backpressure using the remaining in-flight budget', () {
      final scheduler = MapTileScheduler(budget: budget(maxInFlight: 3));
      final selected = scheduler.selectNext(
        coverOrdered: [tile(1, 0), tile(2, 0), tile(3, 0), tile(4, 0)],
        inFlight: {tile(9, 9)},
        completed: const {},
      );
      expect(selected, [tile(1, 0), tile(2, 0)]);
    });

    test('returns nothing when the in-flight budget is saturated', () {
      final scheduler = MapTileScheduler(budget: budget(maxInFlight: 1));
      final selected = scheduler.selectNext(
        coverOrdered: [tile(1, 0)],
        inFlight: {tile(9, 9)},
        completed: const {},
      );
      expect(selected, isEmpty);
    });
  });

  group('MapTileScheduler.tilesToCancel', () {
    test('cancels in-flight tiles no longer requested after a camera move', () {
      final scheduler = MapTileScheduler(budget: budget());
      final cancelled = scheduler.tilesToCancel(
        inFlight: {tile(1, 1), tile(2, 2), tile(3, 3)},
        stillRequested: {tile(2, 2)},
      );
      expect(cancelled, {tile(1, 1), tile(3, 3)});
    });

    test('cancels nothing when every in-flight tile is still requested', () {
      final scheduler = MapTileScheduler(budget: budget());
      final cancelled = scheduler.tilesToCancel(
        inFlight: {tile(1, 1)},
        stillRequested: {tile(1, 1), tile(2, 2)},
      );
      expect(cancelled, isEmpty);
    });
  });
}
