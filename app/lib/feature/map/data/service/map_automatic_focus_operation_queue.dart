import 'dart:async';

class MapAutomaticFocusOperationQueue {
  Future<void> _tail = Future<void>.value();

  Future<bool> schedule({required Future<bool> Function() operation}) {
    final previous = _tail;
    final release = Completer<void>();
    _tail = release.future;
    return runMapAutomaticFocusOperation(
      previous: previous,
      release: release,
      operation: operation,
    );
  }
}

Future<bool> runMapAutomaticFocusOperation({
  required Future<void> previous,
  required Completer<void> release,
  required Future<bool> Function() operation,
}) async {
  try {
    await previous;
    return await operation();
  } finally {
    release.complete();
  }
}
