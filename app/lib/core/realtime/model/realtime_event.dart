import 'package:eqmonitor/core/realtime/model/realtime_shake_data.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime_event.freezed.dart';
part 'realtime_event.g.dart';

enum RealtimeSource { eqmonitor, dmdata }

@Freezed()
sealed class RealtimeEvent with _$RealtimeEvent {
  const factory RealtimeEvent.snapshot({
    required List<EewItemWithRelations> eews,
    required List<EarthquakePartial> earthquakes,
    required List<RealtimeShakeData> shakes,
    required RealtimeSource source,
  }) = RealtimeSnapshotEvent;

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

  const factory RealtimeEvent.shakeDetected({
    required RealtimeShakeData data,
    required RealtimeSource source,
  }) = RealtimeShakeDetectedEvent;

  factory RealtimeEvent.fromJson(Map<String, dynamic> json) =>
      _$RealtimeEventFromJson(json);
}
