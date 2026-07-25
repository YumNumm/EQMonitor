import 'dart:async';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_state.dart';
import 'package:eqmonitor/feature/eew/data/notifier/eew_warning_overlay_notifier.dart';
import 'package:eqmonitor/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_warning_overlay_display_provider.dart';
import 'package:eqmonitor/feature/eew/data/service/eew_warning_overlay_scheduler.dart';
import 'package:eqmonitor/feature/eew/data/service/eew_warning_overlay_vibration_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

final mutableRealDisplayProvider =
    NotifierProvider<MutableRealDisplay, EewWarningOverlayDisplayModel?>(
      MutableRealDisplay.new,
    );

final class MutableRealDisplay
    extends Notifier<EewWarningOverlayDisplayModel?> {
  MutableRealDisplay([this.initial]);

  final EewWarningOverlayDisplayModel? initial;

  @override
  EewWarningOverlayDisplayModel? build() => initial;

  void publish(EewWarningOverlayDisplayModel? model) => state = model;
}

final class MutableAppLifecycle extends AppLifecycle {
  MutableAppLifecycle({this.initial = AppLifecycleState.resumed});

  final AppLifecycleState initial;

  @override
  AppLifecycleState build() => initial;

  void publish(AppLifecycleState value) => state = value;
}

final class FakeScheduledTask implements EewWarningOverlayScheduledTask {
  FakeScheduledTask({required this.delay, required this.callback});

  final Duration delay;
  final Future<void> Function() callback;
  bool isCancelled = false;
  bool hasRun = false;

  @override
  void cancel() => isCancelled = true;
}

final class FakeScheduler implements EewWarningOverlayScheduler {
  final tasks = <FakeScheduledTask>[];

  int get activeTaskCount =>
      tasks.where((task) => !task.isCancelled && !task.hasRun).length;

  @override
  EewWarningOverlayScheduledTask schedule({
    required Duration delay,
    required Future<void> Function() callback,
  }) {
    final task = FakeScheduledTask(delay: delay, callback: callback);
    tasks.add(task);
    return task;
  }

  Future<void> elapse(Duration duration) async {
    final due = tasks.where(
      (task) => !task.isCancelled && !task.hasRun && task.delay <= duration,
    );
    for (final task in due.toList(growable: false)) {
      task.hasRun = true;
      await task.callback();
    }
  }
}

final class FakeVibrationGateway implements EewWarningOverlayVibrationGateway {
  FakeVibrationGateway({this.startBarrier});

  final Completer<void>? startBarrier;
  int startCalls = 0;
  int cancelCalls = 0;

  @override
  Future<bool> hasVibrator() async {
    await startBarrier?.future;
    return true;
  }

  @override
  Future<bool> hasCustomVibrationsSupport() async => true;

  @override
  Future<void> vibrate({required List<int> pattern}) async {
    startCalls += 1;
  }

  @override
  Future<void> vibrateOnce({required int durationMs}) async {
    startCalls += 1;
  }

  @override
  Future<void> cancel() async {
    cancelCalls += 1;
  }
}

final class TestContext {
  TestContext({
    required this.container,
    required this.real,
    required this.lifecycle,
    required this.scheduler,
    required this.vibration,
  });

  final ProviderContainer container;
  final MutableRealDisplay real;
  final MutableAppLifecycle lifecycle;
  final FakeScheduler scheduler;
  final FakeVibrationGateway vibration;

  EewWarningOverlayState get state =>
      container.read(eewWarningOverlayNotifierProvider);

  Future<void> publishReal(EewWarningOverlayDisplayModel? model) async {
    real.publish(model);
    await container.pump();
    await Future<void>.delayed(Duration.zero);
  }

  Future<void> publishLifecycle(AppLifecycleState value) async {
    lifecycle.publish(value);
    await container.pump();
    await Future<void>.delayed(Duration.zero);
  }

  Future<void> settle() async {
    await scheduler.elapse(Duration.zero);
    await container.pump();
    await Future<void>.delayed(Duration.zero);
  }
}

