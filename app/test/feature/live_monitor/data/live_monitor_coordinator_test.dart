import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_display_state.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_settings.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_control_panel_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_coordinator.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_detected_event_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _now = DateTime.utc(2026, 7, 27);

final class _StubDetectedEvents extends LiveMonitorDetectedEventNotifier {
  @override
  Future<LiveMonitorEventEnvelope?> build() async => null;
}

final class _MutableSettings extends LiveMonitorSettingsNotifier {
  new(this.initial);

  final LiveMonitorSettings initial;

  @override
  Future<LiveMonitorSettings> build() async => initial;

  void publish(LiveMonitorSettings value) => state = AsyncData(value);
}

final class _MutableAppClock extends AppClock {
  new(this.current);

  DateTime current;

  @override
  TimeMode build() => const TimeMode.realtime();

  @override
  DateTime now() => current;
}

final class _CoordinatorFixture {
  new({
    required this.container,
    required this.detectedEvents,
    required this.settings,
    required this.clock,
  });

  final ProviderContainer container;
  final _StubDetectedEvents detectedEvents;
  final _MutableSettings settings;
  final _MutableAppClock clock;

  LiveMonitorDisplayState get display =>
      container.read(liveMonitorCoordinatorProvider);

  void emit(LiveMonitorDetectedEvent event) => detectedEvents.publish(event);

  void setSettings(LiveMonitorSettings value) => settings.publish(value);
}

void main() {
  test('split中は地震イベントでPaneを入れ替えずtimerも持たない', () {
    fakeAsync((async) {
      final fixture = createFixture(
        settings: const LiveMonitorSettings(displayMode: .split),
      );
      addTearDown(fixture.container.dispose);
      async.flushMicrotasks();
      startCoordinator(fixture);
      final baselineTimers = async.pendingTimers.toSet();

      fixture.emit(earthquakeEvent(eventId: 'Q'));

      expect(fixture.display, const LiveMonitorDisplayState.realtime());
      expect(async.pendingTimers.toSet(), baselineTimers);
    });
  });

  test('automatic中の地震イベントは設定秒数だけ地震表示を予約する', () {
    fakeAsync((async) {
      final fixture = createFixture(
        settings: const LiveMonitorSettings(earthquakeDisplaySeconds: 12),
      );
      addTearDown(fixture.container.dispose);
      async.flushMicrotasks();
      startCoordinator(fixture);
      final baselineTimers = async.pendingTimers.toSet();

      fixture.emit(earthquakeEvent(eventId: 'Q'));

      final display = fixture.display as LiveMonitorEarthquakeDisplayState;
      expect(display.eventId, 'Q');
      expect(display.expiresAt, _now.add(const Duration(seconds: 12)));
      expect(
        async.pendingTimers.toSet().difference(baselineTimers),
        hasLength(1),
      );
    });
  });

  test('automatic中の新規EEWはパネルを閉じて即時realtimeへ戻す', () {
    fakeAsync((async) {
      final fixture = createFixture();
      addTearDown(fixture.container.dispose);
      async.flushMicrotasks();
      startCoordinator(fixture);
      final baselineTimers = async.pendingTimers.toSet();
      fixture.emit(earthquakeEvent(eventId: 'Q'));
      final displayTimer = async.pendingTimers
          .toSet()
          .difference(baselineTimers)
          .single;
      fixture.container.read(liveMonitorControlPanelProvider.notifier).open();

      fixture.emit(
        const LiveMonitorDetectedEvent.eewStarted(eventId: 'E', serialNo: 1),
      );

      expect(fixture.container.read(liveMonitorControlPanelProvider), isFalse);
      expect(fixture.display, const LiveMonitorDisplayState.realtime());
      expect(displayTimer.isActive, isFalse);
    });
  });

  test('split中も新規EEWを購読してパネルを閉じる', () {
    final fixture = createFixture(
      settings: const LiveMonitorSettings(displayMode: .split),
    );
    addTearDown(fixture.container.dispose);
    return fixture.container.read(liveMonitorSettingsProvider.future).then((_) {
      startCoordinator(fixture);
      fixture.container.read(liveMonitorControlPanelProvider.notifier).open();

      fixture.emit(
        const LiveMonitorDetectedEvent.eewStarted(eventId: 'E', serialNo: 1),
      );

      expect(fixture.container.read(liveMonitorControlPanelProvider), isFalse);
      expect(fixture.display, const LiveMonitorDisplayState.realtime());
    });
  });

  test('automaticからsplitへの変更は古いdeadlineを取消す', () {
    fakeAsync((async) {
      final fixture = createFixture();
      addTearDown(fixture.container.dispose);
      async.flushMicrotasks();
      startCoordinator(fixture);
      final baselineTimers = async.pendingTimers.toSet();
      fixture.emit(earthquakeEvent(eventId: 'Q'));
      final displayTimer = async.pendingTimers
          .toSet()
          .difference(baselineTimers)
          .single;

      fixture.setSettings(const LiveMonitorSettings(displayMode: .split));
      async.elapse(const Duration(seconds: 30));

      expect(fixture.display, const LiveMonitorDisplayState.realtime());
      expect(displayTimer.isActive, isFalse);
    });
  });

  test('splitからautomaticへの変更はrealtimeから開始する', () async {
    final fixture = createFixture(
      settings: const LiveMonitorSettings(displayMode: .split),
    );
    addTearDown(fixture.container.dispose);
    await fixture.container.read(liveMonitorSettingsProvider.future);
    startCoordinator(fixture);
    fixture.emit(earthquakeEvent(eventId: 'Q'));

    fixture.setSettings(const LiveMonitorSettings());

    expect(fixture.display, const LiveMonitorDisplayState.realtime());
  });

  test('deadline発火時は現在時刻で再評価してrealtimeへ戻す', () {
    fakeAsync((async) {
      final fixture = createFixture();
      addTearDown(fixture.container.dispose);
      async.flushMicrotasks();
      startCoordinator(fixture);
      fixture.emit(earthquakeEvent(eventId: 'Q'));

      fixture.clock.current = _now.add(const Duration(seconds: 10));
      async.elapse(const Duration(seconds: 10));

      expect(fixture.display, const LiveMonitorDisplayState.realtime());
      expect(async.pendingTimers, isEmpty);
    });
  });

  test('同じsequenceの再通知は表示期限を作り直さない', () {
    fakeAsync((async) {
      final fixture = createFixture();
      addTearDown(fixture.container.dispose);
      async.flushMicrotasks();
      startCoordinator(fixture);
      final baselineTimers = async.pendingTimers.toSet();
      final envelope = LiveMonitorEventEnvelope(
        sequence: 1,
        event: earthquakeEvent(eventId: 'Q'),
      );

      fixture.detectedEvents.state = AsyncData(envelope);
      final displayTimer = async.pendingTimers
          .toSet()
          .difference(baselineTimers)
          .single;
      fixture.clock.current = _now.add(const Duration(seconds: 1));
      fixture.detectedEvents.state = AsyncData(envelope);

      final display = fixture.display as LiveMonitorEarthquakeDisplayState;
      expect(display.shownAt, _now);
      expect(displayTimer.isActive, isTrue);
      expect(async.pendingTimers.toSet().difference(baselineTimers), {
        displayTimer,
      });
    });
  });
}

