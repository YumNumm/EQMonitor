import 'dart:async';

final class LatestMapOperationGuard {
  var _generation = 0;
  var _disposed = false;
  Future<void> _cameraTail = Future<void>.value();

  int begin() {
    if (_disposed) {
      throw StateError('LatestMapOperationGuard is disposed');
    }
    _generation++;
    return _generation;
  }

  bool isCurrent(int generation) => !_disposed && generation == _generation;

  void invalidate() {
    if (!_disposed) {
      _generation++;
    }
  }

  Future<void> runLatest({
    required int generation,
    required Future<void> Function() operation,
  }) {
    final completer = Completer<void>();
    _cameraTail = _cameraTail.then((_) async {
      if (!isCurrent(generation)) {
        completer.complete();
        return;
      }
      try {
        await operation();
        completer.complete();
      } on Exception catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      } on Error catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }

  void dispose() {
    _disposed = true;
    _generation++;
  }
}
