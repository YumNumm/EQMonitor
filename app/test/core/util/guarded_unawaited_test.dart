import 'package:eqmonitor/core/util/guarded_unawaited.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('captures async error via onError', () async {
    Object? captured;
    guardedUnawaited(
      () async => throw StateError('boom'),
      onError: (error, _) => captured = error,
    );
    await Future<void>.delayed(Duration.zero);
    expect(captured, isA<StateError>());
  });

  test('captures synchronous throw in action', () async {
    Object? captured;
    guardedUnawaited(
      () => throw ArgumentError('bad'),
      onError: (error, _) => captured = error,
    );
    await Future<void>.delayed(Duration.zero);
    expect(captured, isA<ArgumentError>());
  });

  test('does not call onError on success', () async {
    var called = false;
    guardedUnawaited(
      () async {},
      onError: (_, _) => called = true,
    );
    await Future<void>.delayed(Duration.zero);
    expect(called, isFalse);
  });
}
