import 'dart:async';

import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/service/home_map_camera_coordinator.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:material_ui/material_ui.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../map/data/service/camera_update_matcher.dart';
import '../../../map/data/service/map_automatic_focus_controller_test.mocks.dart';

final _now = DateTime.utc(2025, 1, 1, 12);

EewTelegramItem _sampleEew({
  String eventId = '20250101120000',
  double latitude = 35.5,
  double longitude = 139.5,
}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: _now,
  isPlum: false,
  hypocenter: EewHypocenterInfo(
    code: '101',
    name: '東京都',
    latitude: latitude,
    longitude: longitude,
  ),
);

ShakeDetectionEvent _sampleShake({
  double minLat = 33,
  double maxLat = 34,
  double minLng = 130,
  double maxLng = 132,
}) => ShakeDetectionEvent(
  eventId: 'shake',
  createdAt: _now,
  updatedAt: _now,
  expiresAt: _now.add(const Duration(minutes: 1)),
  level: ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: minLat,
  maxLat: maxLat,
  minLng: minLng,
  maxLng: maxLng,
);

void stubCameraAnimations({
  required MockMapController controller,
  required Future<void> Function() animate,
}) {
  when(
    controller.animateCamera(
      any,
      animation: anyNamed('animation'),
    ),
  ).thenAnswer((_) async {
    await animate();
    return CameraAnimationResult.completed;
  });
}

