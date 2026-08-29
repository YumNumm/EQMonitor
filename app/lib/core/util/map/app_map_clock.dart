import 'package:eqmonitor/core/provider/clock/map_clock_source_identity_provider.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';

final class AppMapUtcWallSource implements MapUtcWallSource {
  const new(this._now);

  final DateTime Function() _now;

  @override
  DateTime captureUtc() => _now().toUtc();
}

const createAppMapClock = AppMapClockFactory();

final class AppMapClockFactory {
  const new();

  MapClock call({
    required DateTime Function() now,
    required MapClockSourceIdentity sourceIdentity,
  }) {
    final domain = createMapClockDomainId(
      value: [
        'eqmonitor-map',
        sourceIdentity.mode.name,
        sourceIdentity.timeShiftOffset?.inMicroseconds ?? 'none',
        sourceIdentity.replaySession ?? 'none',
      ].join(':'),
    );
    return SystemMapClock.withSources(
      domain: domain,
      utcWallSource: AppMapUtcWallSource(now),
      monotonicSource: SystemMonotonicSource.start(domain: domain),
      captureCreator: createMapClockCapture,
    );
  }
}
