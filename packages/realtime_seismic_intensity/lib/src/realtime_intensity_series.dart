final class const RealtimeIntensitySeries({
  required final DateTime startTime,
  required final List<double?> values,
  final Duration interval = const Duration(seconds: 1),
}) {
  // values[i] は startTime から i 区間後〜(i + 1) 区間後の波形までを使った値で、(i + 1) 区間後に確定する。
  double? valueAt(DateTime time) {
    final elapsed = time.difference(startTime).inMicroseconds;
    final step = interval.inMicroseconds;
    if (elapsed < step) {
      return null;
    }
    final index = elapsed ~/ step - 1;
    return index < values.length ? values[index] : null;
  }

  DateTime get endTime => startTime.add(interval * values.length);

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
