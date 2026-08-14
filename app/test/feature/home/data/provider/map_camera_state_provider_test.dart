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

class _RecordingHomeMapCameraCoordinator extends HomeMapCameraCoordinator {
  bool? setControllerResult;
  bool? realtimeTransitionResult;
  bool? returnToHomeResult;
  var setControllerCallCount = 0;
  var realtimeTransitionCallCount = 0;
  var clearControllerCallCount = 0;
  var returnToHomeCallCount = 0;
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
  }) async {
    await home;
    setControllerCallCount += 1;
    receivedController = controller;
    receivedViewportSize = viewportSize;
    receivedEews = eews;
    receivedShakes = shakes;
    return setControllerResult;
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
  }) {
    realtimeTransitionCallCount += 1;
    receivedEews = eews;
    receivedShakes = shakes;
    return SynchronousFuture(realtimeTransitionResult);
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

EewTelegramItem _sampleEew() => EewTelegramItem(
  eventId: '20250101120000',
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

    test('Home復帰をcoordinatorへ委譲し結果を公開する', () async {
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..setControllerResult = false
        ..returnToHomeResult = true;
      final container = _container(
        eews: _MutableEewAliveTelegram([_sampleEew()]),
        coordinator: coordinator,
      );
      final notifier = container.read(homeMapCameraStateProvider.notifier);

      await notifier.setController(
        controller: MockMapController(),
        viewportSize: const Size(375, 667),
      );
      expect(container.read(homeMapCameraStateProvider).isAtHome, isFalse);

      await notifier.returnToHome();

      expect(coordinator.returnToHomeCallCount, 1);
      expect(container.read(homeMapCameraStateProvider).isAtHome, isTrue);
    });
  });
}
