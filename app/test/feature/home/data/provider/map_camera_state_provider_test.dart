import 'dart:async';

import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/map_camera_state_provider.dart';
import 'package:eqmonitor/feature/home/data/service/home_map_camera_coordinator.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:test/test.dart';

import '../../../map/data/service/map_automatic_focus_controller_test.mocks.dart';

final _testShakesProvider =
    NotifierProvider<_TestShakes, List<ShakeDetectionEvent>>(_TestShakes.new);

class _TestShakes extends Notifier<List<ShakeDetectionEvent>> {
  @override
  List<ShakeDetectionEvent> build() => const [];

  void replace(List<ShakeDetectionEvent> value) {
    state = value;
  }
}

class _MutableEewAliveTelegram extends EewAliveTelegram {
  new(this.initial);

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

class _RecordingHomeMapCameraCoordinator extends HomeMapCameraCoordinator {
  bool? setControllerResult;
  Completer<bool?>? setControllerCompleter;
  bool? realtimeTransitionResult;
  bool? returnToHomeResult;
  var setControllerCallCount = 0;
  var realtimeTransitionCallCount = 0;
  var clearControllerCallCount = 0;
  var cancelAutomaticFocusCallCount = 0;
  var returnToHomeCallCount = 0;
  bool? receivedIgnoreAutoZoom;
  bool? receivedApplyInitialFocus;
  MapController? receivedController;
  Size? receivedViewportSize;
  List<EewTelegramItem> receivedEews = const [];
  List<ShakeDetectionEvent> receivedShakes = const [];

  @override
  Future<bool?> setController({
    required MapController controller,
    required Size viewportSize,
    required Future<HomeConfigurationModel> home,
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
    bool applyInitialFocus = true,
  }) async {
    await home;
    setControllerCallCount += 1;
    receivedController = controller;
    receivedViewportSize = viewportSize;
    receivedEews = eews;
    receivedShakes = shakes;
    receivedApplyInitialFocus = applyInitialFocus;
    final completer = setControllerCompleter;
    return completer == null ? setControllerResult : completer.future;
  }

  @override
  void clearController({required MapController controller}) {
    clearControllerCallCount += 1;
    receivedController = controller;
  }

  @override
  Future<bool?> handleRealtimeTransition({
    required Future<HomeConfigurationModel> home,
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
    bool ignoreAutoZoom = false,
  }) {
    realtimeTransitionCallCount += 1;
    receivedEews = eews;
    receivedShakes = shakes;
    receivedIgnoreAutoZoom = ignoreAutoZoom;
    return SynchronousFuture(realtimeTransitionResult);
  }

  @override
  void cancelAutomaticFocus() {
    cancelAutomaticFocusCallCount += 1;
  }

