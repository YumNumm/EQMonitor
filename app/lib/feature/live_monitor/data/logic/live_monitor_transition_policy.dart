import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_display_state.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';

final class LiveMonitorTransitionDecision {
  const LiveMonitorTransitionDecision({
    required this.next,
    required this.deadline,
    required this.closeControlPanel,
  });

  final LiveMonitorDisplayState next;
  final DateTime? deadline;
  final bool closeControlPanel;
}

final class LiveMonitorTransitionPolicy {
  const LiveMonitorTransitionPolicy();

  LiveMonitorTransitionDecision resolve({
    required LiveMonitorDisplayState current,
    required LiveMonitorDetectedEvent event,
    required DateTime now,
    required int displaySeconds,
  }) => switch ((current, event)) {
    (
      _,
      LiveMonitorEarthquakeUpsertEvent(
        :final eventId,
        :final trigger,
        :final earthquake,
      ),
    ) =>
      LiveMonitorTransitionDecision(
        next: LiveMonitorDisplayState.earthquake(
          eventId: eventId,
          trigger: trigger,
          earthquake: earthquake,
          shownAt: now,
          minimumUntil: now.add(const Duration(seconds: 3)),
          expiresAt: now.add(Duration(seconds: displaySeconds)),
        ),
        deadline: now.add(Duration(seconds: displaySeconds)),
        closeControlPanel: false,
      ),
    (_, LiveMonitorEewStartedEvent()) => const LiveMonitorTransitionDecision(
      next: LiveMonitorDisplayState.realtime(),
      deadline: null,
      closeControlPanel: true,
    ),
    (
      final LiveMonitorEarthquakeDisplayState state,
      LiveMonitorEewUpdatedEvent() || LiveMonitorShakeDetectedEvent(),
    )
        when now.compareTo(state.minimumUntil) < 0 =>
      LiveMonitorTransitionDecision(
        next: state.copyWith(
          returnToRealtimeAt: state.returnToRealtimeAt ?? state.minimumUntil,
        ),
        deadline: state.returnToRealtimeAt ?? state.minimumUntil,
        closeControlPanel: false,
      ),
    (
      LiveMonitorEarthquakeDisplayState(),
      LiveMonitorEewUpdatedEvent() || LiveMonitorShakeDetectedEvent(),
    ) =>
      const LiveMonitorTransitionDecision(
        next: LiveMonitorDisplayState.realtime(),
        deadline: null,
        closeControlPanel: false,
      ),
    (
      final LiveMonitorEarthquakeDisplayState state,
      LiveMonitorEarthquakeDeletedEvent(:final eventId),
    )
        when state.eventId == eventId =>
      const LiveMonitorTransitionDecision(
        next: LiveMonitorDisplayState.realtime(),
        deadline: null,
        closeControlPanel: false,
      ),
    (final LiveMonitorEarthquakeDisplayState state, _) =>
      LiveMonitorTransitionDecision(
        next: state,
        deadline: state.returnToRealtimeAt ?? state.expiresAt,
        closeControlPanel: false,
      ),
    (LiveMonitorRealtimeDisplayState(), _) => LiveMonitorTransitionDecision(
      next: current,
      deadline: null,
      closeControlPanel: false,
    ),
  };

  LiveMonitorTransitionDecision resolveDeadline({
    required LiveMonitorDisplayState current,
    required DateTime now,
  }) => switch (current) {
    LiveMonitorEarthquakeDisplayState(
      :final returnToRealtimeAt,
      :final expiresAt,
    )
        when (returnToRealtimeAt != null &&
                now.compareTo(returnToRealtimeAt) >= 0) ||
            now.compareTo(expiresAt) >= 0 =>
      const LiveMonitorTransitionDecision(
        next: LiveMonitorDisplayState.realtime(),
        deadline: null,
        closeControlPanel: false,
      ),
    final LiveMonitorEarthquakeDisplayState state =>
      LiveMonitorTransitionDecision(
        next: state,
        deadline: state.returnToRealtimeAt ?? state.expiresAt,
        closeControlPanel: false,
      ),
    LiveMonitorRealtimeDisplayState() => LiveMonitorTransitionDecision(
      next: current,
      deadline: null,
      closeControlPanel: false,
    ),
  };
}
