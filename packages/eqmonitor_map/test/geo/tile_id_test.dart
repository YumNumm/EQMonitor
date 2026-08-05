import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CanonicalTileId', () {
    test('supports value equality and hashCode', () {
      const a = CanonicalTileId(z: 5, x: 3, y: 7);
      const b = CanonicalTileId(z: 5, x: 3, y: 7);
      const c = CanonicalTileId(z: 5, x: 3, y: 8);

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(c));
    });

    test('scaledTo a lower zoom shifts toward the ancestor tile', () {
      const tile = CanonicalTileId(z: 5, x: 20, y: 11);

      expect(tile.scaledTo(3), const CanonicalTileId(z: 3, x: 5, y: 2));
      expect(tile.scaledTo(5), tile);
    });

    test('scaledTo a higher zoom shifts toward the descendant tile', () {
      const tile = CanonicalTileId(z: 3, x: 5, y: 2);

      expect(tile.scaledTo(5), const CanonicalTileId(z: 5, x: 20, y: 8));
    });

    test(
      'scaledTo round-trips down then up onto the same-origin descendant',
      () {
        const tile = CanonicalTileId(z: 6, x: 40, y: 21);
        final parent = tile.scaledTo(3);
        final backUp = parent.scaledTo(6);

        // シフトで切り捨てられた下位ビットは戻らないため、親経由の子孫は
        // 元のtileの左上コーナー相当になる。
        expect(backUp.z, tile.z);
        expect(backUp.x, tile.x - (tile.x % 8));
        expect(backUp.y, tile.y - (tile.y % 8));
      },
    );

    test('children lists the 4 tiles at z+1 from (x*2, y*2)', () {
      const tile = CanonicalTileId(z: 4, x: 3, y: 6);

      expect(tile.children(), [
        const CanonicalTileId(z: 5, x: 6, y: 12),
        const CanonicalTileId(z: 5, x: 7, y: 12),
        const CanonicalTileId(z: 5, x: 6, y: 13),
        const CanonicalTileId(z: 5, x: 7, y: 13),
      ]);
    });

    test('children are consistent with scaledTo for each child', () {
      const tile = CanonicalTileId(z: 4, x: 3, y: 6);

      for (final child in tile.children()) {
        expect(child.scaledTo(tile.z), tile);
      }
    });

    test('rejects negative coordinates', () {
      expect(() => CanonicalTileId(z: -1, x: 0, y: 0), throwsAssertionError);
      expect(() => CanonicalTileId(z: 0, x: -1, y: 0), throwsAssertionError);
      expect(() => CanonicalTileId(z: 0, x: 0, y: -1), throwsAssertionError);
    });
  });

  group('OverscaledTileId', () {
    test('overscaleFactor is 1 when not overscaled', () {
      final id = OverscaledTileId(
        overscaledZ: 5,
        wrap: 0,
        canonical: const CanonicalTileId(z: 5, x: 1, y: 1),
      );
      expect(id.overscaleFactor, 1);
    });

    test('overscaleFactor doubles per extra zoom level beyond canonical', () {
      final id = OverscaledTileId(
        overscaledZ: 8,
        wrap: 0,
        canonical: const CanonicalTileId(z: 5, x: 1, y: 1),
      );
      expect(id.overscaleFactor, 8);
    });

    test('toUnwrapped keeps wrap and canonical, drops overscaledZ', () {
      final id = OverscaledTileId(
        overscaledZ: 7,
        wrap: -2,
        canonical: const CanonicalTileId(z: 5, x: 1, y: 1),
      );

      expect(
        id.toUnwrapped(),
        const UnwrappedTileId(
          wrap: -2,
          canonical: CanonicalTileId(z: 5, x: 1, y: 1),
        ),
      );
    });

    test('rejects an overscaledZ below canonical.z', () {
      expect(
        () => OverscaledTileId(
          overscaledZ: 2,
          wrap: 0,
          canonical: const CanonicalTileId(z: 5, x: 1, y: 1),
        ),
        throwsAssertionError,
      );
    });

    test('supports value equality', () {
      final a = OverscaledTileId(
        overscaledZ: 5,
        wrap: 0,
        canonical: const CanonicalTileId(z: 5, x: 1, y: 1),
      );
      final b = OverscaledTileId(
        overscaledZ: 5,
        wrap: 0,
        canonical: const CanonicalTileId(z: 5, x: 1, y: 1),
      );
      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });
  });

  group('UnwrappedTileId', () {
    test('supports value equality including wrap (world copy)', () {
      const a = UnwrappedTileId(
        wrap: 1,
        canonical: CanonicalTileId(z: 3, x: 2, y: 2),
      );
      const b = UnwrappedTileId(
        wrap: 1,
        canonical: CanonicalTileId(z: 3, x: 2, y: 2),
      );
      const differentWrap = UnwrappedTileId(
        wrap: 0,
        canonical: CanonicalTileId(z: 3, x: 2, y: 2),
      );

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(differentWrap));
    });
  });
}
