import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

class NativeShakeSnapshot {
  const new({
    required this.events,
    required this.estimates,
    required this.eewSummaries,
  });
  const new empty()
    : events = const [],
      estimates = const {},
      eewSummaries = const {};
  final List<ShakeDetectionEvent> events;
  final Map<String, NativeShakeEstimate> estimates;
  final Map<String, NativeObservedSummary> eewSummaries;

  factory fromJson({
    required Map<String, dynamic> json,
    required KyoshinObservationPointsParameter catalog,
  }) {
    final presentation = {
      for (final p
          in (json['presentation'] as List).cast<Map<String, dynamic>>())
        p['event_id'] as String: p,
    };
    final stationById = {for (final p in catalog.points) p.code: p};
    final events = <ShakeDetectionEvent>[];
    final summaries = <String, NativeObservedSummary>{};
    for (final event
        in (json['detection']['events'] as List).cast<Map<String, dynamic>>()) {
      final id = event['id'] as String;
      final decision = presentation[id];
      if (decision == null) continue;
      final intensity = (event['max_intensity'] as num).toDouble();
      final contributors = (event['contributors'] as List)
          .cast<Map<String, dynamic>>();
      final card = decision['card'] as Map<String, dynamic>;
      if (card['kind'] == 'eew') {
        final eewId = card['id'] as String;
        final previous = summaries[eewId];
        summaries[eewId] = NativeObservedSummary(
          stations: (previous?.stations ?? 0) + contributors.length,
          maxIntensity: previous != null && previous.maxIntensity > intensity
              ? previous.maxIntensity
              : intensity,
        );
        continue;
      }
      if (card['kind'] != 'standalone' || decision['show_area'] != true)
        continue;
      final latitudes =
          contributors
              .map((p) => (p['position']['latitude'] as num).toDouble())
              .toList()
            ..sort();
      final longitudes =
          contributors
              .map((p) => (p['position']['longitude'] as num).toDouble())
              .toList()
            ..sort();
      events.add(
        ShakeDetectionEvent(
          eventId: id,
          serialNo: event['generation'] as int,
          createdAt: DateTime.fromMillisecondsSinceEpoch(
            event['first_observed_at'] as int,
            isUtc: true,
          ),
          updatedAt: DateTime.fromMillisecondsSinceEpoch(
            event['last_supported_at'] as int,
            isUtc: true,
          ),
          expiresAt: DateTime.fromMillisecondsSinceEpoch(
            (event['last_supported_at'] as int) + 5000,
            isUtc: true,
          ),
          level: switch (intensity) {
            >= 5.5 => ShakeDetectionLevel.stronger,
            >= 3.5 => ShakeDetectionLevel.strong,
            >= 2.5 => ShakeDetectionLevel.medium,
            >= 0.5 => ShakeDetectionLevel.weak,
            _ => ShakeDetectionLevel.weaker,
          },
          pointCount: contributors.length,
          minLat: latitudes.first,
          maxLat: latitudes.last,
          minLng: longitudes.first,
          maxLng: longitudes.last,
          changeReasons: (decision['reasons'] as List).cast<String>(),
          points: [
            for (final p in contributors)
              api.Points(
                code: p['station_id'] as String,
                name:
                    stationById[p['station_id']]?.name ??
                    p['station_id'] as String,
                region: '',
                type: 'surface',
                location: api.Location(
                  latitude: p['position']['latitude'] as num,
                  longitude: p['position']['longitude'] as num,
                ),
                intensity: p['intensity'] as num,
                prefectureCode: stationById[p['station_id']]?.prefectureCode,
                regionCode: stationById[p['station_id']]?.regionCode,
                cityCode: null,
              ),
          ],
        ),
      );
    }
    final estimates = <String, NativeShakeEstimate>{};
    for (final update
        in (json['estimates'] as List).cast<Map<String, dynamic>>()) {
      final id = update['token']['event_id'] as String;
      if (presentation[id]?['show_estimate'] == true)
        estimates[id] = NativeShakeEstimate(
          latitude: (update['position']['latitude'] as num).toDouble(),
          longitude: (update['position']['longitude'] as num).toDouble(),
          depthKm: (update['depth_km'] as num).toDouble(),
        );
    }
    return NativeShakeSnapshot(
      events: events,
      estimates: estimates,
      eewSummaries: summaries,
    );
  }
}

class const NativeShakeEstimate({
  required final double latitude,
  required final double longitude,
  required final double depthKm,
});
class const NativeObservedSummary({
  required final int stations,
  required final double maxIntensity,
});
