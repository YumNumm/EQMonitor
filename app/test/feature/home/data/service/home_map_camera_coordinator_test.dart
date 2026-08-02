import 'dart:async';

import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/service/home_map_camera_coordinator.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ShakeDetectionLevel;
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../map/data/service/map_automatic_focus_controller_test.mocks.dart';

final _now = DateTime.utc(2025, 1, 1, 12);

ShakeDetectionEvent _sampleShake({
  String? correlatedEewEventId,
  double minLat = 33,
  double maxLat = 34,
  double minLng = 130,
  double maxLng = 132,
}) => ShakeDetectionEvent(
  eventId: 'shake',
  serialNo: 1,
  createdAt: _now,
  updatedAt: _now,
  expiresAt: _now.add(const Duration(minutes: 1)),
  level: ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: minLat,
  maxLat: maxLat,
  minLng: minLng,
  maxLng: maxLng,
  changeReasons: const ['new_event'],
  correlatedEewEventId: correlatedEewEventId,
);

void stubCameraAnimations({
  required MockMapController controller,
  required Future<void> Function() animate,
}) {
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
  ).thenAnswer((_) => animate());
}

void main() {
  group('HomeMapCameraCoordinator', () {
    test('EEW focus用boundsだけでfocusする', () async {
      final coordinator = HomeMapCameraCoordinator();
      final controller = MockMapController();
      stubCameraAnimations(controller: controller, animate: () async {});

      await coordinator.setController(
        controller: controller,
        viewportSize: const Size(375, 667),
        home: Future.value(const HomeConfigurationModel()),
        eews: const [],
        shakes: const [],
      );
      clearInteractions(controller);
      final result = await coordinator.applyEewFocus(
        home: Future.value(const HomeConfigurationModel()),
        bounds: const LngLatBounds(
          longitudeWest: 141,
          longitudeEast: 143,
          latitudeSouth: 39,
          latitudeNorth: 41,
        ),
        generation: coordinator.nextCameraGeneration(),
        ignoreAutoZoom: false,
      );

      expect(result, isFalse);
      final center =
          verify(
                controller.animateCamera(
                  center: captureAnyNamed('center'),
                  zoom: anyNamed('zoom'),
                  bearing: 0,
                  pitch: 0,
                ),
              ).captured.single
              as Geographic;
      expect(center.lon, closeTo(142, 0.0001));
      verifyNoMoreInteractions(controller);
    });

    test('autoZoom無効時はEEW focusのcamera命令を出さない', () async {
      final coordinator = HomeMapCameraCoordinator();
      final controller = MockMapController();

      await coordinator.setController(
        controller: controller,
        viewportSize: const Size(375, 667),
        home: Future.value(
          const HomeConfigurationModel(eew: HomeEewSettings(autoZoom: false)),
        ),
        eews: const [],
        shakes: const [],
      );
      clearInteractions(controller);
      final result = await coordinator.applyEewFocus(
        home: Future.value(
          const HomeConfigurationModel(eew: HomeEewSettings(autoZoom: false)),
        ),
        bounds: const LngLatBounds(
          longitudeWest: 141,
          longitudeEast: 143,
          latitudeSouth: 39,
          latitudeNorth: 41,
        ),
        generation: coordinator.nextCameraGeneration(),
        ignoreAutoZoom: false,
      );

      expect(result, isNull);
      verifyNoMoreInteractions(controller);
    });

    test('autoZoom無効でも明示EEW refocusはcamera命令を出す', () async {
      final coordinator = HomeMapCameraCoordinator();
      final controller = MockMapController();
      const home = HomeConfigurationModel(
        eew: HomeEewSettings(autoZoom: false),
      );
      stubCameraAnimations(controller: controller, animate: () async {});

      await coordinator.setController(
        controller: controller,
        viewportSize: const Size(375, 667),
        home: Future.value(home),
        eews: const [],
        shakes: const [],
      );
      clearInteractions(controller);
      final result = await coordinator.applyEewFocus(
        home: Future.value(home),
        bounds: const LngLatBounds(
          longitudeWest: 141,
          longitudeEast: 143,
          latitudeSouth: 39,
          latitudeNorth: 41,
        ),
        generation: coordinator.nextCameraGeneration(),
        ignoreAutoZoom: true,
      );

      expect(result, isFalse);
      verify(
        controller.animateCamera(
          center: anyNamed('center'),
          zoom: anyNamed('zoom'),
          bearing: 0,
          pitch: 0,
        ),
      ).called(1);
      verifyNoMoreInteractions(controller);
    });

    test('controller切替後は新controllerへactual viewportでfocusする', () async {
      final coordinator = HomeMapCameraCoordinator();
      final oldController = MockMapController();
      final newController = MockMapController();
      final oldAnimation = Completer<void>();
      final newAnimation = Completer<void>();
      stubCameraAnimations(
        controller: oldController,
        animate: () => oldAnimation.future,
      );
      stubCameraAnimations(
        controller: newController,
        animate: () => newAnimation.future,
      );
      final shakes = [
        _sampleShake(minLat: 20, maxLat: 46, minLng: 120, maxLng: 154),
      ];

      final oldFocus = coordinator.setController(
        controller: oldController,
        viewportSize: const Size(375, 667),
        home: Future.value(const HomeConfigurationModel()),
        eews: const [],
        shakes: shakes,
      );
      await Future<void>.delayed(Duration.zero);
      final oldZoom =
          verify(
                oldController.animateCamera(
                  center: anyNamed('center'),
                  zoom: captureAnyNamed('zoom'),
                  bearing: 0,
                  pitch: 0,
                ),
              ).captured.single
              as double;

      final newFocus = coordinator.setController(
        controller: newController,
        viewportSize: const Size(667, 375),
        home: Future.value(const HomeConfigurationModel()),
        eews: const [],
        shakes: shakes,
      );
      await Future<void>.delayed(Duration.zero);
      final newZoom =
          verify(
                newController.animateCamera(
                  center: anyNamed('center'),
                  zoom: captureAnyNamed('zoom'),
                  bearing: 0,
                  pitch: 0,
                ),
              ).captured.single
              as double;
      expect(newZoom, greaterThan(oldZoom));

      newAnimation.complete();
      expect(await newFocus, isFalse);
      oldAnimation.complete();
      expect(await oldFocus, isNull);
      verifyNoMoreInteractions(oldController);
      verifyNoMoreInteractions(newController);
    });

    test('realtime fit中にtargetが消えたらHome cameraを最後に適用する', () async {
      final coordinator = HomeMapCameraCoordinator();
      final controller = MockMapController();
      final realtimeAnimation = Completer<void>();
      final homeAnimation = Completer<void>();
      var cameraCallCount = 0;
      stubCameraAnimations(
        controller: controller,
        animate: () {
          cameraCallCount += 1;
          return cameraCallCount == 1
              ? realtimeAnimation.future
              : homeAnimation.future;
        },
      );

      final initialFocus = coordinator.setController(
        controller: controller,
        viewportSize: const Size(375, 667),
        home: Future.value(const HomeConfigurationModel()),
        eews: const [],
        shakes: [
          _sampleShake(minLat: 35, maxLat: 36, minLng: 139, maxLng: 140),
        ],
      );
      await Future<void>.delayed(Duration.zero);
      expect(cameraCallCount, 1);

      final returnHome = coordinator.handleRealtimeTransition(
        home: Future.value(const HomeConfigurationModel()),
        eews: const [],
        shakes: const [],
      );
      await Future<void>.delayed(Duration.zero);
      expect(cameraCallCount, 1);

      realtimeAnimation.complete();
      expect(await initialFocus, isNull);
      await Future<void>.delayed(Duration.zero);
      expect(cameraCallCount, 2);

      homeAnimation.complete();
      expect(await returnHome, isTrue);
      final centers = verify(
        controller.animateCamera(
          center: captureAnyNamed('center'),
          zoom: anyNamed('zoom'),
          bearing: anyNamed('bearing'),
          pitch: anyNamed('pitch'),
          nativeDuration: anyNamed('nativeDuration'),
          webSpeed: anyNamed('webSpeed'),
          webMaxDuration: anyNamed('webMaxDuration'),
          padding: anyNamed('padding'),
        ),
      ).captured;
      expect((centers.first as Geographic).lon, 139.5);
      expect((centers.last as Geographic).lon, 137);
    });

    test('realtime fit中の明示Home復帰を最後に適用する', () async {
      final coordinator = HomeMapCameraCoordinator();
      final controller = MockMapController();
      final realtimeAnimation = Completer<void>();
      final homeAnimation = Completer<void>();
      var cameraCallCount = 0;
      stubCameraAnimations(
        controller: controller,
        animate: () {
          cameraCallCount += 1;
          return cameraCallCount == 1
              ? realtimeAnimation.future
              : homeAnimation.future;
        },
      );

      final initialFocus = coordinator.setController(
        controller: controller,
        viewportSize: const Size(375, 667),
        home: Future.value(const HomeConfigurationModel()),
        eews: const [],
        shakes: [
          _sampleShake(minLat: 35, maxLat: 36, minLng: 139, maxLng: 140),
        ],
      );
      await Future<void>.delayed(Duration.zero);
      expect(cameraCallCount, 1);

      final returnHome = coordinator.returnToHome(
        home: Future.value(const HomeConfigurationModel()),
      );
      await Future<void>.delayed(Duration.zero);
      expect(cameraCallCount, 1);

      realtimeAnimation.complete();
      expect(await initialFocus, isNull);
      await Future<void>.delayed(Duration.zero);
      expect(cameraCallCount, 2);

      homeAnimation.complete();
      expect(await returnHome, isTrue);
      final centers = verify(
        controller.animateCamera(
          center: captureAnyNamed('center'),
          zoom: anyNamed('zoom'),
          bearing: anyNamed('bearing'),
          pitch: anyNamed('pitch'),
          nativeDuration: anyNamed('nativeDuration'),
          webSpeed: anyNamed('webSpeed'),
          webMaxDuration: anyNamed('webMaxDuration'),
          padding: anyNamed('padding'),
        ),
      ).captured;
      expect((centers.first as Geographic).lon, 139.5);
      expect((centers.last as Geographic).lon, 137);
    });

    test('target消滅とcontroller切替が重なっても新controllerをHomeへ戻す', () async {
      final coordinator = HomeMapCameraCoordinator();
      final oldController = MockMapController();
      final newController = MockMapController();
      final oldRealtimeAnimation = Completer<void>();
      final newHomeAnimation = Completer<void>();
      var oldCameraCallCount = 0;
      stubCameraAnimations(
        controller: oldController,
        animate: () {
          oldCameraCallCount += 1;
          return oldCameraCallCount == 1
              ? Future<void>.value()
              : oldRealtimeAnimation.future;
        },
      );
      stubCameraAnimations(
        controller: newController,
        animate: () => newHomeAnimation.future,
      );

      expect(
        await coordinator.setController(
          controller: oldController,
          viewportSize: const Size(375, 667),
          home: Future.value(const HomeConfigurationModel()),
          eews: const [],
          shakes: [
            _sampleShake(minLat: 35, maxLat: 36, minLng: 139, maxLng: 140),
          ],
        ),
        isFalse,
      );
      final oldRealtime = coordinator.handleRealtimeTransition(
        home: Future.value(const HomeConfigurationModel()),
        eews: const [],
        shakes: [
          _sampleShake(minLat: 36, maxLat: 37, minLng: 140, maxLng: 141),
        ],
      );
      await Future<void>.delayed(Duration.zero);
      expect(oldCameraCallCount, 2);

      final oldHome = coordinator.handleRealtimeTransition(
        home: Future.value(const HomeConfigurationModel()),
        eews: const [],
        shakes: const [],
      );
      await Future<void>.delayed(Duration.zero);
      expect(oldCameraCallCount, 2);

      final newHome = coordinator.setController(
        controller: newController,
        viewportSize: const Size(667, 375),
        home: Future.value(const HomeConfigurationModel()),
        eews: const [],
        shakes: const [],
      );
      await Future<void>.delayed(Duration.zero);
      final newHomeCenter =
          verify(
                newController.animateCamera(
                  center: captureAnyNamed('center'),
                  zoom: anyNamed('zoom'),
                  bearing: 0,
                  pitch: 0,
                  nativeDuration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(4),
                ),
              ).captured.single
              as Geographic;
      expect(newHomeCenter.lon, 137);

      newHomeAnimation.complete();
      expect(await newHome, isTrue);
      oldRealtimeAnimation.complete();
      expect(await oldRealtime, isNull);
      expect(await oldHome, isNull);
      verify(
        oldController.animateCamera(
          center: anyNamed('center'),
          zoom: anyNamed('zoom'),
          bearing: 0,
          pitch: 0,
        ),
      ).called(2);
      verifyNoMoreInteractions(oldController);
      verifyNoMoreInteractions(newController);
    });
  });
}
