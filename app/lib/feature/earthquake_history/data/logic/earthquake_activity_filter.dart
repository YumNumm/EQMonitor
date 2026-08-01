import 'dart:math' as math;

import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';

class EarthquakeActivityFilter {
  const EarthquakeActivityFilter();

  static const _earthRadiusKm = 6371.0;

  List<EarthquakePartialNormal> apply({
    required EarthquakeActivityQuery query,
    required List<EarthquakePartial> candidates,
    required DateTime now,
  }) {
    final byEventId = <String, EarthquakePartialNormal>{};
    final end = query.effectiveEnd(now: now);

    for (final candidate in candidates) {
      final earthquake = candidate.earthquake;
      final originTime = earthquake.originTime;
      final coordinates = earthquake.hypocenter?.coordinates;
      if (earthquake.eventId == query.baseEventId ||
          earthquake.earthquakeType != EarthquakeType.normal ||
          originTime == null ||
          originTime.isBefore(query.start) ||
          originTime.isAfter(end) ||
          coordinates is! CoordinateLatLng) {
        continue;
      }

      final distance = distanceKm(
        fromLatitude: query.latitude,
        fromLongitude: query.longitude,
        toLatitude: coordinates.latitude,
        toLongitude: coordinates.longitude,
      );
      if (distance > query.radiusKm) {
        continue;
      }

      final candidateDepth = switch (earthquake.hypocenter?.depth) {
        EarthquakeDepthShallow() => 0,
        EarthquakeDepthValue(:final value) => value,
        EarthquakeDepthOver700km() => 700,
        EarthquakeDepthUnknown() || null => null,
      };
      final depthGte = query.depthGte;
      final depthLte = query.depthLte;
      if (depthGte != null &&
          depthLte != null &&
          (candidateDepth == null ||
              candidateDepth < depthGte ||
              candidateDepth > depthLte)) {
        continue;
      }

      byEventId.putIfAbsent(earthquake.eventId, () => earthquake);
    }

    final result = byEventId.values.toList()
      ..sort((first, second) {
        final firstTime = first.originTime;
        final secondTime = second.originTime;
        if (firstTime == null || secondTime == null) {
          return first.eventId.compareTo(second.eventId);
        }
        final timeComparison = secondTime.compareTo(firstTime);
        return timeComparison != 0
            ? timeComparison
            : first.eventId.compareTo(second.eventId);
      });
    return result;
  }

  double distanceKm({
    required double fromLatitude,
    required double fromLongitude,
    required double toLatitude,
    required double toLongitude,
  }) {
    final fromLat = fromLatitude * math.pi / 180;
    final toLat = toLatitude * math.pi / 180;
    final latitudeDelta = (toLatitude - fromLatitude) * math.pi / 180;
    final longitudeDelta = (toLongitude - fromLongitude) * math.pi / 180;
    final haversine =
        math.pow(math.sin(latitudeDelta / 2), 2) +
        math.cos(fromLat) *
            math.cos(toLat) *
            math.pow(math.sin(longitudeDelta / 2), 2);
    final centralAngle =
        2 * math.atan2(math.sqrt(haversine), math.sqrt(1 - haversine));
    return _earthRadiusKm * centralAngle;
  }
}
