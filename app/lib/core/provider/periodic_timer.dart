import 'dart:async';

import 'package:clock/clock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'periodic_timer.g.dart';

@riverpod
class PeriodicTimer extends _$PeriodicTimer {
  /// メインタイマー
  Timer? _timer;

  /// 調整タイマー
  Timer? _timerForDelayAdjust;

  /// ストップウォッチ
  Stopwatch? _stopwatch;

  late final _streamController = StreamController<void>.broadcast();

  @override
  Stream<void> build(String key) {
    _stopwatch = clock.stopwatch()..start();

    ref.onDispose(() {
      unawaited(_streamController.close());
      _timer?.cancel();
      _timerForDelayAdjust?.cancel();
      _stopwatch?.stop();
    });

    return _streamController.stream;
  }

  /// 直近のTimerを考慮してタイマーを設定する
  void setInterval(Duration interval) {
    _timer?.cancel();
    _timer = null;
    _timerForDelayAdjust?.cancel();
    _timerForDelayAdjust = null;

    // 次のタイミングを計算する
    final nextTime = interval - (_stopwatch?.elapsed ?? Duration.zero);
    if (nextTime.isNegative) {
      // ignore: avoid_print
      print('[PeriodicTimer] Adding event immediately (nextTime: $nextTime)');
      _streamController.add(null);
      _timer = Timer.periodic(interval, _onTimer);
    } else {
      // ignore: avoid_print
      print('[PeriodicTimer] Setting delay adjust timer (nextTime: $nextTime)');
      _timerForDelayAdjust = Timer(nextTime, () {
        // ignore: avoid_print
        print('[PeriodicTimer] Delay adjust timer triggered');
        _streamController.add(null);
        _timerForDelayAdjust?.cancel();
        _timerForDelayAdjust = null;

        _timer = Timer.periodic(interval, _onTimer);
      });
    }
  }

  /// 直近のTimerを考慮しないでタイマーを設定する
  void setIntervalWithoutCurrentTimer(Duration interval) {
    _timer?.cancel();
    _timer = null;
    _timerForDelayAdjust?.cancel();
    _timerForDelayAdjust = null;

    _timer = Timer.periodic(interval, _onTimer);
  }

  void _onTimer(Timer timer) {
    // ignore: avoid_print
    print('[PeriodicTimer] Timer triggered');
    _stopwatch?.reset();
    _streamController.add(null);
  }
}
