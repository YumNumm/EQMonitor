import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_mercator_projection.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/geo/tile_matrix.dart';
import 'package:eqmonitor_map/src/renderer/eqmonitor_orthographic_projection.dart';
import 'package:eqmonitor_map/src/renderer/spike_screen_projector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart';

const _projector = SpikeScreenProjector();

void main() {
  group('tileMatrixFor', () {
    test('places the single whole-world tile at zoom 0', () {
      const tileId = UnwrappedTileId(
        wrap: 0,
        canonical: CanonicalTileId(z: 0, x: 0, y: 0),
      );
      final matrix = tileMatrixFor(tileId: tileId, zoom: 0, extent: 4096);

      expect(matrix.transformed3(Vector3(0, 0, 0)), Vector3(0, 0, 0));
      expect(matrix.transformed3(Vector3(4096, 4096, 0)), Vector3(512, 512, 0));
    });

    test('places a subdivided tile at its (x, y) offset in world pixels', () {
      const tileId = UnwrappedTileId(
        wrap: 0,
        canonical: CanonicalTileId(z: 2, x: 1, y: 1),
      );
      final matrix = tileMatrixFor(tileId: tileId, zoom: 2, extent: 4096);

      expect(matrix.transformed3(Vector3(0, 0, 0)), Vector3(512, 512, 0));
      expect(
        matrix.transformed3(Vector3(4096, 4096, 0)),
        Vector3(1024, 1024, 0),
      );
    });

    test('shifts by a whole world size per wrap for date-line crossing', () {
      const tileId = UnwrappedTileId(
        wrap: 1,
        canonical: CanonicalTileId(z: 1, x: 0, y: 0),
      );
      final matrix = tileMatrixFor(tileId: tileId, zoom: 1, extent: 4096);

      expect(matrix.transformed3(Vector3(0, 0, 0)), Vector3(1024, 0, 0));
      expect(
        matrix.transformed3(Vector3(4096, 4096, 0)),
        Vector3(1536, 512, 0),
      );
    });

    test('rejects a non-positive extent', () {
      const tileId = UnwrappedTileId(
        wrap: 0,
        canonical: CanonicalTileId(z: 0, x: 0, y: 0),
      );
      for (final extent in [0, -1]) {
        expect(
          () => tileMatrixFor(tileId: tileId, zoom: 0, extent: extent),
          throwsArgumentError,
        );
      }
    });
  });

  group('viewProjectionMatrixFor combined with tileMatrixFor', () {
    test('uses the supplied MVT extent when composing the render matrix', () {
      const camera = MapCamera(
        centerLongitude: 0,
        centerLatitude: 0,
        zoom: 0,
      );
      final viewport = MapViewport(
        logicalSize: const Size(512, 512),
        devicePixelRatio: 1,
      );
      const tileId = UnwrappedTileId(
        wrap: 0,
        canonical: CanonicalTileId(z: 0, x: 0, y: 0),
      );
      final extent2048 = baseMapTileViewProjectionMatrixFor(
        camera: camera,
        viewport: viewport,
        tileId: tileId,
        zoom: camera.zoom,
        extent: 2048,
      );
      final extent4096 = baseMapTileViewProjectionMatrixFor(
        camera: camera,
        viewport: viewport,
        tileId: tileId,
        zoom: camera.zoom,
        extent: 4096,
      );

      final center2048 = extent2048.transform3(Vector3(1024, 1024, 0));
      final center4096 = extent4096.transform3(Vector3(2048, 2048, 0));
      expect(center2048.x, closeTo(center4096.x, 1e-12));
      expect(center2048.y, closeTo(center4096.y, 1e-12));
      expect(center2048.z, closeTo(center4096.z, 1e-12));
    });

    // camera中心がworld中心と一致する、512x512の正方形viewportで、
    // whole-world tileの4隅がscreenの4隅へ写ることを確認する。
    Offset screenCornerFor({
      required Vector3 tileLocalCorner,
      required MapViewport viewport,
    }) {
      const camera = MapCamera(
        centerLongitude: 0,
        centerLatitude: 0,
        zoom: 0,
      );
      const tileId = UnwrappedTileId(
        wrap: 0,
        canonical: CanonicalTileId(z: 0, x: 0, y: 0),
      );
      final combined = viewProjectionMatrixFor(
        camera: camera,
        viewport: viewport,
      ).multiplied(tileMatrixFor(tileId: tileId, zoom: 0, extent: 4096));

      return _projector.fromClip(
        clip: combined.transformed3(tileLocalCorner),
        logicalSize: viewport.logicalSize,
        devicePixelRatio: viewport.devicePixelRatio,
      );
    }

    test('maps the 4 tile corners to the 4 screen corners, north-up', () {
      final viewport = MapViewport(
        logicalSize: const Size(512, 512),
        devicePixelRatio: 1,
      );

      expect(
        screenCornerFor(tileLocalCorner: Vector3(0, 0, 0), viewport: viewport),
        offsetCloseTo(Offset.zero),
        reason: 'north-west corner -> top-left',
      );
      expect(
        screenCornerFor(
          tileLocalCorner: Vector3(4096, 0, 0),
          viewport: viewport,
        ),
        offsetCloseTo(const Offset(512, 0)),
        reason: 'north-east corner -> top-right',
      );
      expect(
        screenCornerFor(
          tileLocalCorner: Vector3(0, 4096, 0),
          viewport: viewport,
        ),
        offsetCloseTo(const Offset(0, 512)),
        reason: 'south-west corner -> bottom-left',
      );
      expect(
        screenCornerFor(
          tileLocalCorner: Vector3(4096, 4096, 0),
          viewport: viewport,
        ),
        offsetCloseTo(const Offset(512, 512)),
        reason: 'south-east corner -> bottom-right',
      );
    });

    test('is identical across device pixel ratios (logical pixels)', () {
      for (final devicePixelRatio in [1.0, 2.0, 2.625, 3.0]) {
        final viewport = MapViewport(
          logicalSize: const Size(512, 512),
          devicePixelRatio: devicePixelRatio,
        );
        expect(
          screenCornerFor(
            tileLocalCorner: Vector3(4096, 4096, 0),
            viewport: viewport,
          ),
          offsetCloseTo(const Offset(512, 512)),
        );
      }
    });
  });

  group('origin rebasing preserves float32 precision', () {
    test(
      'keeps float32 round-trip error small for a tile far from the '
      'world origin, unlike the un-rebased projection',
      () {
        const projection = MapMercatorProjection();
        // float32が整数を正確に表せる境界は2^24。tileXがそれを超える
        // ようzoomを選び、rebasingなしでは本当に精度が失われることを
        // 検証する(zoom 20程度ではtileXが2^24未満に収まり誤差が出ない)。
        const zoom = 25.0;
        const extent = 4096;
        const longitude = 139.767; // 東京
        const latitude = 35.681;

        final normalized = projection.lngLatToNormalized(
          longitude: longitude,
          latitude: latitude,
        );
        const tileScale = 1 << 25;
        final tileId = UnwrappedTileId(
          wrap: 0,
          canonical: CanonicalTileId(
            z: 25,
            x: (normalized.x * tileScale).floor(),
            y: (normalized.y * tileScale).floor(),
          ),
        );
        const camera = MapCamera(
          centerLongitude: longitude,
          centerLatitude: latitude,
          zoom: zoom,
        );
        // 幅・高さをどちらも2の冪から外し、world pixel(2の冪の倍率で
        // 動く)との除算がたまたま整数へ丸め込まれて誤差が消えることを防ぐ。
        final viewport = MapViewport(
          logicalSize: const Size(1000, 750),
          devicePixelRatio: 1,
        );
        final tileMatrix = tileMatrixFor(
          tileId: tileId,
          zoom: zoom,
          extent: extent,
        );
        final vertex = Vector3(extent / 2, extent / 2, 0);

        double float32RoundTripError(Matrix4 combined) {
          final precise = combined.transformed3(vertex.clone());
          final rounded = Matrix4.fromList(
            Float32List.fromList(combined.storage),
          ).transformed3(vertex.clone());
          return (precise - rounded).length;
        }

        final rebasedCombined = viewProjectionMatrixFor(
          camera: camera,
          viewport: viewport,
        ).multiplied(tileMatrix);
        final rebasedError = float32RoundTripError(rebasedCombined);

        // rebasingを行わない比較対象: camera中心を引かず、world原点基準の
        // 絶対座標のままOrthoと合成する。
        final unrebasedCombined =
            (EqmonitorOrthographicProjection(
                    worldHalfHeight: viewport.logicalSize.height / 2,
                    depthHalfExtent: 1,
                  ).matrixFor(aspectRatio: viewport.aspectRatio)
                  ..scaleByDouble(1, -1, 1, 1))
                .multiplied(tileMatrix);
        final unrebasedError = float32RoundTripError(unrebasedCombined);

        expect(
          rebasedError,
          lessThan(1e-4),
          reason: 'origin rebasing should keep clip-space error sub-pixel',
        );
        expect(
          unrebasedError,
          greaterThan(rebasedError * 100),
          reason:
              'without rebasing, float32 should lose far more precision '
              'for a tile this far from the world origin',
        );
      },
    );
  });
}

/// [Offset]のcomponentごとの浮動小数点誤差を許容した比較。
Matcher offsetCloseTo(Offset expected, {double epsilon = 1e-9}) =>
    predicate<Offset>(
      (actual) =>
          (actual.dx - expected.dx).abs() < epsilon &&
          (actual.dy - expected.dy).abs() < epsilon,
      'is close to $expected',
    );