_CoordinatorFixture createFixture({
  LiveMonitorSettings settings = const LiveMonitorSettings(),
}) {
  final detectedEvents = _StubDetectedEvents();
  final mutableSettings = _MutableSettings(settings);
  final appClock = _MutableAppClock(_now);
  final container = ProviderContainer(
    overrides: [
      liveMonitorDetectedEventProvider.overrideWith(() => detectedEvents),
      liveMonitorSettingsProvider.overrideWith(() => mutableSettings),
      appClockProvider.overrideWith(() => appClock),
    ],
  );
  container.read(liveMonitorSettingsProvider);
  return _CoordinatorFixture(
    container: container,
    detectedEvents: detectedEvents,
    settings: mutableSettings,
    clock: appClock,
  );
}

void startCoordinator(_CoordinatorFixture fixture) {
  fixture.container.listen(
    liveMonitorCoordinatorProvider,
    (_, _) {},
    fireImmediately: true,
  );
}

LiveMonitorDetectedEvent earthquakeEvent({required String eventId}) =>
    LiveMonitorDetectedEvent.earthquakeUpsert(
      eventId: eventId,
      trigger: LiveMonitorEarthquakeTrigger.telegram(
        kind: .vxse53,
        reportedAt: _now,
      ),
      earthquake: Earthquake(
        eventId: eventId,
        status: TelegramStatus.normal,
        originTime: _now,
        originTimePrecision: OriginTimePrecision.second,
        arrivalTime: _now,
        dataSources: const [],
        telegramTypes: const [],
        hypocenter: null,
        intensity: null,
        estimatedIntensityTileUrl: null,
      ),
    );
