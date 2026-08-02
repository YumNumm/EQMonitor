import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/eew_map_focus.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/map_camera_state_provider.dart';
import 'package:eqmonitor/feature/home/data/service/home_map_camera_coordinator.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ShakeDetectionLevel;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

class _MutableShakeDetection extends ShakeDetection {
  _MutableShakeDetection(this.initial);

  final List<ShakeDetectionEvent> initial;

  @override
  List<ShakeDetectionEvent> build() => initial;

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
  var eewFocusCallCount = 0;
  var clearControllerCallCount = 0;
  var returnToHomeCallCount = 0;
  MapController? receivedController;
  Size? receivedViewportSize;
  List<EewTelegramItem> receivedEews = const [];
  List<ShakeDetectionEvent> receivedShakes = const [];
  LngLatBounds? receivedEewBounds;
  bool? receivedIgnoreAutoZoom;
  bool? receivedApplyInitialFocus;
  bool? receivedIsAtHome;

  @override
  Future<bool?> setController({
    required MapController controller,
    required Size viewportSize,
    required Future<HomeConfigurationModel> home,
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
    bool applyInitialFocus = true,
    bool isAtHome = false,
  }) async {
    await home;
    setControllerCallCount += 1;
    receivedController = controller;
    receivedViewportSize = viewportSize;
    receivedEews = eews;
    receivedShakes = shakes;
    receivedApplyInitialFocus = applyInitialFocus;
    receivedIsAtHome = isAtHome;
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

  @override
  int nextCameraGeneration() => 1;

  @override
  Future<bool?> applyEewFocus({
    required Future<HomeConfigurationModel> home,
    required LngLatBounds bounds,
    required int generation,
    required bool ignoreAutoZoom,
  }) async {
    await home;
    eewFocusCallCount += 1;
    receivedEewBounds = bounds;
    receivedIgnoreAutoZoom = ignoreAutoZoom;
    return realtimeTransitionResult;
  }
}

final _now = DateTime.utc(2025, 1, 1, 12);

EewTelegramItem _sampleEew({
  String eventId = '20250101120000',
  DateTime? reportTime,
  double latitude = 35.5,
  double longitude = 139.5,
}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: reportTime ?? _now,
  isPlum: false,
  hypocenter: EewHypocenterInfo(
    code: '101',
    name: '東京都',
    latitude: latitude,
    longitude: longitude,
  ),
);

/// 震源要素を持たない PLUM 相当の EEW。
EewTelegramItem _plumEew({String eventId = 'plum'}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: _now,
  isPlum: true,
);

ShakeDetectionEvent _sampleShake({
  String? correlatedEewEventId,
  double minLat = 35,
  double maxLat = 36,
  double minLng = 139,
  double maxLng = 140,
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

ProviderContainer _container({
  required _MutableEewAliveTelegram eews,
  required _MutableShakeDetection allShakes,
  required HomeMapCameraCoordinator coordinator,
}) {
  final container = ProviderContainer(
    overrides: [
      eewAliveTelegramProvider.overrideWith(() => eews),
      shakeDetectionProvider.overrideWith(() => allShakes),
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
      final allShakes = _MutableShakeDetection(const []);
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..setControllerResult = false;
      final container = _container(
        eews: eews,
        allShakes: allShakes,
        coordinator: coordinator,
      );
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
      expect(coordinator.receivedEews, isEmpty);
      expect(container.read(homeMapCameraStateProvider).isAtHome, isFalse);
    });

    test('controller attach時はhome適用のためhome外として再評価する', () async {
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..realtimeTransitionResult = true;
      final container = _container(
        eews: _MutableEewAliveTelegram(const []),
        allShakes: _MutableShakeDetection(const []),
        coordinator: coordinator,
      );
      final controller = MockMapController();

      await container
          .read(homeMapCameraStateProvider.notifier)
          .setController(
            controller: controller,
            viewportSize: const Size(375, 667),
          );

      expect(coordinator.receivedApplyInitialFocus, isFalse);
      expect(coordinator.receivedIsAtHome, isFalse);
      expect(coordinator.realtimeTransitionCallCount, 1);
      expect(container.read(homeMapCameraStateProvider).isAtHome, isTrue);
    });

    test('EEW更新はfocused EEW boundsだけをcoordinatorへ委譲する', () async {
      final eews = _MutableEewAliveTelegram(const []);
      final allShakes = _MutableShakeDetection([
        _sampleShake(
          correlatedEewEventId: 'new',
          minLat: 40,
          maxLat: 41,
          minLng: 141,
          maxLng: 143,
        ),
        _sampleShake(minLat: 30, maxLat: 31, minLng: 130, maxLng: 131),
      ]);
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..realtimeTransitionResult = false;
      final container = _container(
        eews: eews,
        allShakes: allShakes,
        coordinator: coordinator,
      );
      container.read(homeMapCameraStateProvider);

      eews.replace([
        _sampleEew(eventId: 'old', reportTime: _now),
        _sampleEew(
          eventId: 'new',
          reportTime: _now.add(const Duration(seconds: 1)),
          latitude: 40,
          longitude: 142,
        ),
      ]);
      await container.pump();

      expect(coordinator.eewFocusCallCount, 1);
      expect(coordinator.realtimeTransitionCallCount, 0);
      expect(coordinator.receivedEewBounds?.longitudeWest, greaterThan(140));
      expect(coordinator.receivedIgnoreAutoZoom, isFalse);
      expect(container.read(eewMapFocusProvider).focusedEventId, 'new');
      expect(container.read(homeMapCameraStateProvider).isAtHome, isFalse);
    });

    test('EEWなしの揺れ検知更新は既存realtime経路へ委譲する', () async {
      final eews = _MutableEewAliveTelegram(const []);
      final allShakes = _MutableShakeDetection(const []);
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..realtimeTransitionResult = true;
      final container = _container(
        eews: eews,
        allShakes: allShakes,
        coordinator: coordinator,
      );
      container.read(homeMapCameraStateProvider);

      final visibleShake = _sampleShake();
      allShakes.replace([visibleShake]);
      await container.pump();
      // 生データと表示対象の双方を監視しているため、それぞれで遷移が走る。
      expect(coordinator.realtimeTransitionCallCount, 1);

      container.read(_testShakesProvider.notifier).replace([visibleShake]);
      // Dart 単体の ProviderContainer では派生 provider の再計算が遅延するため、
      // 明示的に読み出して listener へ伝播させる。
      container.read(shakeDetectionVisibleProvider);
      await container.pump();

      expect(coordinator.realtimeTransitionCallCount, 2);
      expect(coordinator.eewFocusCallCount, 0);
      expect(coordinator.receivedEews, isEmpty);
      expect(coordinator.receivedShakes, hasLength(1));
      expect(container.read(homeMapCameraStateProvider).isAtHome, isTrue);
    });

    test('表示対象の期限切れ（visibleのみ変化）でもrealtime経路が走る', () async {
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..realtimeTransitionResult = true;
      final container = _container(
        eews: _MutableEewAliveTelegram(const []),
        allShakes: _MutableShakeDetection([_sampleShake()]),
        coordinator: coordinator,
      );
      container.read(homeMapCameraStateProvider);
      container.read(_testShakesProvider.notifier).replace([_sampleShake()]);
      container.read(shakeDetectionVisibleProvider);
      await container.pump();
      final baseline = coordinator.realtimeTransitionCallCount;

      // 期限切れで表示対象から消えるケース（生データは変化しない）
      container.read(_testShakesProvider.notifier).replace(const []);
      container.read(shakeDetectionVisibleProvider);
      await container.pump();

      expect(coordinator.realtimeTransitionCallCount, baseline + 1);
      expect(coordinator.receivedShakes, isEmpty);
    });

    test('remount（setController）は生存EEWへ強制的に再フォーカスする', () async {
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..setControllerResult = false
        ..realtimeTransitionResult = false;
      final container = _container(
        eews: _MutableEewAliveTelegram([_sampleEew(eventId: 'event')]),
        allShakes: _MutableShakeDetection(const []),
        coordinator: coordinator,
      );
      // ユーザー操作でフォーカス解除済みの状態から remount する。
      container.read(eewMapFocusProvider.notifier)
        ..sync()
        ..clearFocus();
      expect(container.read(eewMapFocusProvider).isFocused, isFalse);

      await container
          .read(homeMapCameraStateProvider.notifier)
          .setController(
            controller: MockMapController(),
            viewportSize: const Size(375, 667),
          );

      expect(coordinator.eewFocusCallCount, 1);
      expect(coordinator.realtimeTransitionCallCount, 0);
      expect(container.read(eewMapFocusProvider).isFocused, isTrue);
      expect(container.read(eewMapFocusProvider).hasAppliedFocus, isTrue);
    });

    test('fitが実行されなければappliedを進めずホームボタンを有効に保つ', () async {
      final coordinator = _RecordingHomeMapCameraCoordinator();
      final container = _container(
        eews: _MutableEewAliveTelegram([_sampleEew(eventId: 'event')]),
        allShakes: _MutableShakeDetection(const []),
        coordinator: coordinator,
      );

      // autoZoom 無効などで fit されなかった場合は null が返る。
      await container
          .read(homeMapCameraStateProvider.notifier)
          .handleRealtimeTransition();

      expect(coordinator.eewFocusCallCount, 1);
      expect(container.read(eewMapFocusProvider).isFocused, isTrue);
      expect(container.read(eewMapFocusProvider).hasAppliedFocus, isFalse);
    });

    test('fitできる対象が無いEEWではホーム復帰へフォールバックする', () async {
      final coordinator = _RecordingHomeMapCameraCoordinator()
        ..returnToHomeResult = true;
      final container = _container(
        eews: _MutableEewAliveTelegram([_plumEew()]),
        allShakes: _MutableShakeDetection(const []),
        coordinator: coordinator,
      );

      await container.read(homeMapCameraStateProvider.notifier).returnToHome();

      expect(coordinator.eewFocusCallCount, 0);
      expect(coordinator.returnToHomeCallCount, 1);
      expect(container.read(eewMapFocusProvider).hasAppliedFocus, isFalse);
      expect(container.read(homeMapCameraStateProvider).isAtHome, isTrue);
    });

    test('clearControllerをDIしたcoordinatorへ委譲する', () {
      final coordinator = _RecordingHomeMapCameraCoordinator();
      final container = _container(
        eews: _MutableEewAliveTelegram(const []),
        allShakes: _MutableShakeDetection(const []),
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
        ..realtimeTransitionResult = false
        ..returnToHomeResult = true;
      final container = _container(
        eews: _MutableEewAliveTelegram([_sampleEew()]),
        allShakes: _MutableShakeDetection(const []),
        coordinator: coordinator,
      );
      final notifier = container.read(homeMapCameraStateProvider.notifier);

      await notifier.returnToHome();

      expect(coordinator.returnToHomeCallCount, 0);
      expect(coordinator.eewFocusCallCount, 1);
      expect(coordinator.receivedIgnoreAutoZoom, isTrue);
      expect(container.read(homeMapCameraStateProvider).isAtHome, isFalse);
    });
  });
}
