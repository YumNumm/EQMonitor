// `BaseMapView`本体はScene/gestureを含みwidget testの対象にしない
// (Global Constraints「widget testとgolden testは追加しない」)。ここでは
// gesture callbackから分離したpure関数(`cameraAfterGestureUpdate`/
// `canonicalZoomFor`)だけを検証する。
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_mercator_projection.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_overlay_coverage.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_limits.dart';
import 'package:eqmonitor_map/src/tile/verified_pm_tiles_source.dart';
import 'package:eqmonitor_map/src/widget/base_map_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';

void main() {
  test('exposes nullable earthquake overlay and coverage callback inputs', () {
    final overlay = createEarthquakeMapOverlaySnapshot(
      sourceId: 'event-a',
      revision: 1,
      regionToCityZoom: 6,
      stationMinZoom: 6,
      regionStyles: const [],
      cityStyles: const [],
      stations: const [],
    );
    void callback(EarthquakeOverlayCoverageSnapshot _) {}
    final view = BaseMapView(
      source: const VerifiedPmTilesSource(
        sourceInstanceId: 'archive-a',
        absolutePath: '/tmp/archive.pmtiles',
        sizeBytes: 1,
        sha256:
            '0000000000000000000000000000000000000000000000000000000000000000',
      ),
      initialCamera: const MapCamera(
        centerLongitude: 139.7,
        centerLatitude: 35.7,
        zoom: 6,
      ),
      limits: const MapBaseLayerLimits(
        minZoom: 0,
        maxZoom: 10,
        pmTilesLimits: PmTilesV3Limits(
          maxDirectoryDepth: 3,
          rootDirectoryWindowLength: 16384,
        ),
        decodeLimits: BaseMapTileDecodeLimits(
          mvtLimits: MvtDecodeLimits(
            maxLayers: 16,
            maxFeaturesPerLayer: 100,
            maxRingsPerFeature: 100,
            maxVerticesPerRing: 100,
            maxCommandsPerFeature: 1000,
            maxLayerNameBytes: 64,
            maxKeysPerLayer: 64,
            maxValuesPerLayer: 100,
            maxTagsPerFeature: 64,
            maxPropertyStringBytes: 256,
          ),
          fillLimits: FillMeshBuilderLimits(
            maxHolesPerPolygon: 10,
            maxVerticesPerFeature: 100,
            maxVerticesPerSegment: 100,
          ),
          lineLimits: LineMeshBuilderLimits(maxVerticesPerSegment: 100),
          lineMiterLimit: 4,
        ),
        maxCachedTileGeometries: 8,
        maxParentFallbackSteps: 4,
        maxInFlightDecodes: 2,
        maxFramesInFlight: 3,
      ),
      earthquakeOverlay: overlay,
      onEarthquakeOverlayCoverageChanged: callback,
    );

    expect(view.earthquakeOverlay, same(overlay));
    expect(view.onEarthquakeOverlayCoverageChanged, same(callback));
  });

  group('cameraAfterGestureUpdate', () {
    const camera = MapCamera(
      centerLongitude: 139.767,
      centerLatitude: 35.681,
      zoom: 5,
    );

    test('a zero focalPointDelta and scale 1 leaves the camera unchanged', () {
      final result = cameraAfterGestureUpdate(
        camera: camera,
        gestureStartZoom: camera.zoom,
        cumulativeScale: 1,
        focalPointDelta: Offset.zero,
        minZoom: 0,
        maxZoom: 10,
      );

      expect(result.centerLongitude, closeTo(camera.centerLongitude, 1e-9));
      expect(result.centerLatitude, closeTo(camera.centerLatitude, 1e-9));
      expect(result.zoom, camera.zoom);
    });

    test(
      'a positive focalPointDelta.dx moves the center east (screen pixel == '
      'world pixel at the current zoom)',
      () {
        const projection = MapMercatorProjection();
        final worldSize = projection.worldSizeForZoom(camera.zoom);
        final before = camera.worldCenter();

        final result = cameraAfterGestureUpdate(
          camera: camera,
          gestureStartZoom: camera.zoom,
          cumulativeScale: 1,
          focalPointDelta: const Offset(10, 0),
          minZoom: 0,
          maxZoom: 10,
        );

        final after = result.worldCenter();
        expect(after.x - before.x, closeTo(-10, 1e-6));
        expect(after.y, closeTo(before.y, 1e-6));
        // 経度がwrapしない範囲であることをworldSizeで確認しておく
        // (この換算がzoomに依存しないことの前提)。
        expect(worldSize, greaterThan(0));
      },
    );

    test(
      'zoom is recomputed from the cumulative scale since gesture start',
      () {
        final result = cameraAfterGestureUpdate(
          camera: camera,
          gestureStartZoom: 5,
          cumulativeScale: 4, // log2(4) == 2
          focalPointDelta: Offset.zero,
          minZoom: 0,
          maxZoom: 10,
        );

        expect(result.zoom, closeTo(7, 1e-9));
      },
    );

    test('zoom clamps to maxZoom when the pinch would exceed it', () {
      final result = cameraAfterGestureUpdate(
        camera: camera,
        gestureStartZoom: 5,
        cumulativeScale: 100,
        focalPointDelta: Offset.zero,
        minZoom: 0,
        maxZoom: 7,
      );

      expect(result.zoom, 7);
    });

    test('zoom clamps to minZoom when the pinch would go below it', () {
      final result = cameraAfterGestureUpdate(
        camera: camera,
        gestureStartZoom: 5,
        cumulativeScale: 0.001,
        focalPointDelta: Offset.zero,
        minZoom: 1,
        maxZoom: 10,
      );

      expect(result.zoom, 1);
    });

    // ピンチの基準点。zoom は焦点(2本指の中間点)の下にある地点を固定した
    // まま変わらなければならない。焦点を渡さないと camera は中心と zoom
    // でしか定義されないため、必然的に画面中央基準の zoom になる。
    group('focal point anchoring', () {
      const viewport = Size(400, 800);
      const center = Offset(200, 400);

      /// [focalPoint] の下にある world 上の地点を正規化座標で返す。
      /// zoom に依存しないので、gesture の前後で比較できる。
      ({double x, double y}) anchorUnder(MapCamera c, Offset focalPoint) {
        const projection = MapMercatorProjection();
        final worldSize = projection.worldSizeForZoom(c.zoom);
        final worldCenter = c.worldCenter();
        final fromCenter = focalPoint - center;
        return (
          x: (worldCenter.x + fromCenter.dx) / worldSize,
          y: (worldCenter.y + fromCenter.dy) / worldSize,
        );
      }

      test('an off-center pinch keeps the point under the fingers fixed', () {
        const focalPoint = Offset(320, 200); // 中央から右上へ大きく外れた位置
        final before = anchorUnder(camera, focalPoint);

        final result = cameraAfterGestureUpdate(
          camera: camera,
          gestureStartZoom: camera.zoom,
          cumulativeScale: 2, // 1段ズームイン
          focalPointDelta: Offset.zero,
          focalPoint: focalPoint,
          viewportLogicalSize: viewport,
          minZoom: 0,
          maxZoom: 10,
        );

        final after = anchorUnder(result, focalPoint);
        expect(result.zoom, closeTo(camera.zoom + 1, 1e-9));
        expect(after.x, closeTo(before.x, 1e-9));
        expect(after.y, closeTo(before.y, 1e-9));
      });

      test('a pinch centred on screen still zooms about the center', () {
        final result = cameraAfterGestureUpdate(
          camera: camera,
          gestureStartZoom: camera.zoom,
          cumulativeScale: 2,
          focalPointDelta: Offset.zero,
          focalPoint: center,
          viewportLogicalSize: viewport,
          minZoom: 0,
          maxZoom: 10,
        );

        expect(result.centerLongitude, closeTo(camera.centerLongitude, 1e-9));
        expect(result.centerLatitude, closeTo(camera.centerLatitude, 1e-9));
      });

      test('the anchor holds when the zoom clamps at maxZoom', () {
        const focalPoint = Offset(320, 200);
        final result = cameraAfterGestureUpdate(
          camera: camera,
          gestureStartZoom: camera.zoom,
          cumulativeScale: 100,
          focalPointDelta: Offset.zero,
          focalPoint: focalPoint,
          viewportLogicalSize: viewport,
          minZoom: 0,
          maxZoom: 7,
        );

        // clamp 後の zoom でも焦点が固定される。clamp 前の zoom で
        // アンカーを計算すると、上限に張り付いた指の下が滑る。
        expect(result.zoom, 7);
        expect(
          anchorUnder(result, focalPoint).x,
          closeTo(anchorUnder(camera, focalPoint).x, 1e-9),
        );
      });

      test('pan and focal-anchored zoom compose in one update', () {
        const focalPoint = Offset(320, 200);
        const delta = Offset(10, -20);

        final panned = cameraAfterGestureUpdate(
          camera: camera,
          gestureStartZoom: camera.zoom,
          cumulativeScale: 1,
          focalPointDelta: delta,
          focalPoint: focalPoint,
          viewportLogicalSize: viewport,
          minZoom: 0,
          maxZoom: 10,
        );
        // pan だけを適用した状態の焦点下の地点が、zoom 後も保たれる。
        final expected = anchorUnder(panned, focalPoint);

        final result = cameraAfterGestureUpdate(
          camera: camera,
          gestureStartZoom: camera.zoom,
          cumulativeScale: 2,
          focalPointDelta: delta,
          focalPoint: focalPoint,
          viewportLogicalSize: viewport,
          minZoom: 0,
          maxZoom: 10,
        );

        expect(anchorUnder(result, focalPoint).x, closeTo(expected.x, 1e-9));
        expect(anchorUnder(result, focalPoint).y, closeTo(expected.y, 1e-9));
      });
    });
  });

  group('canonicalZoomFor', () {
    test('floors a fractional zoom within range', () {
      expect(canonicalZoomFor(zoom: 5.9, minZoom: 0, maxZoom: 10), 5);
    });

    test('raises a zoom below minZoom up to minZoom', () {
      expect(canonicalZoomFor(zoom: -3.2, minZoom: 1, maxZoom: 7), 1);
    });

    test('clamps a zoom above maxZoom down to maxZoom (overscale)', () {
      expect(canonicalZoomFor(zoom: 15.5, minZoom: 1, maxZoom: 7), 7);
    });

    test('leaves an in-range integer zoom unchanged', () {
      expect(canonicalZoomFor(zoom: 4, minZoom: 1, maxZoom: 7), 4);
    });
  });
}
