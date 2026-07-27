import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_monitor_event.freezed.dart';

enum LiveMonitorEarthquakeTriggerKind {
  vxse51,
  vxse52,
  vxse53,
  vxse61,
  vxse62,
  estimatedIntensity,
}

@freezed
sealed class LiveMonitorEarthquakeTrigger with _$LiveMonitorEarthquakeTrigger {
  const factory LiveMonitorEarthquakeTrigger.telegram({
    required LiveMonitorEarthquakeTriggerKind kind,
    required DateTime reportedAt,
  }) = LiveMonitorTelegramTrigger;

  const factory LiveMonitorEarthquakeTrigger.estimatedIntensity({
    required DateTime? generatedAt,
  }) = LiveMonitorEstimatedIntensityTrigger;
}

extension LiveMonitorEarthquakeTriggerKindValue
    on LiveMonitorEarthquakeTrigger {
  LiveMonitorEarthquakeTriggerKind get kind => switch (this) {
    LiveMonitorTelegramTrigger(:final kind) => kind,
    LiveMonitorEstimatedIntensityTrigger() => .estimatedIntensity,
  };
}

@freezed
sealed class LiveMonitorDetectedEvent with _$LiveMonitorDetectedEvent {
  const factory LiveMonitorDetectedEvent.eewStarted({
    required String eventId,
    required int serialNo,
  }) = LiveMonitorEewStartedEvent;

  const factory LiveMonitorDetectedEvent.eewUpdated({
    required String eventId,
    required int serialNo,
  }) = LiveMonitorEewUpdatedEvent;

  const factory LiveMonitorDetectedEvent.shakeDetected({
    required String eventId,
    required int serialNo,
  }) = LiveMonitorShakeDetectedEvent;

  const factory LiveMonitorDetectedEvent.earthquakeUpsert({
    required String eventId,
    required LiveMonitorEarthquakeTrigger trigger,
    required Earthquake earthquake,
  }) = LiveMonitorEarthquakeUpsertEvent;

  const factory LiveMonitorDetectedEvent.earthquakeDeleted({
    required String eventId,
  }) = LiveMonitorEarthquakeDeletedEvent;
}

@freezed
abstract class LiveMonitorEventEnvelope with _$LiveMonitorEventEnvelope {
  const factory LiveMonitorEventEnvelope({
    required int sequence,
    required LiveMonitorDetectedEvent event,
  }) = _LiveMonitorEventEnvelope;
}
