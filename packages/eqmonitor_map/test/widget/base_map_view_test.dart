// `BaseMapView`本体はScene/gestureを含みwidget testの対象にしない
// (Global Constraints「widget testとgolden testは追加しない」)。ここでは
// gesture callbackから分離したpure関数(`cameraAfterGestureUpdate`/
// `canonicalZoomFor`)だけを検証する。
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_mercator_projection.dart';
import 'package:eqmonitor_map/src/widget/base_map_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
