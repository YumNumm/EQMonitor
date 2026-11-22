import 'dart:math' as math;

import 'package:eqmonitor/feature/map/data/service/map_automatic_focus_controller.dart';
import 'package:material_ui/material_ui.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'map_automatic_focus_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MapController>()])
void main() {
  const bounds = GeoBox(
    west: 139,
    east: 140,
    south: 35,
    north: 36,
  );

  group('mapAutomaticFocusTargetForBounds', () {
    test('狭いboundsはMercator中心とzoom上限のtargetになる', () {
      final target = MapAutomaticFocusController.targetForBounds(
        bounds: bounds,
        viewportSize: const Size(375, 667),
        padding: EdgeInsets.zero,
      );

      expect(target, isNotNull);
      expect(target?.center.lon, 139.5);
      expect(target?.center.lat, closeTo(35.5015, 0.0001));
      expect(target?.zoom, mapAutomaticFocusMaxZoom);
    });

    test('広いboundsはviewportへ収まるzoom上限未満のtargetになる', () {
      const wideBounds = GeoBox(
        west: 122.5,
        east: 146,
        south: 24,
        north: 46,
      );

      final target = MapAutomaticFocusController.targetForBounds(
        bounds: wideBounds,
        viewportSize: const Size(375, 667),
        padding: EdgeInsets.zero,
      );

      expect(target, isNotNull);
      expect(target?.zoom, lessThan(mapAutomaticFocusMaxZoom));
      expect(target?.zoom, greaterThanOrEqualTo(0));
      final zoom = target?.zoom;
      if (zoom == null) {
        throw StateError('target zoomが計算されませんでした');
      }
      final worldSize = 512 * math.pow(2, zoom);
      final longitudeSpanPixels =
          (wideBounds.east - wideBounds.west) /
          360 *
          worldSize;
      final latitudeSpanPixels =
          (MapAutomaticFocusController.mercatorY(
                    latitude: wideBounds.north,
                  ) -
                  MapAutomaticFocusController.mercatorY(
                    latitude: wideBounds.south,
                  ))
              .abs() /
          (2 * math.pi) *
          worldSize;
      expect(longitudeSpanPixels, lessThanOrEqualTo(375));
      expect(latitudeSpanPixels, lessThanOrEqualTo(667));
    });

    test('padding控除後のviewport幅が0ならtargetを作らない', () {
      final target = MapAutomaticFocusController.targetForBounds(
        bounds: bounds,
        viewportSize: const Size(100, 100),
        padding: const EdgeInsets.symmetric(horizontal: 50),
      );

      expect(target, isNull);
    });

    test('padding控除後のviewport高さが負ならtargetを作らない', () {
      final target = MapAutomaticFocusController.targetForBounds(
        bounds: bounds,
        viewportSize: const Size(100, 100),
        padding: const EdgeInsets.symmetric(vertical: 51),
      );

      expect(target, isNull);
    });

    test('緯度にNaNを含むboundsはtargetを作らない', () {
      final target = MapAutomaticFocusController.targetForBounds(
        bounds: const GeoBox(
          west: 139,
          east: 140,
          south: double.nan,
          north: 36,
        ),
        viewportSize: const Size(375, 667),
        padding: EdgeInsets.zero,
      );

      expect(target, isNull);
    });

    test('緯度に±Infinityを含むboundsはtargetを作らない', () {
      for (final invalidLatitude in [
        double.negativeInfinity,
        double.infinity,
      ]) {
        final target = MapAutomaticFocusController.targetForBounds(
          bounds: GeoBox(
            west: 139,
            east: 140,
            south: 35,
            north: invalidLatitude,
          ),
          viewportSize: const Size(375, 667),
          padding: EdgeInsets.zero,
        );

        expect(target, isNull);
      }
    });

    test('南端緯度が北端緯度を超えるboundsはtargetを作らない', () {
      final target = MapAutomaticFocusController.targetForBounds(
        bounds: const GeoBox(
          west: 139,
          east: 140,
          south: 36,
          north: 35,
        ),
        viewportSize: const Size(375, 667),
        padding: EdgeInsets.zero,
      );

      expect(target, isNull);
    });

    for (final (:name, :invalidBounds) in [
      (
        name: '南端緯度が-90未満',
        invalidBounds: const GeoBox(
          west: 139,
          east: 140,
          south: -90.1,
          north: 35,
        ),
      ),
      (
        name: '北端緯度が90超',
        invalidBounds: const GeoBox(
          west: 139,
          east: 140,
          south: 35,
          north: 90.1,
        ),
      ),
    ]) {
      test('$nameのboundsはtargetを作らない', () {
        final target = MapAutomaticFocusController.targetForBounds(
          bounds: invalidBounds,
          viewportSize: const Size(375, 667),
          padding: EdgeInsets.zero,
        );

        expect(target, isNull);
      });
    }

    for (final (:name, :invalidBounds) in [
      (
        name: '西端経度が-180未満',
        invalidBounds: const GeoBox(
          west: -180.1,
          east: 140,
          south: 35,
          north: 36,
        ),
      ),
      (
        name: '東端経度が180超',
        invalidBounds: const GeoBox(
          west: 139,
          east: 180.1,
          south: 35,
          north: 36,
        ),
      ),
      (
        name: '経度が非有限',
        invalidBounds: const GeoBox(
          west: 139,
          east: double.nan,
          south: 35,
          north: 36,
        ),
      ),
    ]) {
      test('$nameのboundsはtargetを作らない', () {
        final target = MapAutomaticFocusController.targetForBounds(
          bounds: invalidBounds,
          viewportSize: const Size(375, 667),
          padding: EdgeInsets.zero,
        );

        expect(target, isNull);
      });
    }

    test('日付変更線を横断する有効boundsはtargetを作る', () {
      final target = MapAutomaticFocusController.targetForBounds(
        bounds: const GeoBox(
          west: 170,
          east: -170,
          south: 35,
          north: 36,
        ),
        viewportSize: const Size(375, 667),
        padding: EdgeInsets.zero,
      );

      expect(target, isNotNull);
      expect(target?.center.lon, 180);
    });
  });

  group('MapAutomaticFocusController', () {
    test('事前計算したzoom上限のcameraを一度だけ送る', () async {
      final controller = MockMapController();
      when(
        controller.animateCamera(
          center: anyNamed('center'),
          zoom: anyNamed('zoom'),
          bearing: anyNamed('bearing'),
          pitch: anyNamed('pitch'),
          nativeDuration: anyNamed('nativeDuration'),
          webSpeed: anyNamed('webSpeed'),
          webMaxDuration: anyNamed('webMaxDuration'),
          padding: anyNamed('padding'),
        ),
      ).thenAnswer((_) async {});

      final result = await const MapAutomaticFocusController().fit(
        controller: controller,
        bounds: bounds,
        viewportSize: const Size(375, 667),
        isCurrent: () => true,
      );

      expect(result, isTrue);
      verify(
        controller.animateCamera(
          center: anyNamed('center'),
          zoom: mapAutomaticFocusMaxZoom,
          bearing: 0,
          pitch: 0,
          nativeDuration: const Duration(milliseconds: 500),
        ),
      ).called(1);
      verifyNoMoreInteractions(controller);
    });

    test('開始時にstaleならcameraへ触らない', () async {
      final controller = MockMapController();

      final result = await const MapAutomaticFocusController().fit(
        controller: controller,
        bounds: bounds,
        viewportSize: const Size(375, 667),
        isCurrent: () => false,
      );

      expect(result, isFalse);
      verifyNoMoreInteractions(controller);
    });

    test('移動直前にstaleならcameraへ触らない', () async {
      final controller = MockMapController();
      var guardCallCount = 0;

      final result = await const MapAutomaticFocusController().fit(
        controller: controller,
        bounds: bounds,
        viewportSize: const Size(375, 667),
        isCurrent: () => ++guardCallCount == 1,
      );

      expect(result, isFalse);
      expect(guardCallCount, 2);
      verifyNoMoreInteractions(controller);
    });

    test('利用可能viewportがなければcamera命令を出さない', () async {
      final controller = MockMapController();

      final result = await const MapAutomaticFocusController().fit(
        controller: controller,
        bounds: bounds,
        viewportSize: const Size(100, 100),
        padding: const EdgeInsets.all(50),
        isCurrent: () => true,
      );

      expect(result, isFalse);
      verifyNoMoreInteractions(controller);
    });

    test('非有限緯度のboundsではcamera命令を出さない', () async {
      final controller = MockMapController();

      for (final invalidLatitude in [
        double.nan,
        double.negativeInfinity,
        double.infinity,
      ]) {
        final result = await const MapAutomaticFocusController().fit(
          controller: controller,
          bounds: GeoBox(
            west: 139,
            east: 140,
            south: 35,
            north: invalidLatitude,
          ),
          viewportSize: const Size(375, 667),
          isCurrent: () => true,
        );

        expect(result, isFalse);
      }
      verifyNoMoreInteractions(controller);
    });

    for (final (:name, :invalidBounds) in [
      (
        name: '南北緯度が逆転した',
        invalidBounds: const GeoBox(
          west: 139,
          east: 140,
          south: 36,
          north: 35,
        ),
      ),
      (
        name: '緯度が範囲外の',
        invalidBounds: const GeoBox(
          west: 139,
          east: 140,
          south: -91,
          north: 35,
        ),
      ),
      (
        name: '経度が範囲外の',
        invalidBounds: const GeoBox(
          west: 139,
          east: 181,
          south: 35,
          north: 36,
        ),
      ),
      (
        name: '経度が非有限の',
        invalidBounds: const GeoBox(
          west: double.infinity,
          east: 140,
          south: 35,
          north: 36,
        ),
      ),
    ]) {
      test('$name boundsではcamera命令を出さない', () async {
        final controller = MockMapController();

        final result = await const MapAutomaticFocusController().fit(
          controller: controller,
          bounds: invalidBounds,
          viewportSize: const Size(375, 667),
          isCurrent: () => true,
        );

        expect(result, isFalse);
        verifyNoMoreInteractions(controller);
      });
    }

    test('日付変更線を横断する有効boundsではcamera命令を出す', () async {
      final controller = MockMapController();
      when(
        controller.animateCamera(
          center: anyNamed('center'),
          zoom: anyNamed('zoom'),
          bearing: anyNamed('bearing'),
          pitch: anyNamed('pitch'),
          nativeDuration: anyNamed('nativeDuration'),
          webSpeed: anyNamed('webSpeed'),
          webMaxDuration: anyNamed('webMaxDuration'),
          padding: anyNamed('padding'),
        ),
      ).thenAnswer((_) async {});

      final result = await const MapAutomaticFocusController().fit(
        controller: controller,
        bounds: const GeoBox(
          west: 170,
          east: -170,
          south: 35,
          north: 36,
        ),
        viewportSize: const Size(375, 667),
        isCurrent: () => true,
      );

      expect(result, isTrue);
      final center =
          verify(
                controller.animateCamera(
                  center: captureAnyNamed('center'),
                  zoom: anyNamed('zoom'),
                  bearing: 0,
                  pitch: 0,
                  nativeDuration: const Duration(milliseconds: 500),
                ),
              ).captured.single
              as Geographic;
      expect(center.lon, 180);
      verifyNoMoreInteractions(controller);
    });
  });
}
