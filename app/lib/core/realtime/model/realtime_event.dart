import 'package:eqmonitor/core/realtime/model/realtime_shake_data.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime_event.freezed.dart';
part 'realtime_event.g.dart';

enum RealtimeSource { eqmonitor, dmdata }

@Freezed()
sealed class RealtimeEvent with _$RealtimeEvent {
  const factory RealtimeEvent.ready({
    required RealtimeSource source,
  }) = RealtimeReadyEvent;

  const factory RealtimeEvent.eewUpsert({
    required EewItemWithRelations item,
    required RealtimeSource source,
  }) = RealtimeEewUpsertEvent;

  const factory RealtimeEvent.earthquakeUpsert({
    required EarthquakePartial record,
    required RealtimeSource source,
  }) = RealtimeEarthquakeUpsertEvent;

  const factory RealtimeEvent.earthquakeDelete({
    required String eventId,
    required RealtimeSource source,
  }) = RealtimeEarthquakeDeleteEvent;

  const factory RealtimeEvent.tsunamiUpsert({
    required String eventId,
    required RealtimeSource source,
    String? groupId,
  }) = RealtimeTsunamiUpsertEvent;

  const factory RealtimeEvent.tsunamiDelete({
    required String eventId,
    required RealtimeSource source,
    String? groupId,
  }) = RealtimeTsunamiDeleteEvent;

  const factory RealtimeEvent.shakeDetected({
    required RealtimeShakeData data,
    required RealtimeSource source,
  }) = RealtimeShakeDetectedEvent;

  const factory RealtimeEvent.estimatedIntensityUpsert({
    required String eventId,
    required String estimatedIntensityTile,
    required RealtimeSource source,
  }) = RealtimeEstimatedIntensityUpsertEvent;

  factory RealtimeEvent.fromJson(Map<String, dynamic> json) =>
      _$RealtimeEventFromJson(json);
}
