import 'dart:async';

import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/map_camera_state_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../map/data/service/map_automatic_focus_controller_test.mocks.dart';

final _testShakesProvider =
    NotifierProvider<_TestShakes, List<ShakeDetectionEvent>>(_TestShakes.new);

class _TestShakes extends Notifier<List<ShakeDetectionEvent>> {
  @override
  List<ShakeDetectionEvent> build() => const [];
}

class _MutableEewAliveTelegram extends EewAliveTelegram {
  _MutableEewAliveTelegram(this.initial);

  final List<EewTelegramItem> initial;

  @override
  List<EewTelegramItem> build() => initial;

  void replace(List<EewTelegramItem> value) {
    state = value;
  }
}

class _StubHomeConfiguration extends HomeConfigurationNotifier {
  @override
  Future<HomeConfigurationModel> build() async =>
      const HomeConfigurationModel();
}

EewTelegramItem _sampleEew() => EewTelegramItem(
  eventId: '20250101120000',
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: DateTime.utc(2025, 1, 1, 12),
  isPlum: false,
  hypocenter: const EewHypocenterInfo(
    code: '101',
    name: '東京都',
    latitude: 35.5,
    longitude: 139.5,
  ),
);

ProviderContainer _container({required _MutableEewAliveTelegram eews}) {
  final container = ProviderContainer(
    overrides: [
      eewAliveTelegramProvider.overrideWith(() => eews),
      shakeDetectionVisibleProvider.overrideWith(
        (ref) => ref.watch(_testShakesProvider),
      ),
      homeConfigurationProvider.overrideWith(_StubHomeConfiguration.new),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('resolveHomeMapCameraUpdateAction', () {
    test('realtime targetがありhomeならfitToRealtime', () {
      final action = resolveHomeMapCameraUpdateAction(
        hasRealtimeTargets: true,
        isAtHome: true,
      );
      expect(action, HomeMapCameraUpdateAction.fitToRealtime);
    });

    test('realtime targetがなくhome外ならreturnToHome', () {
      final action = resolveHomeMapCameraUpdateAction(
        hasRealtimeTargets: false,
        isAtHome: false,
      );
      expect(action, HomeMapCameraUpdateAction.returnToHome);
    });

    test('realtime targetがなくhomeならnone', () {
      final action = resolveHomeMapCameraUpdateAction(
        hasRealtimeTargets: false,
        isAtHome: true,
      );
      expect(action, HomeMapCameraUpdateAction.none);
    });
  });

  group('HomeMapCameraState camera race', () {
    test('controller切替後は新controllerへactual viewportでfocusする', () async {
      final eews = _MutableEewAliveTelegram([_sampleEew()]);
      final container = _container(eews: eews);
      final oldController = MockMapController();
      final newController = MockMapController();
      final oldAnimation = Completer<void>();
      final newAnimation = Completer<void>();
      when(
        oldController.animateCamera(
          center: anyNamed('center'),
          zoom: anyNamed('zoom'),
          bearing: anyNamed('bearing'),
          pitch: anyNamed('pitch'),
          nativeDuration: anyNamed('nativeDuration'),
          webSpeed: anyNamed('webSpeed'),
          webMaxDuration: anyNamed('webMaxDuration'),
          padding: anyNamed('padding'),
        ),
      ).thenAnswer((_) => oldAnimation.future);
      when(
        newController.animateCamera(
          center: anyNamed('center'),
          zoom: anyNamed('zoom'),
          bearing: anyNamed('bearing'),
          pitch: anyNamed('pitch'),
          nativeDuration: anyNamed('nativeDuration'),
          webSpeed: anyNamed('webSpeed'),
          webMaxDuration: anyNamed('webMaxDuration'),
          padding: anyNamed('padding'),
        ),
      ).thenAnswer((_) => newAnimation.future);
      final notifier = container.read(homeMapCameraStateProvider.notifier);

      final oldFocus = notifier.setController(
        oldController,
        viewportSize: const Size(375, 667),
      );
      await container.pump();
      verify(
        oldController.animateCamera(
          center: anyNamed('center'),
          zoom: 8,
          bearing: 0,
          pitch: 0,
        ),
      ).called(1);

      final newFocus = notifier.setController(
        newController,
        viewportSize: const Size(667, 375),
      );
      await container.pump();
      verify(
        newController.animateCamera(
          center: anyNamed('center'),
          zoom: 8,
          bearing: 0,
          pitch: 0,
        ),
      ).called(1);

      newAnimation.complete();
      await newFocus;
      oldAnimation.complete();
      await oldFocus;

      expect(container.read(homeMapCameraStateProvider).isAtHome, isFalse);
      verifyNoMoreInteractions(oldController);
      verifyNoMoreInteractions(newController);
    });

    test('realtime fit中にtargetが消えたらHome cameraを最後に適用する', () async {
      final eews = _MutableEewAliveTelegram([_sampleEew()]);
      final container = _container(eews: eews);
      final controller = MockMapController();
      final realtimeAnimation = Completer<void>();
      final homeAnimation = Completer<void>();
      var cameraCallCount = 0;
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
      ).thenAnswer((_) {
        cameraCallCount += 1;
        return cameraCallCount == 1
            ? realtimeAnimation.future
            : homeAnimation.future;
      });
      final notifier = container.read(homeMapCameraStateProvider.notifier);

      final initialFocus = notifier.setController(
        controller,
        viewportSize: const Size(375, 667),
      );
      await container.pump();
      expect(cameraCallCount, 1);

      eews.replace(const []);
      await container.pump();
      expect(cameraCallCount, 1);

      realtimeAnimation.complete();
      await initialFocus;
      await container.pump();
      expect(cameraCallCount, 2);

      homeAnimation.complete();
      await container.pump();
      expect(container.read(homeMapCameraStateProvider).isAtHome, isTrue);
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
      final eews = _MutableEewAliveTelegram([_sampleEew()]);
      final container = _container(eews: eews);
      final controller = MockMapController();
      final realtimeAnimation = Completer<void>();
      final homeAnimation = Completer<void>();
      var cameraCallCount = 0;
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
      ).thenAnswer((_) {
        cameraCallCount += 1;
        return cameraCallCount == 1
            ? realtimeAnimation.future
            : homeAnimation.future;
      });
      final notifier = container.read(homeMapCameraStateProvider.notifier);

      final initialFocus = notifier.setController(
        controller,
        viewportSize: const Size(375, 667),
      );
      await container.pump();
      expect(cameraCallCount, 1);

      final returnHome = notifier.returnToHome();
      await container.pump();
      expect(cameraCallCount, 1);

      realtimeAnimation.complete();
      await initialFocus;
      await container.pump();
      expect(cameraCallCount, 2);

      homeAnimation.complete();
      await returnHome;
      expect(container.read(homeMapCameraStateProvider).isAtHome, isTrue);
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
  });
}
