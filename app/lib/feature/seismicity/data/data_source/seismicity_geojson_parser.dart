import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';

/// backend の `/v2/seismicity/manifest` が指す GeoJSON FeatureCollection を
/// [SeismicityEvent] のリストへ変換する。
///
/// contract: Point(lng, lat)、properties: event_id(string, required),
/// origin_time(ISO8601, required), magnitude(number|null),
/// depth(number|null km), max_intensity(string|null)。
class SeismicityGeoJsonParser {
  const SeismicityGeoJsonParser();

  List<SeismicityEvent> parse(Map<String, dynamic> geoJson) {
    final features = geoJson['features'] as List<dynamic>? ?? const [];
    final events = <SeismicityEvent>[];

    for (final rawFeature in features) {
      final feature = rawFeature as Map<String, dynamic>;
      final geometry = feature['geometry'] as Map<String, dynamic>?;
      final coordinates = geometry?['coordinates'] as List<dynamic>?;
      final properties = feature['properties'] as Map<String, dynamic>?;
      if (coordinates == null || coordinates.length < 2 || properties == null) {
        continue;
      }

      final eventId = properties['event_id'] as String?;
      final originTimeStr = properties['origin_time'] as String?;
      if (eventId == null || originTimeStr == null) {
        continue;
      }

      events.add(
        SeismicityEvent(
          eventId: eventId,
          originTime: DateTime.parse(originTimeStr),
          magnitude: (properties['magnitude'] as num?)?.toDouble(),
          depth: (properties['depth'] as num?)?.toDouble(),
          latitude: (coordinates[1] as num).toDouble(),
          longitude: (coordinates[0] as num).toDouble(),
          maxIntensity: properties['max_intensity'] as String?,
        ),
      );
    }

    return events;
  }
}
