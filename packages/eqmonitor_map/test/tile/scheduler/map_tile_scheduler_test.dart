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

  CanonicalTileId tile(int x, int y) => CanonicalTileId(z: 5, x: x, y: y);

  group('MapTileScheduler.selectNext', () {
    test('prefers tiles nearest to the camera center', () {
      final scheduler = MapTileScheduler(budget: budget());
      final selected = scheduler.selectNext(
        requested: [tile(10, 10), tile(2, 2), tile(6, 6)],
        inFlight: const {},
        completed: const {},
        center: tile(1, 1),
      );
      expect(selected, [tile(2, 2), tile(6, 6)]);
    });

    test('coalesces tiles already in flight or completed', () {
      final scheduler = MapTileScheduler(budget: budget(maxInFlight: 4));
      final selected = scheduler.selectNext(
        requested: [tile(1, 1), tile(2, 2), tile(3, 3), tile(1, 1)],
        inFlight: {tile(2, 2)},
        completed: {tile(3, 3)},
        center: tile(0, 0),
      );
      expect(selected, [tile(1, 1)]);
    });

    test('applies backpressure using the remaining in-flight budget', () {
      final scheduler = MapTileScheduler(budget: budget(maxInFlight: 3));
      final selected = scheduler.selectNext(
        requested: [tile(1, 0), tile(2, 0), tile(3, 0), tile(4, 0)],
        inFlight: {tile(9, 9)},
        completed: const {},
        center: tile(0, 0),
      );
      expect(selected.length, 2);
      expect(selected, [tile(1, 0), tile(2, 0)]);
    });

    test('returns nothing when the in-flight budget is saturated', () {
      final scheduler = MapTileScheduler(budget: budget(maxInFlight: 1));
      final selected = scheduler.selectNext(
        requested: [tile(1, 0)],
        inFlight: {tile(9, 9)},
        completed: const {},
        center: tile(0, 0),
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
