import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decode_failure_owner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('keeps a failed immutable archive tile terminal', () {
    final owner = BaseMapTileDecodeFailureOwner(maxEntries: 1);
    const tile = CanonicalTileId(z: 6, x: 56, y: 25);
    const nextTile = CanonicalTileId(z: 6, x: 57, y: 25);

    expect(owner.contains(tile), isFalse);

    owner.record(tile);

    expect(owner.contains(tile), isTrue);

    owner.record(nextTile);

    expect(owner.contains(tile), isFalse);
    expect(owner.contains(nextTile), isTrue);
  });
}
