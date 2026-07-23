// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import

import 'package:json_annotation/json_annotation.dart';
import 'realtime_earthquake_delete_payload.dart';
import 'realtime_earthquake_upsert_payload.dart';
import 'realtime_eew_upsert_payload.dart';
import 'realtime_shake_detection_snapshot_payload.dart';

sealed class RealtimeEventEnvelope {
  const RealtimeEventEnvelope();

  factory RealtimeEventEnvelope.fromJson(Map<String, Object?> json) {
    final discriminator = (json['type'], json['operation']);
    return switch (discriminator) {
      ('earthquake', 'delete') => RealtimeEarthquakeDeleteEvent(
        RealtimeEarthquakeDeletePayload.fromJson(json),
      ),
      ('earthquake', 'upsert') => RealtimeEarthquakeUpsertEvent(
        RealtimeEarthquakeUpsertPayload.fromJson(json),
      ),
      ('eew', 'upsert') => RealtimeEewUpsertEvent(
        RealtimeEewUpsertPayload.fromJson(json),
      ),
      ('shake_detection', 'snapshot') => RealtimeShakeDetectionSnapshotEvent(
        RealtimeShakeDetectionSnapshotPayload.fromJson(json),
      ),
      final value => throw CheckedFromJsonException(
        json,
        'type',
        'RealtimeEventEnvelope',
        'Unknown realtime discriminator: $value',
      ),
    };
  }
}

final class RealtimeEarthquakeDeleteEvent extends RealtimeEventEnvelope {
  const RealtimeEarthquakeDeleteEvent(this.payload);

  final RealtimeEarthquakeDeletePayload payload;
}

final class RealtimeEarthquakeUpsertEvent extends RealtimeEventEnvelope {
  const RealtimeEarthquakeUpsertEvent(this.payload);

  final RealtimeEarthquakeUpsertPayload payload;
}

final class RealtimeEewUpsertEvent extends RealtimeEventEnvelope {
  const RealtimeEewUpsertEvent(this.payload);

  final RealtimeEewUpsertPayload payload;
}

final class RealtimeShakeDetectionSnapshotEvent extends RealtimeEventEnvelope {
  const RealtimeShakeDetectionSnapshotEvent(this.payload);

  final RealtimeShakeDetectionSnapshotPayload payload;
}
