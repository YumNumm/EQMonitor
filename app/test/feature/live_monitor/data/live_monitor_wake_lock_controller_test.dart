import 'dart:async';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_settings.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_session_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/provider/live_monitor_wake_lock_controller.dart';
import 'package:eqmonitor/feature/live_monitor/data/service/live_monitor_wake_lock_owner.dart';
import 'package:eqmonitor/feature/live_monitor/data/service/live_monitor_wake_lock_platform.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

final class BlockedWakeLockCall {
  final started = Completer<void>();
  final release = Completer<void>();
}

final class FakeLiveMonitorWakeLockPlatform
    implements LiveMonitorWakeLockPlatform {
  final calls = <bool>[];
  Exception? nextError;
  BlockedWakeLockCall? nextBlockedCall;
  bool? enabled;
  int inFlight = 0;
  int maxInFlight = 0;

  BlockedWakeLockCall blockNextCall() {
    final blockedCall = BlockedWakeLockCall();
    nextBlockedCall = blockedCall;
    return blockedCall;
  }

  @override
  Future<void> setEnabled({required bool enabled}) async {
    calls.add(enabled);
    inFlight += 1;
    if (inFlight > maxInFlight) {
      maxInFlight = inFlight;
    }
    try {
      final error = nextError;
      nextError = null;
      if (error != null) {
        throw error;
      }
      final blockedCall = nextBlockedCall;
      nextBlockedCall = null;
      if (blockedCall != null) {
        blockedCall.started.complete();
        await blockedCall.release.future;
      }
      this.enabled = enabled;
    } finally {
      inFlight -= 1;
    }
  }
}

final class MutableLiveMonitorSettings extends LiveMonitorSettingsNotifier {
  new(this.initial);

  final LiveMonitorSettings initial;

  @override
  Future<LiveMonitorSettings> build() async => initial;

  void publish(LiveMonitorSettings value) => state = AsyncData(value);
}

final class MutableAppLifecycle extends AppLifecycle {
  new(this.initial);

  final AppLifecycleState initial;

  @override
  AppLifecycleState build() => initial;

  void publish(AppLifecycleState value) => state = value;
}

final class WakeLockFixture {
  new({
    required this.container,
    required this.platform,
    required this.settings,
    required this.lifecycle,
    required this.owner,
  });

  final ProviderContainer container;
  final FakeLiveMonitorWakeLockPlatform platform;
  final MutableLiveMonitorSettings settings;
  final MutableAppLifecycle lifecycle;
  final LiveMonitorWakeLockOwner owner;
  LiveMonitorSessionLease? lease;

  void activateSession() {
    lease ??= container.read(liveMonitorSessionProvider.notifier).acquire();
  }

  void exitSession() {
    final currentLease = lease;
    if (currentLease == null) {
      return;
    }
    container
        .read(liveMonitorSessionProvider.notifier)
        .release(lease: currentLease);
    lease = null;
  }

  Future<void> settle() async {
    await Future<void>.delayed(Duration.zero);
    await container.read(liveMonitorWakeLockControllerProvider.future);
  }

  Future<void> pumpController() async {
    await Future<void>.delayed(Duration.zero);
    container.read(liveMonitorWakeLockControllerProvider);
    await Future<void>.delayed(Duration.zero);
  }

  Future<void> dispose() async {
    container.dispose();
    await owner.disposed;
  }
}

