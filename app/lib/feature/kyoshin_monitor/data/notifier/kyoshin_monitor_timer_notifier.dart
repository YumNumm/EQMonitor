import 'dart:async';

import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_timer_notifier.g.dart';

@riverpod
class KyoshinMonitorTimerNotifier extends _$KyoshinMonitorTimerNotifier {
  @override
  Stream<DateTime> build() {
    return;
  }
}

@riverpod
class KyoshinMonitorTimerRefresher extends _$KyoshinMonitorTimerRefresher {
  @override
  Stream<void> build() async* {
    final streamController = StreamController<void>();
    _stopwatch = Stopwatch()..start();

    void onTimer(Timer timer) {
      _stopwatch?.reset();
      streamController.add(null);
    }

    _timer = Timer.periodic(
      ref.read(kyoshinMonitorSettingsProvider).api.imageFetchInterval,
      onTimer,
    );

    ref.listen(
      kyoshinMonitorSettingsProvider.select((v) => v.api.imageFetchInterval),
      (previous, next) {
        _timerForDelayAdjust?.cancel();

        // 次のタイミングを計算する
        final nextTime = next - _stopwatch!.elapsed;
        print('nextTime: $nextTime');
        if (nextTime.isNegative) {
          print('isNegative');
          streamController.add(null);
        } else {
          print('isPositive');
          _timer?.cancel();
          _timerForDelayAdjust = Timer(
            nextTime,
            () {
              streamController.add(null);
              _timerForDelayAdjust?.cancel();
              _timerForDelayAdjust = null;

              _timer = Timer.periodic(
                next,
                onTimer,
              );
            },
          );
        }
      },
    );

    ref.onDispose(() {
      streamController.close();
      _timer?.cancel();
      _stopwatch?.stop();
      _timerForDelayAdjust?.cancel();
    });

    yield* streamController.stream;
  }

  /// タイマー
  Timer? _timer;

  /// 周期変化時に利用するタイマー
  Timer? _timerForDelayAdjust;

  /// 周期変化時用のストップウォッチ
  Stopwatch? _stopwatch;
}
