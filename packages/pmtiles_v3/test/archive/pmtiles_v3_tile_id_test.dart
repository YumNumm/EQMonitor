import 'package:pmtiles_v3/src/archive/pmtiles_v3_tile_id.dart';
import 'package:pmtiles_v3/src/model/pmtiles_v3_exception.dart';
import 'package:test/test.dart';

void main() {
  const tileId = PmTilesV3TileId();

  // 期待値の出典: protomaps/PMTiles の公式リファレンス実装
  // `js/src/index.ts` の `zxyToTileId`/`rotate`（2026-08-05時点のdefault
  // branch、commit historyはgithub.com/protomaps/PMTiles参照）を素直に
  // 移植した上で、その実装を直接実行して得た値。z2の4隅は
  // `((1<<z)*(1<<z)-1)/3`のacc起点(z2で5)から実装をそのまま辿って
  // 導出しており、Wikipedia版Hilbert曲線の教科書的実装とは
  // rotate()の引数（縮小するsを渡す）が異なるため、この参照実装
  // そのものから値を取っている。
  test('matches the PMTiles v3 reference z0/z1 Hilbert ordering', () {
    expect(tileId.tileIdForZxy(z: 0, x: 0, y: 0), 0);
    expect(tileId.tileIdForZxy(z: 1, x: 0, y: 0), 1);
    expect(tileId.tileIdForZxy(z: 1, x: 0, y: 1), 2);
    expect(tileId.tileIdForZxy(z: 1, x: 1, y: 1), 3);
    expect(tileId.tileIdForZxy(z: 1, x: 1, y: 0), 4);
  });

  test(
    'matches the PMTiles v3 reference z2 Hilbert ordering at all corners',
    () {
      expect(tileId.tileIdForZxy(z: 2, x: 0, y: 0), 5);
      expect(tileId.tileIdForZxy(z: 2, x: 3, y: 0), 20);
      expect(tileId.tileIdForZxy(z: 2, x: 0, y: 3), 10);
      expect(tileId.tileIdForZxy(z: 2, x: 3, y: 3), 15);
    },
  );

  test('bijects every x/y at a zoom onto that zoom exact tile ID range', () {
    for (var zoom = 0; zoom <= 6; zoom++) {
      final range = tileId.rangeForZoom(zoom: zoom);
      final levelTiles = 1 << zoom;
      final seen = <int>{};
      for (var y = 0; y < levelTiles; y++) {
        for (var x = 0; x < levelTiles; x++) {
          final id = tileId.tileIdForZxy(z: zoom, x: x, y: y);
          expect(id, inInclusiveRange(range.start, range.endExclusive - 1));
          expect(seen.add(id), isTrue, reason: 'duplicate tile ID $id');
        }
      }
      expect(seen.length, levelTiles * levelTiles);
    }
  });

  test('inverts every tile ID produced through zoom 8', () {
    expect(tileId.zxyForTileId(tileId: 0), (z: 0, x: 0, y: 0));
    for (var z = 0; z <= 8; z++) {
      final side = 1 << z;
      for (var y = 0; y < side; y++) {
        for (var x = 0; x < side; x++) {
          final id = tileId.tileIdForZxy(z: z, x: x, y: y);
          expect(tileId.zxyForTileId(tileId: id), (z: z, x: x, y: y));
        }
      }
    }
  });

  test('inverts the first and last tile IDs at zoom 31', () {
    final range = tileId.rangeForZoom(zoom: PmTilesV3TileId.maxZoom);
    expect(
      tileId.zxyForTileId(tileId: range.start),
      (z: PmTilesV3TileId.maxZoom, x: 0, y: 0),
    );
    expect(
      tileId.zxyForTileId(tileId: range.endExclusive - 1),
      (
        z: PmTilesV3TileId.maxZoom,
        x: (1 << PmTilesV3TileId.maxZoom) - 1,
        y: 0,
      ),
    );
  });

  test('rejects an out-of-range tile ID before inverse conversion', () {
    expect(
      () => tileId.zxyForTileId(tileId: -1),
      throwsA(isA<PmTilesV3InvalidTileIdException>()),
    );
  });

  test('rejects zoom and coordinates outside the archive grid', () {
    expect(
      () => tileId.tileIdForZxy(z: -1, x: 0, y: 0),
      throwsA(isA<PmTilesV3InvalidTileCoordinateException>()),
    );
    expect(
      () => tileId.tileIdForZxy(z: PmTilesV3TileId.maxZoom + 1, x: 0, y: 0),
      throwsA(isA<PmTilesV3InvalidTileCoordinateException>()),
    );
    expect(
      () => tileId.tileIdForZxy(z: 2, x: 4, y: 0),
      throwsA(isA<PmTilesV3InvalidTileCoordinateException>()),
    );
    expect(
      () => tileId.tileIdForZxy(z: 2, x: 0, y: -1),
      throwsA(isA<PmTilesV3InvalidTileCoordinateException>()),
    );
  });

  test('rejects out-of-range raw tile IDs', () {
    expect(
      () => tileId.validateArgument(tileId: -1),
      throwsA(isA<PmTilesV3InvalidTileIdException>()),
    );
    expect(
      () => tileId.validateArgument(tileId: PmTilesV3TileId.maxValue + 1),
      throwsA(isA<PmTilesV3InvalidTileIdException>()),
    );
  });
}
