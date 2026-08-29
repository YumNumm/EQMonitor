import 'dart:ui';

import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MapOverlayVersionStamp versionStamp({
    required String sourceIdentity,
    required int dataSequence,
    required int renderGeneration,
    String sourceIncarnation = 'incarnation-a',
    String dataDigest = 'data-a',
    String renderDigest = 'render-a',
  }) => createMapOverlayVersionStamp(
    sourceIdentity: createMapSourceIdentity(value: sourceIdentity),
    sourceIncarnation: createMapSourceIncarnation(value: sourceIncarnation),
    dataSequence: dataSequence,
    dataDigest: dataDigest,
    renderGeneration: renderGeneration,
    renderDigest: renderDigest,
  );

  EarthquakeMapOverlaySnapshot snapshot({
    required MapOverlayVersionStamp versionStamp,
    required Color color,
  }) => createEarthquakeMapOverlaySnapshot(
    versionStamp: versionStamp,
    regionToCityZoom: 6,
    stationMinZoom: 6,
    regionStyles: [
      EarthquakeAreaStyle(code: '130', color: color, opacity: 0.6),
    ],
    cityStyles: const [],
    stations: const [],
    spriteAtlas: null,
    sprites: const [],
    maxSpritePolicyBatches: 1,
  );

  test('rejects a lower data sequence from the current source', () {
    final current = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        dataSequence: 8,
        renderGeneration: 8,
      ),
      color: const Color(0xfff44336),
    );
    final stale = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        dataSequence: 7,
        renderGeneration: 8,
      ),
      color: const Color(0xffff9800),
    );

    final result = commitEarthquakeOverlaySnapshot(
      current: current,
      next: stale,
    );

    expect(result, isA<EarthquakeOverlayCommitRejected>());
    expect((result as EarthquakeOverlayCommitRejected).current, same(current));
  });

  test('rejects equal data sequence with a conflicting digest', () {
    final current = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        dataSequence: 8,
        renderGeneration: 8,
      ),
      color: const Color(0xfff44336),
    );
    final conflicting = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        dataSequence: 8,
        dataDigest: 'data-b',
        renderGeneration: 9,
        renderDigest: 'render-b',
      ),
      color: const Color(0xff2196f3),
    );

    final result = commitEarthquakeOverlaySnapshot(
      current: current,
      next: conflicting,
    );

    expect(result, isA<EarthquakeOverlayCommitRejected>());
  });

  test('rejects lower or conflicting render generation', () {
    final current = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        dataSequence: 8,
        renderGeneration: 8,
      ),
      color: const Color(0xfff44336),
    );
    final lower = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        dataSequence: 8,
        renderGeneration: 7,
      ),
      color: const Color(0xffff9800),
    );
    final conflicting = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        dataSequence: 8,
        renderGeneration: 8,
        renderDigest: 'render-b',
      ),
      color: const Color(0xff2196f3),
    );

    expect(
      commitEarthquakeOverlaySnapshot(current: current, next: lower),
      isA<EarthquakeOverlayCommitRejected>(),
    );
    expect(
      commitEarthquakeOverlaySnapshot(current: current, next: conflicting),
      isA<EarthquakeOverlayCommitRejected>(),
    );
  });

  test('accepts a higher render generation without changing data version', () {
    final current = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        dataSequence: 8,
        renderGeneration: 8,
      ),
      color: const Color(0xfff44336),
    );
    final themed = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        dataSequence: 8,
        renderGeneration: 9,
        renderDigest: 'render-b',
      ),
      color: const Color(0xff2196f3),
    );

    final result = commitEarthquakeOverlaySnapshot(
      current: current,
      next: themed,
    );

    expect(result, isA<EarthquakeOverlayCommitAccepted>());
    expect((result as EarthquakeOverlayCommitAccepted).next, same(themed));
  });

  test('accepts an exactly identical stamp idempotently', () {
    final stamp = versionStamp(
      sourceIdentity: 'event-a',
      dataSequence: 8,
      renderGeneration: 8,
    );
    final current = snapshot(
      versionStamp: stamp,
      color: const Color(0xfff44336),
    );
    final identicalVersion = snapshot(
      versionStamp: stamp,
      color: const Color(0xfff44336),
    );

    expect(
      commitEarthquakeOverlaySnapshot(
        current: current,
        next: identicalVersion,
      ),
      isA<EarthquakeOverlayCommitAccepted>(),
    );
  });

  test('input gate rejects a distinct snapshot with the same stamp', () {
    final stamp = versionStamp(
      sourceIdentity: 'event-a',
      dataSequence: 8,
      renderGeneration: 8,
    );
    final current = snapshot(
      versionStamp: stamp,
      color: const Color(0xfff44336),
    );
    final conflictingInput = snapshot(
      versionStamp: stamp,
      color: const Color(0xff2196f3),
    );

    final result = commitEarthquakeOverlayInputSnapshot(
      current: current,
      next: conflictingInput,
    );

    expect(result, isA<EarthquakeOverlayCommitRejected>());
    expect((result as EarthquakeOverlayCommitRejected).current, same(current));
  });

  test('atomically replaces the current snapshot from another source', () {
    final current = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        dataSequence: 100,
        renderGeneration: 100,
      ),
      color: const Color(0xfff44336),
    );
    final replacement = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-b',
        dataSequence: 0,
        renderGeneration: 0,
      ),
      color: const Color(0xff2196f3),
    );

    final result = commitEarthquakeOverlaySnapshot(
      current: current,
      next: replacement,
    );

    expect(result, isA<EarthquakeOverlayCommitAccepted>());
    expect(
      (result as EarthquakeOverlayCommitAccepted).next,
      same(replacement),
    );
  });

  test('accepts a fresh incarnation of the same source from sequence zero', () {
    final current = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        dataSequence: 100,
        renderGeneration: 100,
      ),
      color: const Color(0xfff44336),
    );
    final replacement = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        sourceIncarnation: 'incarnation-b',
        dataSequence: 0,
        renderGeneration: 0,
      ),
      color: const Color(0xff2196f3),
    );

    expect(
      commitEarthquakeOverlaySnapshot(current: current, next: replacement),
      isA<EarthquakeOverlayCommitAccepted>(),
    );
  });

  test('accepts an initial snapshot', () {
    final initial = snapshot(
      versionStamp: versionStamp(
        sourceIdentity: 'event-a',
        dataSequence: 0,
        renderGeneration: 0,
      ),
      color: const Color(0xfff44336),
    );

    final result = commitEarthquakeOverlaySnapshot(
      current: null,
      next: initial,
    );

    expect(result, isA<EarthquakeOverlayCommitAccepted>());
    expect((result as EarthquakeOverlayCommitAccepted).next, same(initial));
  });
}
