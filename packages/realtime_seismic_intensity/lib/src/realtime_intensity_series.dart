final class const RealtimeIntensitySeries({
  required final DateTime startTime,
  required final List<double?> values,
}) {
  // values[i] は startTime から i 秒後〜(i + 1) 秒後の波形までを使った値で、(i + 1) 秒後に確定する。
  double? valueAt(DateTime time) {
    final elapsed = time.difference(startTime).inMicroseconds;
    if (elapsed < Duration.microsecondsPerSecond) {
      return null;
    }
    final index = elapsed ~/ Duration.microsecondsPerSecond - 1;
    return index < values.length ? values[index] : null;
  }

  DateTime get endTime => startTime.add(Duration(seconds: values.length));

  double? get maxValue {
    double? result;
    for (final value in values) {
      if (value != null && (result == null || value > result)) {
        result = value;
      }
    }
    return result;
  }
}
