import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

class DebugLiveActivitySession {
  const DebugLiveActivitySession({
    required this.liveActivityId,
    required this.eventId,
    required this.startTrigger,
  });

  final String liveActivityId;
  final String eventId;
  final api.LiveActivityStartTrigger startTrigger;
}
