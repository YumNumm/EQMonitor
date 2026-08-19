import 'package:eqmonitor_map/src/tile/map_tile_fallback_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MapTileFallbackPolicy', () {
    test('basemap allows spatial fallback within the same revision', () {
      const policy = MapTileFallbackPolicy.basemap;
      expect(policy.layerKind, MapTileLayerKind.basemap);
      expect(policy.allowsSpatialFallback, isTrue);
      expect(policy.allowsCrossRevisionLastGood, isFalse);
    });

    test('hazard fails closed: no spatial fallback, no cross-revision', () {
      const policy = MapTileFallbackPolicy.hazard;
      expect(policy.layerKind, MapTileLayerKind.hazard);
      expect(policy.allowsSpatialFallback, isFalse);
      expect(policy.allowsCrossRevisionLastGood, isFalse);
    });

    test('never allows cross-revision last-good for either layer', () {
      for (final kind in MapTileLayerKind.values) {
        expect(
          MapTileFallbackPolicy.forLayer(kind).allowsCrossRevisionLastGood,
          isFalse,
          reason: '$kind must never surface a stale cross-revision tile',
        );
      }
    });

    test('forLayer maps each layer kind to its canonical policy', () {
      expect(
        MapTileFallbackPolicy.forLayer(MapTileLayerKind.basemap),
        MapTileFallbackPolicy.basemap,
      );
      expect(
        MapTileFallbackPolicy.forLayer(MapTileLayerKind.hazard),
        MapTileFallbackPolicy.hazard,
      );
    });
  });
}
