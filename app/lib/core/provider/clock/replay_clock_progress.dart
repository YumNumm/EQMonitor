import 'package:clock/clock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_clock_progress.g.dart';

@Riverpod(keepAlive: true)
ReplayClockProgress replayClockProgress(Ref ref) => ReplayClockProgress();

/// リプレイの再生位置は進行のたびにしか届かないため、その間は経過時間に再生速度を掛けて進める。
class ReplayClockProgress {
  Stopwatch _elapsed = clock.stopwatch();
  double _rate = 0;
  DateTime? _limit;

  void restart({required double rate, required DateTime? limit}) {
    _elapsed = clock.stopwatch()..start();
    _rate = rate;
    _limit = limit;
  }

  DateTime positionFrom(DateTime base) {
    final position = base.add(_elapsed.elapsed * _rate);
    final limit = _limit;
    return limit != null && position.isAfter(limit) ? limit : position;
  }
}
