import 'package:eqmonitor_map/src/renderer/map_gpu_resource_ledger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('rejects a maxFramesInFlight below one', () {
    expect(
      () => MapGpuResourceLedger<String>(maxFramesInFlight: 0),
      throwsArgumentError,
    );
    expect(
      () => MapGpuResourceLedger<String>(maxFramesInFlight: -1),
      throwsArgumentError,
    );
  });

  test('starts at context generation zero with no live resources', () {
    final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 2);

    expect(ledger.contextGeneration, 0);
    expect(ledger.liveResourceCount, 0);
  });

  test('requires beginFrame before lookup, put, and retireIdle', () {
    final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 2);
    final key = Object();

    expect(() => ledger.lookup(key: key), throwsStateError);
    expect(() => ledger.put(key: key, resource: 'a'), throwsStateError);
    expect(ledger.retireIdle, throwsStateError);
  });

  test('rejects a negative context generation', () {
    final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 2);

    expect(
      () => ledger.beginFrame(contextGeneration: -1, frameNumber: 0),
      throwsArgumentError,
    );
  });

  test('rejects a negative frame number', () {
    final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 2);

    expect(
      () => ledger.beginFrame(contextGeneration: 0, frameNumber: -1),
      throwsArgumentError,
    );
  });

  test('rejects a decreasing frame number but allows a repeated one', () {
    final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 2);

    ledger.beginFrame(contextGeneration: 1, frameNumber: 7);
    ledger.beginFrame(contextGeneration: 1, frameNumber: 7);

    expect(
      () => ledger.beginFrame(contextGeneration: 1, frameNumber: 6),
      throwsArgumentError,
    );
  });

  test('keeps resources across frames within the same context generation', () {
    final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 2);
    final key = Object();

    ledger.beginFrame(contextGeneration: 1, frameNumber: 10);
    expect(ledger.lookup(key: key), isNull);
    ledger.put(key: key, resource: 'buffer');

    final retired = ledger.beginFrame(contextGeneration: 1, frameNumber: 11);

    expect(retired, isEmpty);
    expect(ledger.lookup(key: key), 'buffer');
    expect(ledger.liveResourceCount, 1);
  });

  test('rejects put for a key that is already live', () {
    final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 2);
    final key = Object();

    ledger.beginFrame(contextGeneration: 1, frameNumber: 0);
    ledger.put(key: key, resource: 'first');

    expect(() => ledger.put(key: key, resource: 'second'), throwsStateError);
    expect(ledger.lookup(key: key), 'first');
  });

  test('keys resources by identity, not by equality', () {
    final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 2);
    // const にすると同じ値が canonicalize されて identical になり、
    // 「`==` は等しいが identity は別」という検証条件が作れないため、
    // 意図的に非 const で 2 instance 作る。
    // ignore: prefer_const_constructors
    final first = _EquatableKey('same');
    // 同上。
    // ignore: prefer_const_constructors
    final second = _EquatableKey('same');

    ledger.beginFrame(contextGeneration: 1, frameNumber: 0);
    ledger.put(key: first, resource: 'first');

    expect(first, second);
    expect(ledger.lookup(key: second), isNull);
    ledger.put(key: second, resource: 'second');
    expect(ledger.liveResourceCount, 2);
    expect(ledger.lookup(key: first), 'first');
    expect(ledger.lookup(key: second), 'second');
  });

  test(
    'retires every resource when the context generation changes and fails '
    'closed afterwards',
    () {
      final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 4);
      final fill = Object();
      final line = Object();

      ledger.beginFrame(contextGeneration: 1, frameNumber: 0);
      ledger
        ..put(key: fill, resource: 'fill')
        ..put(key: line, resource: 'line');

      final retired = ledger.beginFrame(contextGeneration: 2, frameNumber: 1);

      expect(retired, unorderedEquals(<String>['fill', 'line']));
      expect(ledger.contextGeneration, 2);
      expect(ledger.liveResourceCount, 0);
      expect(ledger.lookup(key: fill), isNull);
      expect(ledger.lookup(key: line), isNull);
    },
  );

  test(
    'retires only entries unused for more than maxFramesInFlight frames',
    () {
      final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 2);
      final stale = Object();
      final fresh = Object();

      ledger.beginFrame(contextGeneration: 1, frameNumber: 10);
      ledger.put(key: stale, resource: 'stale');

      ledger.beginFrame(contextGeneration: 1, frameNumber: 12);
      ledger.put(key: fresh, resource: 'fresh');
      expect(ledger.retireIdle(), isEmpty);

      // frame 10 の entry は 12 - 2 == 10 の時点ではまだ in-flight 扱い。
      expect(ledger.retireIdle(), isEmpty);

      ledger.beginFrame(contextGeneration: 1, frameNumber: 13);

      expect(ledger.retireIdle(), <String>['stale']);
      expect(ledger.liveResourceCount, 1);
      expect(ledger.lookup(key: fresh), 'fresh');
    },
  );

  test('never retires an entry used in the current frame', () {
    final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 1);
    final key = Object();

    ledger.beginFrame(contextGeneration: 1, frameNumber: 0);
    ledger.put(key: key, resource: 'buffer');

    ledger.beginFrame(contextGeneration: 1, frameNumber: 100);
    expect(ledger.lookup(key: key), 'buffer');

    expect(ledger.retireIdle(), isEmpty);
    expect(ledger.liveResourceCount, 1);
  });

  test('refreshes the idle deadline on a lookup hit', () {
    final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 1);
    final key = Object();

    ledger.beginFrame(contextGeneration: 1, frameNumber: 0);
    ledger.put(key: key, resource: 'buffer');

    ledger.beginFrame(contextGeneration: 1, frameNumber: 1);
    expect(ledger.lookup(key: key), 'buffer');

    ledger.beginFrame(contextGeneration: 1, frameNumber: 2);
    expect(ledger.retireIdle(), isEmpty);

    ledger.beginFrame(contextGeneration: 1, frameNumber: 3);
    expect(ledger.retireIdle(), <String>['buffer']);
  });

  test('retireAll is idempotent and leaves the ledger usable', () {
    final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 2);
    final first = Object();
    final second = Object();

    ledger.beginFrame(contextGeneration: 1, frameNumber: 0);
    ledger
      ..put(key: first, resource: 'first')
      ..put(key: second, resource: 'second');

    expect(ledger.retireAll(), unorderedEquals(<String>['first', 'second']));
    expect(ledger.retireAll(), isEmpty);
    expect(ledger.liveResourceCount, 0);

    ledger.beginFrame(contextGeneration: 1, frameNumber: 1);
    ledger.put(key: first, resource: 'rebuilt');

    expect(ledger.lookup(key: first), 'rebuilt');
    expect(ledger.contextGeneration, 1);
  });

  test('retireAll is allowed before the first beginFrame', () {
    final ledger = MapGpuResourceLedger<String>(maxFramesInFlight: 2);

    expect(ledger.retireAll(), isEmpty);
  });
}

/// identity key の検証用。`==` が一致しても別 entry として扱われることを見る。
@immutable
final class _EquatableKey {
  const new(this.value);

  final String value;

  @override
  bool operator ==(Object other) =>
      other is _EquatableKey && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
