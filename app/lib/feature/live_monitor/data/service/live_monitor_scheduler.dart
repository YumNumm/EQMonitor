import 'dart:async';

final class LiveMonitorScheduler {
  Timer? _timer;
  int _generation = 0;

  void schedule({
    required DateTime now,
    required DateTime deadline,
    required void Function() onElapsed,
  }) {
    _generation += 1;
    _timer?.cancel();
    final generation = _generation;
    final remaining = deadline.difference(now);
    final delay = remaining.isNegative ? Duration.zero : remaining;
    _timer = Timer(delay, () {
      if (_generation == generation) {
        onElapsed();
      }
    });
  }

  void cancel() {
    _generation += 1;
    _timer?.cancel();
    _timer = null;
  }
}
