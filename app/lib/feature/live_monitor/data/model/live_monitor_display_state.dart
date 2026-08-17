import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_monitor_display_state.freezed.dart';

@freezed
sealed class LiveMonitorDisplayState with _$LiveMonitorDisplayState {
  const factory realtime() =
      LiveMonitorRealtimeDisplayState;

  const factory earthquake({
    required String eventId,
    required LiveMonitorEarthquakeTrigger trigger,
    required Earthquake earthquake,
    required DateTime shownAt,
    required DateTime minimumUntil,
    required DateTime expiresAt,
    DateTime? returnToRealtimeAt,
  }) = LiveMonitorEarthquakeDisplayState;
}
