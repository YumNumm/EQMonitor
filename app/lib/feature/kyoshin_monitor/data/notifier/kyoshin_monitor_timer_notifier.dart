import 'dart:async';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/periodic_timer.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/data_source/kyoshin_monitor_web_api_data_source.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_timer_notifier.g.dart';

@riverpod
class KyoshinMonitorTimerNotifier extends _$KyoshinMonitorTimerNotifier {
  @override
  Stream<KyoshinMonitorTimerState> build() async* {
    final streamController = StreamController<KyoshinMonitorTimerState>();
    // 5秒ごとにRetry
    while (true) {
      final result = await _syncDelaySimple();
      if (result case Success(:final value)) {
        talker.logCustom(KyoshinMonitorLog('delayFromDevice: $value'));
        yield KyoshinMonitorTimerState(
          delayFromDevice: value,
          lastSyncedAt: DateTime.now(),
        );
        break;
      } else {
        await Future<void>.delayed(const Duration(seconds: 5));
      }
    }

    // Resync timer
    const key = Key('KyoshinMonitorTimerNotifier');
    var isResyncing = false;
    ref
      ..listen(
        kyoshinMonitorSettingsProvider.select((v) => v.api.delayAdjustInterval),
        (_, next) =>
            ref.read(periodicTimerProvider(key).notifier).setInterval(next),
      )
      ..listen(
        periodicTimerProvider(key),
        (_, next) async {
          if (isResyncing) {
            return;
          }
          var retryCount = 0;
          while (retryCount < 3) {
            isResyncing = true;
            final result = await _syncDelaySimple();
            if (result case Success(:final value)) {
              streamController.add(
                KyoshinMonitorTimerState(
                  delayFromDevice: value,
                  lastSyncedAt: DateTime.now(),
                ),
              );
              break;
            } else {
              retryCount++;
              await Future<void>.delayed(const Duration(seconds: 5));
            }
          }
          isResyncing = false;
        },
      );

    ref.onDispose(streamController.close);
    yield* streamController.stream;
  }

  @visibleForTesting
  Future<Result<Duration, Exception>> syncDelaySimple() async =>
      _syncDelaySimple();

  /// サーバの現在時刻を1回取得して、デバイスの現在時刻との差分を返す
  Future<Result<Duration, Exception>> _syncDelaySimple() async =>
      Result.capture(() async {
        final latestJson = await ref
            .read(kyoshinMonitorWebApiDataSourceProvider)
            .getLatestDataTime();
        final deviceTime = DateTime.now();
        return deviceTime.difference(latestJson.latestTime);
      });

  @visibleForTesting
  Future<Result<Duration, Exception>> syncDelay([
    Duration interval = const Duration(milliseconds: 200),
  ]) async =>
      _syncDelay(interval);

  /// サーバの現在取得が変わるまでくりかえし取得し、変わったらその差分を返す
  Future<Result<Duration, Exception>> _syncDelay([
    Duration interval = const Duration(milliseconds: 200),
  ]) async =>
      Result.capture(() async {
        final firstTime = (await ref
                .read(kyoshinMonitorWebApiDataSourceProvider)
                .getLatestDataTime())
            .latestTime;
        var latestTime = firstTime;
        while (true) {
          await Future<void>.delayed(interval);
          latestTime = (await ref
                  .read(kyoshinMonitorWebApiDataSourceProvider)
                  .getLatestDataTime())
              .latestTime;
          if (latestTime != firstTime) {
            break;
          }
        }
        final deviceTime = DateTime.now();
        return deviceTime.difference(latestTime);
      });
}

@riverpod
Stream<void> _kyoshinMonitorDelayAdujustTiming(Ref ref) {
  const key = Key('kyoshin_monitor_delay_adjust_timing');
  final streamController = StreamController<void>();
  ref
    ..listen(
      periodicTimerProvider(key),
      (previous, next) {
        streamController.add(null);
      },
    )
    ..listen(
      kyoshinMonitorSettingsProvider.select((v) => v.api.delayAdjustInterval),
      (_, next) {
        ref.read(periodicTimerProvider(key).notifier).setInterval(next);
      },
    );

  ref.read(periodicTimerProvider(key).notifier).setInterval(
        ref.read(kyoshinMonitorSettingsProvider).api.delayAdjustInterval,
      );

  ref.onDispose(streamController.close);
  return streamController.stream;
}
