import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/scheduler/map_tile_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MapTileScheduler makeScheduler({int maxInFlight = 2}) =>
      MapTileScheduler(maxInFlightDecodes: maxInFlight);

  CanonicalTileId canonical(int x, int y) => CanonicalTileId(z: 5, x: x, y: y);

  UnwrappedTileId tile(int x, int y, {int wrap = 0}) =>
      UnwrappedTileId(wrap: wrap, canonical: canonical(x, y));

  group('MapTileScheduler.selectNext', () {
    test('keeps the wrap-aware order produced by the cover calculator', () {
      final scheduler = makeScheduler();
      // date line 跨ぎ: 視覚的に中心の隣なのは wrap:-1 の x=31 で、
      // canonical x の差だけで測ると最遠と誤判定される並び。
      final selected = scheduler.selectNext(
        coverOrdered: [tile(0, 0), tile(31, 0, wrap: -1), tile(8, 0)],
        inFlight: const {},
        completed: const {},
      );
      expect(selected, [tile(0, 0), tile(31, 0, wrap: -1)]);
    });

    test('decodes a canonical tile once even across world copies', () {
      final scheduler = makeScheduler();
      final selected = scheduler.selectNext(
        coverOrdered: [tile(3, 3), tile(3, 3, wrap: 1), tile(4, 4)],
        inFlight: const {},
        completed: const {},
      );
      expect(
        selected,
        [tile(3, 3), tile(4, 4)],
        reason: 'the second world copy shares the same PMTiles bytes',
      );
    });

    test('skips a world copy whose canonical decode is already in flight', () {
      final scheduler = makeScheduler();
      final selected = scheduler.selectNext(
        coverOrdered: [tile(3, 3, wrap: 1), tile(4, 4)],
        inFlight: {canonical(3, 3)},
        completed: const {},
      );
      expect(selected, [tile(4, 4)]);
    });

    test('coalesces tiles already in flight or completed', () {
      final scheduler = makeScheduler(maxInFlight: 4);
      final selected = scheduler.selectNext(
        coverOrdered: [tile(1, 1), tile(2, 2), tile(3, 3), tile(1, 1)],
        inFlight: {canonical(2, 2)},
        completed: {canonical(3, 3)},
      );
      expect(selected, [tile(1, 1)]);
    });

    test('applies backpressure using the remaining in-flight budget', () {
      final scheduler = makeScheduler(maxInFlight: 3);
      final selected = scheduler.selectNext(
        coverOrdered: [tile(1, 0), tile(2, 0), tile(3, 0), tile(4, 0)],
        inFlight: {canonical(9, 9)},
        completed: const {},
      );
      expect(selected, [tile(1, 0), tile(2, 0)]);
    });

    test('returns nothing when the in-flight budget is saturated', () {
      final scheduler = makeScheduler(maxInFlight: 1);
      final selected = scheduler.selectNext(
        coverOrdered: [tile(1, 0)],
        inFlight: {canonical(9, 9)},
        completed: const {},
      );
      expect(selected, isEmpty);
    });
  });

  group('MapTileScheduler.tilesToCancel', () {
    test('cancels in-flight decodes dropped by a camera move', () {
      final scheduler = makeScheduler();
      final cancelled = scheduler.tilesToCancel(
        inFlight: {canonical(1, 1), canonical(2, 2), canonical(3, 3)},
        stillRequested: {canonical(2, 2)},
      );
      expect(cancelled, {canonical(1, 1), canonical(3, 3)});
    });

    test('cancels nothing when every in-flight decode is still requested', () {
      final scheduler = makeScheduler();
      final cancelled = scheduler.tilesToCancel(
        inFlight: {canonical(1, 1)},
        stillRequested: {canonical(1, 1), canonical(2, 2)},
      );
      expect(cancelled, isEmpty);
    });
  });
}
