import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_clock_source_identity_provider.g.dart';

enum MapClockSourceMode { realtime, timeShift, replay }

typedef MapClockSourceIdentity = ({
  MapClockSourceMode mode,
  Duration? timeShiftOffset,
  int? replaySession,
});

@Riverpod(keepAlive: true)
MapClockSourceIdentity mapClockSourceIdentity(Ref ref) {
  final timeMode = ref.watch(appClockProvider);
  final appClock = ref.read(appClockProvider.notifier);
  return switch (timeMode) {
    RealtimeTimeMode() => const (
      mode: MapClockSourceMode.realtime,
      timeShiftOffset: null,
      replaySession: null,
    ),
    TimeShiftTimeMode(:final offset) => (
      mode: MapClockSourceMode.timeShift,
      timeShiftOffset: offset,
      replaySession: null,
    ),
    ReplayTimeMode() => (
      mode: MapClockSourceMode.replay,
      timeShiftOffset: null,
      replaySession: appClock.latestReplaySession,
    ),
  };
}
