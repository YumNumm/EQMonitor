import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'periodic_timer.g.dart';

@riverpod
class PeriodicTimer extends _$PeriodicTimer {
  late final StreamController<void> _streamController;

  /// メインタイマー
  Timer? _timer;

  /// 調整タイマー
  Timer? _timerForDelayAdjust;

  /// ストップウォッチ
  Stopwatch? _stopwatch;

  @override
  Stream<void> build(Key key) async* {
    _streamController = StreamController<void>();

    _stopwatch = clock.stopwatch()..start();

    ref.onDispose(() {
      unawaited(_streamController.close());
      _timer?.cancel();
      _timerForDelayAdjust?.cancel();
      _stopwatch?.stop();
    });

    yield* _streamController.stream;
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
      _streamController.add(null);
      _timer = Timer.periodic(interval, _onTimer);
    } else {
      _timerForDelayAdjust = Timer(nextTime, () {
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
    _stopwatch?.reset();
    _streamController.add(null);
  }
}
