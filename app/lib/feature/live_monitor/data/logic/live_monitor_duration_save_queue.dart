final class LiveMonitorDurationSaveQueue {
  ({String raw, Future<bool> future})? _tail;

  bool get hasInFlight => _tail != null;

  Future<bool> run({
    required String raw,
    required Future<bool> Function() operation,
  }) async {
    final preceding = _tail;
    if (preceding != null && preceding.raw == raw) {
      return preceding.future;
    }

    final future = () async {
      if (preceding != null) {
        await preceding.future;
      }
      return operation();
    }();
    _tail = (raw: raw, future: future);
    try {
      return await future;
    } finally {
      if (identical(_tail?.future, future)) {
        _tail = null;
      }
    }
  }
}
