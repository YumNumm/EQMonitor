import 'package:clock/clock.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// NTP の補正時刻を固定値で返すスタブ。
/// `fixedNow` が null の場合は未同期（補正なし）を表す。
class _StubNtp extends Ntp {
  new(this._fixedNow);

  final DateTime? _fixedNow;

  @override
  Future<NtpState> build() async => const NtpState();

  @override
  DateTime? now() => _fixedNow;
}

ProviderContainer _container({DateTime? ntpNow}) {
  final container = ProviderContainer(
    overrides: [ntpProvider.overrideWith(() => _StubNtp(ntpNow))],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('AppClock.now', () {
    final fixedWallClock = DateTime.utc(2025, 1, 1, 12);

    test('NTP 未同期かつ通常再生では clock.now() を返すこと', () {
      withClock(Clock.fixed(fixedWallClock), () {
        final container = _container();
        final clock = container.read(appClockProvider.notifier);

        expect(clock.now(), fixedWallClock);
      });
    });

    test('NTP 同期済みでは NTP 補正時刻を優先すること', () {
      final ntpNow = DateTime.utc(2025, 1, 1, 12, 0, 5);
      withClock(Clock.fixed(fixedWallClock), () {
        final container = _container(ntpNow: ntpNow);
        final clock = container.read(appClockProvider.notifier);

        expect(clock.now(), ntpNow);
      });
    });

    test('タイムシフト中はベース時刻に offset を加算すること', () {
      withClock(Clock.fixed(fixedWallClock), () {
        final container = _container();
        final clock = container.read(appClockProvider.notifier)
          ..enterTimeShift(const Duration(minutes: -5));

        expect(
          clock.now(),
          fixedWallClock.subtract(const Duration(minutes: 5)),
        );
      });
    });

    test('タイムシフト中も NTP 補正時刻を基準に offset を加算すること', () {
      final ntpNow = DateTime.utc(2025, 1, 1, 12, 0, 10);
      withClock(Clock.fixed(fixedWallClock), () {
        final container = _container(ntpNow: ntpNow);
        final clock = container.read(appClockProvider.notifier)
          ..enterTimeShift(const Duration(minutes: -1));

        expect(clock.now(), ntpNow.subtract(const Duration(minutes: 1)));
      });
    });

    test('リプレイ中はベース時刻に依らず currentTime を返すこと', () {
      final replayTime = DateTime.utc(2024, 1, 1, 7, 10, 8);
      withClock(Clock.fixed(fixedWallClock), () {
        final container = _container();
        final clock = container.read(appClockProvider.notifier)
          ..enterReplay(replayTime);

        expect(clock.now(), replayTime);
      });
    });
  });

  group('AppClock のモード遷移', () {
    test('初期状態は通常再生であること', () {
      final container = _container();
      expect(container.read(appClockProvider), const TimeMode.realtime());
    });

    test('enterTimeShift で TimeShiftTimeMode になること', () {
      final container = _container();
      container
          .read(appClockProvider.notifier)
          .enterTimeShift(const Duration(minutes: -3));

      expect(
        container.read(appClockProvider),
        const TimeMode.timeShift(offset: Duration(minutes: -3)),
      );
    });

    test('enterReplay で ReplayTimeMode になること', () {
      final replayTime = DateTime.utc(2024);
      final container = _container();
      container.read(appClockProvider.notifier).enterReplay(replayTime);

      expect(
        container.read(appClockProvider),
        TimeMode.replay(currentTime: replayTime),
      );
    });

    test('returnToRealtime で通常再生へ戻ること', () {
      final container = _container();
      final notifier = container.read(appClockProvider.notifier)
        ..enterTimeShift(const Duration(minutes: -3))
        ..returnToRealtime();

      expect(container.read(appClockProvider), const TimeMode.realtime());
      // 念のため now() もベース時刻に戻ることを確認
      withClock(Clock.fixed(DateTime.utc(2025, 1, 1, 12)), () {
        expect(notifier.now(), DateTime.utc(2025, 1, 1, 12));
      });
    });

    test('updateReplayTime はリプレイ中のみ再生位置を更新すること', () {
      final container = _container();
      final notifier = container.read(appClockProvider.notifier);

      // リプレイ中でない場合は無視される
      notifier.updateReplayTime(DateTime.utc(2024));
      expect(container.read(appClockProvider), const TimeMode.realtime());

      // リプレイ中は更新される
      notifier
        ..enterReplay(DateTime.utc(2024, 1, 1, 0, 0, 1))
        ..updateReplayTime(DateTime.utc(2024, 1, 1, 0, 0, 2));
      expect(
        container.read(appClockProvider),
        TimeMode.replay(currentTime: DateTime.utc(2024, 1, 1, 0, 0, 2)),
      );
    });
  });
}