void main() {
  talker_lib.talker = Talker(settings: TalkerSettings(useConsoleLogs: false));

  test('resumedでenableしbackgroundでdisableする', () async {
    final fixture = createWakeLockFixture();
    addTearDown(fixture.dispose);
    fixture.activateSession();

    await fixture.settle();
    expect(fixture.platform.calls, [true]);

    fixture.lifecycle.publish(AppLifecycleState.paused);
    await fixture.settle();
    expect(fixture.platform.calls, [true, false]);

    fixture.lifecycle.publish(AppLifecycleState.resumed);
    await fixture.settle();
    expect(fixture.platform.calls, [true, false, true]);
  });

  test('画面点灯設定が無効ならactiveかつresumedでもdisableする', () async {
    final fixture = createWakeLockFixture(
      initialSettings: const LiveMonitorSettings(keepScreenAwake: false),
    );
    addTearDown(fixture.dispose);
    fixture.activateSession();

    await fixture.settle();

    expect(fixture.platform.calls, [false]);
  });

  test('session開始時にenableしexit時にdisableする', () async {
    final fixture = createWakeLockFixture();
    addTearDown(fixture.dispose);

    await fixture.settle();
    expect(fixture.platform.calls, [false]);

    fixture.activateSession();
    await fixture.settle();
    expect(fixture.platform.calls, [false, true]);

    fixture.exitSession();
    await fixture.settle();
    expect(fixture.platform.calls, [false, true, false]);
  });

  test('session中に画面点灯設定を無効にするとdisableする', () async {
    final fixture = createWakeLockFixture();
    addTearDown(fixture.dispose);
    fixture.activateSession();
    await fixture.settle();

    fixture.settings.publish(const LiveMonitorSettings(keepScreenAwake: false));
    await fixture.settle();

    expect(fixture.platform.calls, [true, false]);
  });

  test('desired stateが変わらなければplatform callを重複させない', () async {
    final fixture = createWakeLockFixture();
    addTearDown(fixture.dispose);
    fixture.activateSession();
    await fixture.settle();

    fixture.lifecycle.publish(AppLifecycleState.paused);
    await fixture.settle();
    fixture.lifecycle.publish(AppLifecycleState.inactive);
    await fixture.settle();

    expect(fixture.platform.calls, [true, false]);
  });

  test('platform例外を記録してsessionやcontrollerをエラーにしない', () async {
    talker_lib.talker.cleanHistory();
    final fixture = createWakeLockFixture();
    addTearDown(fixture.dispose);
    fixture.platform.nextError = Exception('wakelock failed');
    fixture.activateSession();

    await fixture.settle();

    expect(fixture.container.read(liveMonitorSessionProvider), isTrue);
    expect(
      fixture.container.read(liveMonitorWakeLockControllerProvider),
      isA<AsyncData<void>>(),
    );
    expect(
      talker_lib.talker.history.any(
        (entry) => entry.message == '[LiveMonitor] failed to update wake lock',
      ),
      isTrue,
    );

    fixture.lifecycle.publish(AppLifecycleState.paused);
    await fixture.settle();
    expect(fixture.platform.calls, [true, false]);
    expect(fixture.platform.enabled, isFalse);
  });

  test('enable完了前にbackgroundへ移行しても最後は直列にdisableする', () async {
    final fixture = createWakeLockFixture();
    addTearDown(fixture.dispose);
    fixture.activateSession();
    final blockedEnable = fixture.platform.blockNextCall();
    final initialTransition = fixture.settle();
    await blockedEnable.started.future;

    fixture.lifecycle.publish(AppLifecycleState.paused);
    await fixture.pumpController();
    expect(fixture.platform.calls, [true]);
    expect(fixture.platform.maxInFlight, 1);

    blockedEnable.release.complete();
    await initialTransition;
    await fixture.settle();

    expect(fixture.platform.calls, [true, false]);
    expect(fixture.platform.enabled, isFalse);
  });

  test('enable完了前にsessionをexitしても最後はdisableする', () async {
    final fixture = createWakeLockFixture();
    addTearDown(fixture.dispose);
    fixture.activateSession();
    final blockedEnable = fixture.platform.blockNextCall();
    final initialTransition = fixture.settle();
    await blockedEnable.started.future;

    fixture.exitSession();
    await fixture.pumpController();
    expect(fixture.platform.calls, [true]);

    blockedEnable.release.complete();
    await initialTransition;
    await fixture.settle();

    expect(fixture.platform.calls, [true, false]);
    expect(fixture.platform.enabled, isFalse);
  });

  test('in-flight中の複数変更は古い中間状態を飛ばして最新へ収束する', () async {
    final fixture = createWakeLockFixture();
    addTearDown(fixture.dispose);
    fixture.activateSession();
    final blockedEnable = fixture.platform.blockNextCall();
    final initialTransition = fixture.settle();
    await blockedEnable.started.future;

    fixture.lifecycle.publish(AppLifecycleState.paused);
    await fixture.pumpController();
    fixture.lifecycle.publish(AppLifecycleState.resumed);
    await fixture.pumpController();
    fixture.settings.publish(const LiveMonitorSettings(keepScreenAwake: false));
    await fixture.pumpController();
    expect(fixture.platform.calls, [true]);

    blockedEnable.release.complete();
    await initialTransition;
    await fixture.settle();

    expect(fixture.platform.calls, [true, false]);
    expect(fixture.platform.maxInFlight, 1);
    expect(fixture.platform.enabled, isFalse);
  });

  test('enable中にpauseしてcontainerをdisposeしても最後はdisableする', () async {
    final fixture = createWakeLockFixture();
    fixture.activateSession();
    final blockedEnable = fixture.platform.blockNextCall();
    final initialTransition = fixture.settle();
    await blockedEnable.started.future;

    fixture.lifecycle.publish(AppLifecycleState.paused);
    await fixture.pumpController();
    final disposeFuture = fixture.dispose();
    blockedEnable.release.complete();
    await Future.wait([initialTransition, disposeFuture]);

    expect(fixture.platform.calls, [true, false]);
    expect(fixture.platform.maxInFlight, 1);
    expect(fixture.platform.enabled, isFalse);
  });

  test('enable中にexitしてcontainerをdisposeしても最後はdisableする', () async {
    final fixture = createWakeLockFixture();
    fixture.activateSession();
    final blockedEnable = fixture.platform.blockNextCall();
    final initialTransition = fixture.settle();
    await blockedEnable.started.future;

    fixture.exitSession();
    await fixture.pumpController();
    final disposeFuture = fixture.dispose();
    blockedEnable.release.complete();
    await Future.wait([initialTransition, disposeFuture]);

    expect(fixture.platform.calls, [true, false]);
    expect(fixture.platform.maxInFlight, 1);
    expect(fixture.platform.enabled, isFalse);
  });

  test('enable中に設定をoffにしてcontainerをdisposeしても最後はdisableする', () async {
    final fixture = createWakeLockFixture();
    fixture.activateSession();
    final blockedEnable = fixture.platform.blockNextCall();
    final initialTransition = fixture.settle();
    await blockedEnable.started.future;

    fixture.settings.publish(const LiveMonitorSettings(keepScreenAwake: false));
    await fixture.pumpController();
    final disposeFuture = fixture.dispose();
    blockedEnable.release.complete();
    await Future.wait([initialTransition, disposeFuture]);

    expect(fixture.platform.calls, [true, false]);
    expect(fixture.platform.maxInFlight, 1);
    expect(fixture.platform.enabled, isFalse);
  });

  test('enabledのままcontainerをdisposeすると最後にdisableする', () async {
    final fixture = createWakeLockFixture();
    fixture.activateSession();
    await fixture.settle();

    await fixture.dispose();

    expect(fixture.platform.calls, [true, false]);
    expect(fixture.platform.enabled, isFalse);
  });

  test('disable失敗後もqueueを継続して最新のdisableを適用する', () async {
    talker_lib.talker.cleanHistory();
    final platform = FakeLiveMonitorWakeLockPlatform();
    final owner = LiveMonitorWakeLockOwner(platform: platform);
    addTearDown(owner.dispose);
    await owner.setDesired(enabled: true);
    platform.nextError = Exception('disable failed');

    await owner.setDesired(enabled: false);
    await owner.setDesired(enabled: false);

    expect(platform.calls, [true, false, false]);
    expect(platform.enabled, isFalse);
    expect(
      talker_lib.talker.history.any(
        (entry) => entry.message == '[LiveMonitor] failed to update wake lock',
      ),
      isTrue,
    );
  });
}

WakeLockFixture createWakeLockFixture({
  LiveMonitorSettings initialSettings = const LiveMonitorSettings(),
  AppLifecycleState initialLifecycle = AppLifecycleState.resumed,
}) {
  final platform = FakeLiveMonitorWakeLockPlatform();
  final settings = MutableLiveMonitorSettings(initialSettings);
  final lifecycle = MutableAppLifecycle(initialLifecycle);
  final container = ProviderContainer(
    overrides: [
      liveMonitorWakeLockPlatformProvider.overrideWithValue(platform),
      liveMonitorSettingsProvider.overrideWith(() => settings),
      appLifecycleProvider.overrideWith(() => lifecycle),
    ],
  );
  container.listen(
    liveMonitorSettingsProvider,
    (_, _) {},
    fireImmediately: true,
  );
  final owner = container.read(liveMonitorWakeLockOwnerProvider);
  return WakeLockFixture(
    container: container,
    platform: platform,
    settings: settings,
    lifecycle: lifecycle,
    owner: owner,
  );
}