  @override
  Future<bool?> returnToHome({
    required Future<HomeConfigurationModel> home,
  }) async {
    await home;
    returnToHomeCallCount += 1;
    return returnToHomeResult;
  }
}

final _now = DateTime.utc(2025, 1, 1, 12);

EewTelegramItem _sampleEew({String eventId = '20250101120000'}) =>
    EewTelegramItem(
      eventId: eventId,
      status: TelegramStatus.normal,
      infoType: TelegramInfoType.publication,
      serialNo: 1,
      isCanceled: false,
      isLastInfo: false,
      reportTime: _now,
      isPlum: false,
      hypocenter: const EewHypocenterInfo(
        code: '101',
        name: '東京都',
        latitude: 35.5,
        longitude: 139.5,
      ),
    );

ShakeDetectionEvent _sampleShake() => ShakeDetectionEvent(
  eventId: 'shake',
  serialNo: 1,
  createdAt: _now,
  updatedAt: _now,
  expiresAt: _now.add(const Duration(minutes: 1)),
  level: ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
  changeReasons: const ['new_event'],
);

ProviderContainer _container({
  required _MutableEewAliveTelegram eews,
  required HomeMapCameraCoordinator coordinator,
}) {
  final container = ProviderContainer(
    overrides: [
      eewAliveTelegramProvider.overrideWith(() => eews),
      shakeDetectionVisibleProvider.overrideWith(
        (ref) => ref.watch(_testShakesProvider),
      ),
      homeConfigurationProvider.overrideWith(_StubHomeConfiguration.new),
      homeMapCameraCoordinatorProvider.overrideWithValue(coordinator),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('HomeMapCameraUpdateActionResolver.resolve', () {
    const resolver = HomeMapCameraUpdateActionResolver();

    test('realtime targetがありhomeならfitToRealtime', () {
      final action = resolver.resolve(hasRealtimeTargets: true, isAtHome: true);
      expect(action, HomeMapCameraUpdateAction.fitToRealtime);
    });

    test('realtime targetがなくhome外ならreturnToHome', () {
      final action = resolver.resolve(
        hasRealtimeTargets: false,
        isAtHome: false,
      );
      expect(action, HomeMapCameraUpdateAction.returnToHome);
    });

    test('realtime targetがなくhomeならnone', () {
      final action = resolver.resolve(
        hasRealtimeTargets: false,
        isAtHome: true,
      );
      expect(action, HomeMapCameraUpdateAction.none);
    });
  });

  group('HomeMapCameraState Provider wiring', () {
    test('setControllerをDIしたcoordinatorへ委譲し結果を公開する', () async {
      final eews = _MutableEewAliveTelegram([_sampleEew()]);
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..setControllerResult = false;
      final container = _container(eews: eews, coordinator: coordinator);
      final controller = MockMapController();

      await container
          .read(homeMapCameraStateProvider.notifier)
          .setController(
            controller: controller,
            viewportSize: const Size(375, 667),
          );

      expect(coordinator.setControllerCallCount, 1);
      expect(coordinator.receivedController, same(controller));
      expect(coordinator.receivedViewportSize, const Size(375, 667));
      expect(coordinator.receivedEews, hasLength(1));
      expect(container.read(homeMapCameraStateProvider).isAtHome, isFalse);
    });

    test('EEWと揺れ検知の購読更新をcoordinatorへ委譲する', () async {
      final eews = _MutableEewAliveTelegram(const []);
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..realtimeTransitionResult = false;
      final container = _container(eews: eews, coordinator: coordinator);
      container.read(homeMapCameraStateProvider);

      eews.replace([_sampleEew()]);
      await container.pump();
      expect(coordinator.realtimeTransitionCallCount, 1);
      expect(coordinator.receivedEews, hasLength(1));
      expect(container.read(homeMapCameraStateProvider).isAtHome, isFalse);

      coordinator.realtimeTransitionResult = true;
      container.read(_testShakesProvider.notifier).replace([_sampleShake()]);
      await container.pump();
      expect(container.read(shakeDetectionVisibleProvider), hasLength(1));
      expect(coordinator.realtimeTransitionCallCount, 2);
      expect(coordinator.receivedEews, hasLength(1));
      expect(coordinator.receivedShakes, hasLength(1));
      expect(container.read(homeMapCameraStateProvider).isAtHome, isTrue);
    });

    test('clearControllerをDIしたcoordinatorへ委譲する', () {
      final coordinator = _RecordingHomeMapCameraCoordinator();
      final container = _container(
        eews: _MutableEewAliveTelegram(const []),
        coordinator: coordinator,
      );
      final controller = MockMapController();

      container
          .read(homeMapCameraStateProvider.notifier)
          .clearController(controller: controller);

      expect(coordinator.clearControllerCallCount, 1);
      expect(coordinator.receivedController, same(controller));
    });

    test('EEWがない場合はHome復帰をcoordinatorへ委譲し結果を公開する', () async {
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..returnToHomeResult = true;
      final container = _container(
        eews: _MutableEewAliveTelegram(const []),
        coordinator: coordinator,
      );
      final notifier = container.read(homeMapCameraStateProvider.notifier);

      await notifier.returnToHome();

      expect(coordinator.returnToHomeCallCount, 1);
      expect(container.read(homeMapCameraStateProvider).isAtHome, isTrue);
    });

    test('EEWフォーカス中のユーザー操作はフォーカスを解除する', () async {
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..setControllerResult = false;
      final container = _container(
        eews: _MutableEewAliveTelegram([_sampleEew()]),
        coordinator: coordinator,
      );
      final notifier = container.read(homeMapCameraStateProvider.notifier);

      await notifier.setController(
        controller: MockMapController(),
        viewportSize: const Size(375, 667),
      );
      expect(
        container.read(homeMapCameraStateProvider).isEewFocusActive,
        isTrue,
      );

      notifier.handleUserMapGesture();

      expect(coordinator.cancelAutomaticFocusCallCount, 1);
      expect(
        container.read(homeMapCameraStateProvider).isEewFocusActive,
        isFalse,
      );
    });

    test('EEWフォーカスのカメラ移動中でもユーザー操作で解除できる', () async {
      final focusCompleter = Completer<bool?>();
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..setControllerCompleter = focusCompleter;
      final container = _container(
        eews: _MutableEewAliveTelegram([_sampleEew()]),
        coordinator: coordinator,
      );
      final notifier = container.read(homeMapCameraStateProvider.notifier);

      final focus = notifier.setController(
        controller: MockMapController(),
        viewportSize: const Size(375, 667),
      );
      await Future<void>.delayed(Duration.zero);
      expect(
        container.read(homeMapCameraStateProvider).isEewFocusActive,
        isTrue,
      );

      notifier.handleUserMapGesture();
      focusCompleter.complete(false);
      await focus;

      expect(coordinator.cancelAutomaticFocusCallCount, 1);
      expect(
        container.read(homeMapCameraStateProvider).isEewFocusActive,
        isFalse,
      );
    });

    test('フォーカス解除後は同じEEW更新を無視し、新規EEWで再開する', () async {
      final eews = _MutableEewAliveTelegram([_sampleEew()]);
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..setControllerResult = false
        ..realtimeTransitionResult = false;
      final container = _container(eews: eews, coordinator: coordinator);
      final notifier = container.read(homeMapCameraStateProvider.notifier);
      await notifier.setController(
        controller: MockMapController(),
        viewportSize: const Size(375, 667),
      );
      notifier.handleUserMapGesture();

      eews.replace([_sampleEew()]);
      await container.pump();
      expect(coordinator.realtimeTransitionCallCount, 0);
      expect(
        container.read(homeMapCameraStateProvider).isEewFocusActive,
        isFalse,
      );

      eews.replace([_sampleEew(), _sampleEew(eventId: 'new-event')]);
      await container.pump();
      expect(coordinator.realtimeTransitionCallCount, 1);
      expect(
        container.read(homeMapCameraStateProvider).isEewFocusActive,
        isTrue,
      );
    });

    test('フォーカス解除後のMap remountでは初期カメラ移動を要求しない', () async {
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..setControllerResult = false;
      final container = _container(
        eews: _MutableEewAliveTelegram([_sampleEew()]),
        coordinator: coordinator,
      );
      final notifier = container.read(homeMapCameraStateProvider.notifier);
      await notifier.setController(
        controller: MockMapController(),
        viewportSize: const Size(375, 667),
      );
      notifier.handleUserMapGesture();

      await notifier.setController(
        controller: MockMapController(),
        viewportSize: const Size(667, 375),
      );

      expect(coordinator.receivedApplyInitialFocus, isFalse);
      expect(
        container.read(homeMapCameraStateProvider).isEewFocusActive,
        isFalse,
      );
    });

    test('フォーカス解除後のHome操作はautoZoomを無視してEEWへ再フォーカスする', () async {
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..setControllerResult = false
        ..realtimeTransitionResult = false;
      final container = _container(
        eews: _MutableEewAliveTelegram([_sampleEew()]),
        coordinator: coordinator,
      );
      final notifier = container.read(homeMapCameraStateProvider.notifier);
      await notifier.setController(
        controller: MockMapController(),
        viewportSize: const Size(375, 667),
      );
      container.read(_testShakesProvider.notifier).replace([_sampleShake()]);
      container.read(shakeDetectionVisibleProvider);
      await container.pump();
      notifier.handleUserMapGesture();

      await notifier.returnToHome();

      expect(coordinator.returnToHomeCallCount, 0);
      expect(coordinator.receivedIgnoreAutoZoom, isTrue);
      expect(coordinator.receivedShakes, isEmpty);
      expect(
        container.read(homeMapCameraStateProvider).isEewFocusActive,
        isTrue,
      );
    });
  });
}
