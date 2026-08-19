import 'package:telemetry_store/src/database/telemetry_database.dart';
import 'package:telemetry_store/src/models/upload_result.dart';
import 'package:telemetry_store/src/uploader/event_sender.dart';

class TelemetryUploader {
  new({
    required TelemetryDatabase db,
    required EventSender sender,
    this.batchSize = 100,
  }) : _db = db,
       _sender = sender;

  final TelemetryDatabase _db;
  final EventSender _sender;
  final int batchSize;

  Future<UploadResult> flush() async {
    try {
      final unsent = await _db.getUnsyncedEvents(limit: batchSize);
      if (unsent.isEmpty) {
        return const UploadResult(sentCount: 0, failedCount: 0);
      }

      final events = unsent
          .map(
            (row) => <String, dynamic>{
              'event_type': row.eventType,
              'timestamp_ms': row.timestampMs,
              'event_id': row.eventId,
              'payload': row.payload,
              'created_at_ms': row.createdAtMs,
            },
          )
          .toList();

      final success = await _sender.send(events);
      if (success) {
        await _db.markAsSynced(unsent.map((row) => row.id).toList());
        return UploadResult(sentCount: unsent.length, failedCount: 0);
      }
      return UploadResult(sentCount: 0, failedCount: unsent.length);
    } on Object catch (_) {
      return const UploadResult(sentCount: 0, failedCount: 0);
    }
  }
}