TestContext createContext({
  AppLifecycleState lifecycleState = AppLifecycleState.resumed,
  EewWarningOverlayDisplayModel? initialDisplay,
  FakeVibrationGateway? vibrationGateway,
}) {
  final real = MutableRealDisplay(initialDisplay);
  final lifecycle = MutableAppLifecycle(initial: lifecycleState);
  final scheduler = FakeScheduler();
  final vibration = vibrationGateway ?? FakeVibrationGateway();
  final container = ProviderContainer(
    overrides: [
      mutableRealDisplayProvider.overrideWith(() => real),
      eewWarningOverlayDisplayProvider.overrideWith(
        (ref) => ref.watch(mutableRealDisplayProvider),
      ),
      appLifecycleProvider.overrideWith(() => lifecycle),
      eewWarningOverlaySchedulerProvider.overrideWithValue(scheduler),
      eewWarningOverlayVibrationServiceProvider.overrideWithValue(
        EewWarningOverlayVibrationService(gateway: vibration, talker: Talker()),
      ),
    ],
  );
  container.listen(
    eewWarningOverlayNotifierProvider,
    (_, _) {},
    fireImmediately: true,
  );
  return TestContext(
    container: container,
    real: real,
    lifecycle: lifecycle,
    scheduler: scheduler,
    vibration: vibration,
  );
}