void main() {
  group('HomeMapCameraCoordinator', () {
    test('EEWと未結合揺れ検知を合わせた範囲へfocusする', () async {
      final coordinator = HomeMapCameraCoordinator();
      final controller = MockMapController();
      stubCameraAnimations(controller: controller, animate: () async {});

      final result = await coordinator.setController(
        controller: controller,
        viewportSize: const Size(375, 667),
        home: Future.value(const HomeConfigurationModel()),
        eews: [_sampleEew(latitude: 40, longitude: 142)],
        shakes: [_sampleShake()],
      );

      expect(result, isFalse);
      final center =
          verify(
                controller.animateCamera(
                  captureThat(
                    isCameraPositionUpdate(
                      bearing: 0,
                      pitch: 0,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  animation: const CameraAnimation.fly(
                    duration: Duration(milliseconds: 500),
                  ),
                ),
              ).captured.single
              as CameraUpdatePosition;
      expect(center.center?.lon, closeTo(136, 0.0001));
      verifyNoMoreInteractions(controller);
    });

    test('autoZoom無効時はrealtime targetへcamera命令を出さない', () async {
      final coordinator = HomeMapCameraCoordinator();
      final controller = MockMapController();

      final result = await coordinator.setController(
        controller: controller,
        viewportSize: const Size(375, 667),
        home: Future.value(
          const HomeConfigurationModel(eew: HomeEewSettings(autoZoom: false)),
        ),
        eews: [_sampleEew()],
        shakes: const [],
      );

      expect(result, isNull);
      verifyNoMoreInteractions(controller);
    });

    test('autoZoom無効でも明示Home復帰はcamera命令を出す', () async {
      final coordinator = HomeMapCameraCoordinator();
      final controller = MockMapController();
      const home = HomeConfigurationModel(
        eew: HomeEewSettings(autoZoom: false),
      );

      await coordinator.setController(
        controller: controller,
        viewportSize: const Size(375, 667),
        home: Future.value(home),
        eews: [_sampleEew()],
        shakes: const [],
      );
      stubCameraAnimations(controller: controller, animate: () async {});
      final result = await coordinator.returnToHome(home: Future.value(home));

      expect(result, isTrue);
      verify(
        controller.animateCamera(
          argThat(
            isCameraPositionUpdate(
              bearing: 0,
              pitch: 0,
              padding: const EdgeInsets.all(4),
            ),
          ),
          animation: const CameraAnimation.fly(
            duration: Duration(milliseconds: 200),
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(controller);
    });

    test('autoZoom無効でも明示EEW再フォーカスはcamera命令を出す', () async {
      final coordinator = HomeMapCameraCoordinator();
      final controller = MockMapController();
      const home = HomeConfigurationModel(
        eew: HomeEewSettings(autoZoom: false),
      );

      await coordinator.setController(
        controller: controller,
        viewportSize: const Size(375, 667),
        home: Future.value(home),
        eews: [_sampleEew()],
        shakes: const [],
      );
      stubCameraAnimations(controller: controller, animate: () async {});

      final result = await coordinator.handleRealtimeTransition(
        home: Future.value(home),
        eews: [_sampleEew()],
        shakes: const [],
        ignoreAutoZoom: true,
      );

      expect(result, isFalse);
      verify(
        controller.animateCamera(
          argThat(
            isCameraPositionUpdate(
              bearing: 0,
              pitch: 0,
              padding: EdgeInsets.zero,
            ),
          ),
          animation: const CameraAnimation.fly(
            duration: Duration(milliseconds: 500),
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(controller);
    });

    test('初期フォーカス無効のcontroller登録はcamera命令を出さない', () async {
      final coordinator = HomeMapCameraCoordinator();
      final controller = MockMapController();

      final result = await coordinator.setController(
        controller: controller,
        viewportSize: const Size(375, 667),
        home: Future.value(const HomeConfigurationModel()),
        eews: [_sampleEew()],
        shakes: const [],
        applyInitialFocus: false,
      );

      expect(result, isNull);
      verifyNoMoreInteractions(controller);
    });

    test('フォーカスcancel後は進行中のcamera結果を適用しない', () async {
      final coordinator = HomeMapCameraCoordinator();
      final controller = MockMapController();
      final animation = Completer<void>();
      stubCameraAnimations(
        controller: controller,
        animate: () => animation.future,
      );

      final focus = coordinator.setController(
        controller: controller,
        viewportSize: const Size(375, 667),
        home: Future.value(const HomeConfigurationModel()),
        eews: [_sampleEew()],
        shakes: const [],
      );
      await Future<void>.delayed(Duration.zero);

      coordinator.cancelAutomaticFocus();
      animation.complete();

      expect(await focus, isNull);
      verify(
        controller.animateCamera(
          argThat(
            isCameraPositionUpdate(
              bearing: 0,
              pitch: 0,
              padding: EdgeInsets.zero,
            ),
          ),
          animation: const CameraAnimation.fly(
            duration: Duration(milliseconds: 500),
          ),
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
                  captureThat(
                    isCameraPositionUpdate(
                      bearing: 0,
                      pitch: 0,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  animation: const CameraAnimation.fly(
                    duration: Duration(milliseconds: 500),
                  ),
                ),
              ).captured.single
              as CameraUpdatePosition;

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
                  captureThat(
                    isCameraPositionUpdate(
                      bearing: 0,
                      pitch: 0,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  animation: const CameraAnimation.fly(
                    duration: Duration(milliseconds: 500),
                  ),
                ),
              ).captured.single
              as CameraUpdatePosition;
      expect(newZoom.zoom, greaterThan(oldZoom.zoom ?? double.infinity));

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
        eews: [_sampleEew()],
        shakes: const [],
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
          captureAny,
          animation: anyNamed('animation'),
        ),
      ).captured;
      expect((centers.first as CameraUpdatePosition).center?.lon, 139.5);
      expect((centers.last as CameraUpdatePosition).center?.lon, 137);
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
        eews: [_sampleEew()],
        shakes: const [],
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
          captureAny,
          animation: anyNamed('animation'),
        ),
      ).captured;
      expect((centers.first as CameraUpdatePosition).center?.lon, 139.5);
      expect((centers.last as CameraUpdatePosition).center?.lon, 137);
    });

    test('同じ範囲へのrealtime focusはカメラを動かし直さない', () async {
      final coordinator = HomeMapCameraCoordinator();
      final controller = MockMapController();
      var cameraCallCount = 0;
      stubCameraAnimations(
        controller: controller,
        animate: () {
          cameraCallCount += 1;
          return Future<void>.value();
        },
      );
      final home = Future.value(const HomeConfigurationModel());

      expect(
        await coordinator.setController(
          controller: controller,
          viewportSize: const Size(375, 667),
          home: home,
          eews: const [],
          shakes: [_sampleShake()],
        ),
        isFalse,
      );
      expect(cameraCallCount, 1);

      expect(
        await coordinator.handleRealtimeTransition(
          home: home,
          eews: const [],
          shakes: [_sampleShake(minLat: 33.1, maxLng: 131.9)],
        ),
        isFalse,
      );
      expect(cameraCallCount, 1);

      expect(
        await coordinator.handleRealtimeTransition(
          home: home,
          eews: const [],
          shakes: [_sampleShake(maxLat: 37)],
        ),
        isFalse,
      );
      expect(cameraCallCount, 2);

      coordinator.cancelAutomaticFocus();
      expect(
        await coordinator.handleRealtimeTransition(
          home: home,
          eews: const [],
          shakes: [_sampleShake(maxLat: 37)],
        ),
        isFalse,
      );
      expect(cameraCallCount, 3);
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
          eews: [_sampleEew()],
          shakes: const [],
        ),
        isFalse,
      );
      final oldRealtime = coordinator.handleRealtimeTransition(
        home: Future.value(const HomeConfigurationModel()),
        eews: [_sampleEew(eventId: '20250101120001', latitude: 37.5)],
        shakes: const [],
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
                  captureThat(
                    isCameraPositionUpdate(
                      bearing: 0,
                      pitch: 0,
                      padding: const EdgeInsets.all(4),
                    ),
                  ),
                  animation: const CameraAnimation.fly(
                    duration: Duration(milliseconds: 200),
                  ),
                ),
              ).captured.single
              as CameraUpdatePosition;
      expect(newHomeCenter.center?.lon, 137);

      newHomeAnimation.complete();
      expect(await newHome, isTrue);
      oldRealtimeAnimation.complete();
      expect(await oldRealtime, isNull);
      expect(await oldHome, isNull);
      verify(
        oldController.animateCamera(
          argThat(
            isCameraPositionUpdate(
              bearing: 0,
              pitch: 0,
              padding: EdgeInsets.zero,
            ),
          ),
          animation: const CameraAnimation.fly(
            duration: Duration(milliseconds: 500),
          ),
        ),
      ).called(2);
      verifyNoMoreInteractions(oldController);
      verifyNoMoreInteractions(newController);
    });
  });
}
