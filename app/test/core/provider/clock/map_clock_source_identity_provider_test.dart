import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/map_clock_source_identity_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('realtimeとtime-shift offsetをsource identityへ反映する', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final subscription = container.listen(
      mapClockSourceIdentityProvider,
      (_, _) {},
      fireImmediately: true,
    );
    addTearDown(subscription.close);
    final appClock = container.read(appClockProvider.notifier);

    expect(
      container.read(mapClockSourceIdentityProvider),
      const (
        mode: MapClockSourceMode.realtime,
        timeShiftOffset: null,
        replaySession: null,
      ),
    );

    appClock.enterTimeShift(const Duration(minutes: -5));
    expect(
      container.read(mapClockSourceIdentityProvider),
      const (
        mode: MapClockSourceMode.timeShift,
        timeShiftOffset: Duration(minutes: -5),
        replaySession: null,
      ),
    );

    final firstTimeShift = container.read(mapClockSourceIdentityProvider);
    appClock.enterTimeShift(const Duration(minutes: -5));
    expect(container.read(mapClockSourceIdentityProvider), firstTimeShift);

    appClock.enterTimeShift(const Duration(minutes: -6));
    expect(
      container.read(mapClockSourceIdentityProvider),
      isNot(firstTimeShift),
    );
  });

  test('replay tickは同一sessionを保ち再入場で新sessionを発行する', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final identities = <MapClockSourceIdentity>[];
    final subscription = container.listen(
      mapClockSourceIdentityProvider,
      (_, next) => identities.add(next),
      fireImmediately: true,
    );
    addTearDown(subscription.close);
    final appClock = container.read(appClockProvider.notifier);

    appClock.enterReplay(DateTime.utc(2026, 8, 24));
    final firstReplay = container.read(mapClockSourceIdentityProvider);
    expect(firstReplay.mode, MapClockSourceMode.replay);
    expect(firstReplay.replaySession, isNotNull);

    appClock.updateReplayTime(DateTime.utc(2026, 8, 24, 0, 0, 1));
    final replayTick = container.read(mapClockSourceIdentityProvider);
    expect(replayTick, firstReplay);
    expect(
      identities.where((identity) => identity == firstReplay),
      hasLength(1),
    );

    appClock.returnToRealtime();
    appClock.enterReplay(DateTime.utc(2026, 8, 24));
    final secondReplay = container.read(mapClockSourceIdentityProvider);
    expect(secondReplay.mode, MapClockSourceMode.replay);
    expect(secondReplay.replaySession, isNot(firstReplay.replaySession));
  });
}