EewWarningOverlayDisplayModel display({
  required List<String> eventIds,
  int serialNo = 1,
}) => EewWarningOverlayDisplayModel(
  source: EewWarningOverlaySource.real,
  eventIds: eventIds,
  representativeEventId: eventIds.first,
  serialNo: serialNo,
  alertCount: eventIds.length,
  reportLabel: '第$serialNo報',
  hypocenterHeadline: 'テスト震源で地震',
  strongMotionHeadline: 'テスト地域で強い揺れ',
  currentRegionName: 'テスト地域',
  localIntensity: JmaIntensity.sixLower,
  localIntensityIsOver: false,
  arrivalState: EewWarningArrivalState.unarrived,
  secondsUntilArrival: 10,
  hypocenterName: 'テスト震源',
  magnitude: 6,
  depth: 10,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('新しい実警報は全画面と振動を開始し10秒後に最小化する', () async {
    final context = createContext();
    addTearDown(context.container.dispose);

    expect(context.state.mode, EewWarningOverlayMode.hidden);
    await context.publishReal(display(eventIds: ['A']));

    expect(context.state.mode, EewWarningOverlayMode.fullscreen);
    expect(context.state.seenEventIds, {'A'});
    expect(context.vibration.startCalls, 1);
    expect(context.scheduler.activeTaskCount, 1);

    await context.scheduler.elapse(const Duration(seconds: 10));

    expect(context.state.mode, EewWarningOverlayMode.minimized);
    expect(context.vibration.cancelCalls, 1);
  });

  test('provider構築前から有効な実警報も初回購読時に通知する', () async {
    final context = createContext(initialDisplay: display(eventIds: ['A']));
    addTearDown(context.container.dispose);
    await context.settle();

    expect(context.state.mode, EewWarningOverlayMode.fullscreen);
    expect(context.state.seenEventIds, {'A'});
    expect(context.vibration.startCalls, 1);
  });

  test('同一eventIdの内容更新では再通知せず新しいeventId追加時だけ再通知する', () async {
    final context = createContext();
    addTearDown(context.container.dispose);
    await context.publishReal(display(eventIds: ['A']));

    await context.publishReal(display(eventIds: ['A'], serialNo: 2));

    expect(context.state.displayModel?.serialNo, 2);
    expect(context.vibration.startCalls, 1);
    expect(context.vibration.cancelCalls, 0);
    expect(context.scheduler.tasks, hasLength(1));

    await context.publishReal(display(eventIds: ['A', 'B']));

    expect(context.state.mode, EewWarningOverlayMode.fullscreen);
    expect(context.state.seenEventIds, {'A', 'B'});
    expect(context.vibration.startCalls, 2);
    expect(context.scheduler.tasks, hasLength(2));
  });

  test('振動開始中の同一eventId更新も振動を途中停止しない', () async {
    final startBarrier = Completer<void>();
    final context = createContext(
      vibrationGateway: FakeVibrationGateway(startBarrier: startBarrier),
    );
    addTearDown(context.container.dispose);

    context.real.publish(display(eventIds: ['A']));
    await Future<void>.delayed(Duration.zero);
    context.real.publish(display(eventIds: ['A'], serialNo: 2));
    await context.container.pump();
    expect(context.state.displayModel?.serialNo, 2);
    startBarrier.complete();
    await context.settle();

    expect(context.state.displayModel?.serialNo, 2);
    expect(context.vibration.startCalls, 1);
    expect(context.vibration.cancelCalls, 0);
  });

  test('closeは有効群をdismissし新規Cだけ再開条件にする', () async {
    final context = createContext();
    addTearDown(context.container.dispose);
    await context.publishReal(display(eventIds: ['A', 'B']));

    await context.container
        .read(eewWarningOverlayNotifierProvider.notifier)
        .close();
    expect(context.state.mode, EewWarningOverlayMode.hidden);
    expect(context.state.dismissedEventIds, {'A', 'B'});

    await context.publishReal(display(eventIds: ['A', 'B'], serialNo: 2));
    expect(context.state.mode, EewWarningOverlayMode.hidden);

    await context.publishReal(display(eventIds: ['A', 'B', 'C']));
    expect(context.state.mode, EewWarningOverlayMode.fullscreen);
    expect(context.vibration.startCalls, 2);

    await context.publishReal(display(eventIds: ['A', 'B']));
    expect(context.state.mode, EewWarningOverlayMode.hidden);
    expect(context.state.displayModel, isNull);
  });

  test('手動最小化と再展開はtimerと振動を再開しない', () async {
    final context = createContext();
    addTearDown(context.container.dispose);
    await context.publishReal(display(eventIds: ['A']));
    final notifier = context.container.read(
      eewWarningOverlayNotifierProvider.notifier,
    );

    await notifier.minimize();
    expect(context.state.mode, EewWarningOverlayMode.minimized);
    expect(context.scheduler.activeTaskCount, 0);

    notifier.expand();
    expect(context.state.mode, EewWarningOverlayMode.fullscreen);
    expect(context.vibration.startCalls, 1);
    expect(context.scheduler.tasks, hasLength(1));

    await context.scheduler.elapse(const Duration(seconds: 10));
    expect(context.state.mode, EewWarningOverlayMode.fullscreen);
  });

  test('対象消失でhiddenになり既知eventIdの再進入は最小表示にする', () async {
    final context = createContext();
    addTearDown(context.container.dispose);
    await context.publishReal(display(eventIds: ['A']));

    await context.publishReal(null);
    expect(context.state.mode, EewWarningOverlayMode.hidden);
    expect(context.state.displayModel, isNull);

    await context.publishReal(display(eventIds: ['A'], serialNo: 2));
    expect(context.state.mode, EewWarningOverlayMode.minimized);
    expect(context.state.displayModel?.serialNo, 2);
    expect(context.vibration.startCalls, 1);
  });

  test('設定無効相当で実警報がeffectiveから消えてもsimulationは表示できる', () async {
    final context = createContext();
    addTearDown(context.container.dispose);

    context.container
        .read(eewWarningOverlaySimulationProvider.notifier)
        .start();
    await context.settle();

    expect(context.state.mode, EewWarningOverlayMode.fullscreen);
    expect(
      context.state.displayModel?.source,
      EewWarningOverlaySource.simulation,
    );
  });

  test('simulationのcloseはsessionとsourceを停止する', () async {
    final context = createContext();
    addTearDown(context.container.dispose);
    context.container
        .read(eewWarningOverlaySimulationProvider.notifier)
        .start();
    await context.settle();

    await context.container
        .read(eewWarningOverlayNotifierProvider.notifier)
        .close();
    await context.settle();

    expect(context.state.mode, EewWarningOverlayMode.hidden);
    expect(context.state.simulationSessionActive, isFalse);
    expect(context.container.read(eewWarningOverlaySimulationProvider), isNull);
  });

  test('実警報preemption後はsimulationを新しいsessionとして再実行できる', () async {
    final context = createContext();
    addTearDown(context.container.dispose);
    final simulation = context.container.read(
      eewWarningOverlaySimulationProvider.notifier,
    );
    simulation.start();
    await context.settle();
    expect(context.vibration.startCalls, 1);

    await context.publishReal(display(eventIds: ['A']));
    expect(context.state.displayModel?.source, EewWarningOverlaySource.real);
    expect(context.vibration.startCalls, 2);

    await context.publishReal(null);
    expect(context.state.mode, EewWarningOverlayMode.hidden);
    simulation.start();
    await context.settle();

    expect(
      context.state.displayModel?.source,
      EewWarningOverlaySource.simulation,
    );
    expect(context.state.simulationSessionActive, isTrue);
    expect(context.vibration.startCalls, 3);
  });

  test('background中の新eventIdはseenにせずresume時に初めて通知する', () async {
    final context = createContext(lifecycleState: AppLifecycleState.paused);
    addTearDown(context.container.dispose);

    await context.publishReal(display(eventIds: ['A']));
    expect(context.state.mode, EewWarningOverlayMode.hidden);
    expect(context.state.seenEventIds, isEmpty);
    expect(context.vibration.startCalls, 0);

    await context.publishLifecycle(AppLifecycleState.resumed);
    expect(context.state.mode, EewWarningOverlayMode.fullscreen);
    expect(context.state.seenEventIds, {'A'});
    expect(context.vibration.startCalls, 1);
  });

  test('foregroundで既知のAにbackgroundでBが加わるとresume時に再通知する', () async {
    final context = createContext();
    addTearDown(context.container.dispose);
    await context.publishReal(display(eventIds: ['A']));
    await context.publishLifecycle(AppLifecycleState.paused);

    await context.publishReal(display(eventIds: ['A', 'B']));
    expect(context.state.seenEventIds, {'A'});
    expect(context.state.mode, EewWarningOverlayMode.minimized);

    await context.publishLifecycle(AppLifecycleState.resumed);
    expect(context.state.seenEventIds, {'A', 'B'});
    expect(context.state.mode, EewWarningOverlayMode.fullscreen);
    expect(context.vibration.startCalls, 2);
  });

  test('background中に消えた新eventIdはresumeしても通知しない', () async {
    final context = createContext(lifecycleState: AppLifecycleState.paused);
    addTearDown(context.container.dispose);

    await context.publishReal(display(eventIds: ['A']));
    await context.publishReal(null);
    await context.publishLifecycle(AppLifecycleState.resumed);

    expect(context.state.mode, EewWarningOverlayMode.hidden);
    expect(context.state.seenEventIds, isEmpty);
    expect(context.vibration.startCalls, 0);
  });

  test('非resumed遷移は全画面を最小化してtimerと振動を止める', () async {
    final context = createContext();
    addTearDown(context.container.dispose);
    await context.publishReal(display(eventIds: ['A']));

    await context.publishLifecycle(AppLifecycleState.inactive);

    expect(context.state.mode, EewWarningOverlayMode.minimized);
    expect(context.scheduler.activeTaskCount, 0);
    expect(context.vibration.cancelCalls, 1);

    await context.publishLifecycle(AppLifecycleState.resumed);
    expect(context.state.mode, EewWarningOverlayMode.minimized);
    expect(context.vibration.startCalls, 1);
  });

  test('provider破棄時はtimerと振動を停止する', () async {
    final context = createContext();
    await context.publishReal(display(eventIds: ['A']));

    context.container.dispose();
    await Future<void>.delayed(Duration.zero);

    expect(context.scheduler.activeTaskCount, 0);
    expect(context.vibration.cancelCalls, 1);
  });
}
