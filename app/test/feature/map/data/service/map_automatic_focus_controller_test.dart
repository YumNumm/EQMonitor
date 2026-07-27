import 'dart:async';
import 'dart:math' as math;

import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_map_instance_owner.dart';
import 'package:eqmonitor/feature/map/data/service/map_automatic_focus_controller.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'map_automatic_focus_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MapController>()])
void main() {
  const bounds = LngLatBounds(
    longitudeWest: 139,
    longitudeEast: 140,
    latitudeSouth: 35,
    latitudeNorth: 36,
  );

  group('mapAutomaticFocusTargetForBounds', () {
    test('狭いboundsはMercator中心とzoom 8のtargetになる', () {
      final target = mapAutomaticFocusTargetForBounds(
        bounds: bounds,
        viewportSize: const Size(375, 667),
        padding: EdgeInsets.zero,
      );

      expect(target, isNotNull);
      expect(target?.center.lon, 139.5);
      expect(target?.center.lat, closeTo(35.5015, 0.0001));
      expect(target?.zoom, 8);
    });

    test('広いboundsはviewportへ収まるzoom 8未満のtargetになる', () {
      const wideBounds = LngLatBounds(
        longitudeWest: 122.5,
        longitudeEast: 146,
        latitudeSouth: 24,
        latitudeNorth: 46,
      );

      final target = mapAutomaticFocusTargetForBounds(
        bounds: wideBounds,
        viewportSize: const Size(375, 667),
        padding: EdgeInsets.zero,
      );

      expect(target, isNotNull);
      expect(target?.zoom, lessThan(8));
      expect(target?.zoom, greaterThanOrEqualTo(0));
      final zoom = target?.zoom;
      if (zoom == null) {
        throw StateError('target zoomが計算されませんでした');
      }
      final worldSize = 512 * math.pow(2, zoom);
      final longitudeSpanPixels =
          (wideBounds.longitudeEast - wideBounds.longitudeWest) /
          360 *
          worldSize;
      final latitudeSpanPixels =
          (mapAutomaticFocusMercatorY(latitude: wideBounds.latitudeNorth) -
                  mapAutomaticFocusMercatorY(
                    latitude: wideBounds.latitudeSouth,
                  ))
              .abs() /
          (2 * math.pi) *
          worldSize;
      expect(longitudeSpanPixels, lessThanOrEqualTo(375));
      expect(latitudeSpanPixels, lessThanOrEqualTo(667));
    });

    test('padding控除後のviewport幅が0ならtargetを作らない', () {
      final target = mapAutomaticFocusTargetForBounds(
        bounds: bounds,
        viewportSize: const Size(100, 100),
        padding: const EdgeInsets.symmetric(horizontal: 50),
      );

      expect(target, isNull);
    });

    test('padding控除後のviewport高さが負ならtargetを作らない', () {
      final target = mapAutomaticFocusTargetForBounds(
        bounds: bounds,
        viewportSize: const Size(100, 100),
        padding: const EdgeInsets.symmetric(vertical: 51),
      );

      expect(target, isNull);
    });

    test('緯度にNaNを含むboundsはtargetを作らない', () {
      final target = mapAutomaticFocusTargetForBounds(
        bounds: const LngLatBounds(
          longitudeWest: 139,
          longitudeEast: 140,
          latitudeSouth: double.nan,
          latitudeNorth: 36,
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
        final target = mapAutomaticFocusTargetForBounds(
          bounds: LngLatBounds(
            longitudeWest: 139,
            longitudeEast: 140,
            latitudeSouth: 35,
            latitudeNorth: invalidLatitude,
          ),
          viewportSize: const Size(375, 667),
          padding: EdgeInsets.zero,
        );

        expect(target, isNull);
      }
    });
  });

  group('MapAutomaticFocusController', () {
    test('事前計算したzoom 8のcameraを一度だけ送る', () async {
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
          zoom: 8,
          bearing: 0,
          pitch: 0,
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
          bounds: LngLatBounds(
            longitudeWest: 139,
            longitudeEast: 140,
            latitudeSouth: 35,
            latitudeNorth: invalidLatitude,
          ),
          viewportSize: const Size(375, 667),
          isCurrent: () => true,
        );

        expect(result, isFalse);
      }
      verifyNoMoreInteractions(controller);
    });

    test('LiveMonitor instance切替後は旧controllerを再参照しない', () async {
      final controller = MockMapController();
      final animation = Completer<void>();
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
      ).thenAnswer((_) => animation.future);
      final owner = LiveMonitorMapInstanceOwner<MapController>();
      final identity = owner.switchInstance();
      expect(
        owner.acceptController(identity: identity, controller: controller),
        isTrue,
      );
      final operation = owner.beginCameraOperation(
        identity: identity,
        controller: controller,
      );
      if (operation == null) {
        throw StateError('current controllerのcamera operationが作成されませんでした');
      }

      final resultFuture = const MapAutomaticFocusController().fit(
        controller: controller,
        bounds: bounds,
        viewportSize: const Size(375, 667),
        isCurrent: () => owner.acceptCameraCompletion(operation),
      );
      verify(
        controller.animateCamera(
          center: anyNamed('center'),
          zoom: 8,
          bearing: 0,
          pitch: 0,
        ),
      ).called(1);

      owner.switchInstance();
      animation.complete();

      expect(await resultFuture, isFalse);
      verifyNoMoreInteractions(controller);
    });
  });
}
