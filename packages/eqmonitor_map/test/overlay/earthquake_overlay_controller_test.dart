import 'dart:ui';

import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  EarthquakeMapOverlaySnapshot snapshot({
    required String sourceId,
    required int revision,
    required Color color,
  }) => createEarthquakeMapOverlaySnapshot(
    sourceId: sourceId,
    revision: revision,
    regionToCityZoom: 6,
    stationMinZoom: 6,
    regionStyles: [
      EarthquakeAreaStyle(code: '130', color: color, opacity: 0.6),
    ],
    cityStyles: const [],
    stations: const [],
  );

  test('rejects a lower revision from the current source', () {
    final current = snapshot(
      sourceId: 'event-a',
      revision: 8,
      color: const Color(0xfff44336),
    );
    final stale = snapshot(
      sourceId: 'event-a',
      revision: 7,
      color: const Color(0xffff9800),
    );

    final result = commitEarthquakeOverlaySnapshot(
      current: current,
      next: stale,
    );

    expect(result, isA<EarthquakeOverlayCommitRejected>());
    expect((result as EarthquakeOverlayCommitRejected).current, same(current));
  });

  test('accepts the same revision to replace the theme', () {
    final current = snapshot(
      sourceId: 'event-a',
      revision: 8,
      color: const Color(0xfff44336),
    );
    final themed = snapshot(
      sourceId: 'event-a',
      revision: 8,
      color: const Color(0xff2196f3),
    );

    final result = commitEarthquakeOverlaySnapshot(
      current: current,
      next: themed,
    );

    expect(result, isA<EarthquakeOverlayCommitAccepted>());
    expect((result as EarthquakeOverlayCommitAccepted).next, same(themed));
  });

  test('atomically replaces the current snapshot from another source', () {
    final current = snapshot(
      sourceId: 'event-a',
      revision: 100,
      color: const Color(0xfff44336),
    );
    final replacement = snapshot(
      sourceId: 'event-b',
      revision: 0,
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

  test('accepts an initial snapshot', () {
    final initial = snapshot(
      sourceId: 'event-a',
      revision: 0,
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
