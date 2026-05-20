import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';

/// LLM が呼び出すツールを EarthquakeHistoryRepository へ橋渡し。
class EqToolRunner {
  EqToolRunner({required EarthquakeHistoryRepository repository})
    : _repository = repository;

  final EarthquakeHistoryRepository _repository;

  Future<Map<String, Object?>> searchEarthquakes({
    double? magnitudeGte,
    double? magnitudeLte,
    String? intensityGte,
    String? intensityLte,
    int? depthGte,
    int? depthLte,
    int? limit,
  }) async {
    final response = await _repository.fetchEarthquakeList(
      limit: limit?.clamp(1, 30) ?? 10,
      magnitudeGte: magnitudeGte,
      magnitudeLte: magnitudeLte,
      depthGte: depthGte,
      depthLte: depthLte,
      intensityGte: _parseIntensity(intensityGte),
      intensityLte: _parseIntensity(intensityLte),
    );
    return {
      'count': response.items.length,
      'items': [
        for (final eq in response.items) _serializePartial(eq),
      ],
      'nextToken': response.nextToken,
    };
  }

  Future<Map<String, Object?>> getEarthquakeDetail({
    required String eventId,
  }) async {
    final detail = await _repository.fetchEarthquakeDetail(eventId: eventId);
    return _serializeEarthquake(detail);
  }

  Future<Map<String, Object?>> searchByEpicenter({
    required int epicenterCode,
    int? limit,
  }) async {
    final response = await _repository.searchByEpicenter(
      code: epicenterCode,
      limit: limit?.clamp(1, 30) ?? 10,
    );
    return {
      'count': response.items.length,
      'items': [
        for (final item in response.items)
          {
            'eventId': item.eventId,
            'epicenter': {
              'code': item.epicenter.code,
              'name': item.epicenter.name,
            },
            ..._serializePartial(item.earthquake),
          },
      ],
      'nextToken': response.nextToken,
    };
  }

  Map<String, Object?> _serializePartial(EarthquakePartial eq) {
    return {
      'eventId': eq.eventId,
      'originTime': eq.originTime?.toIso8601String(),
      'arrivalTime': eq.arrivalTime?.toIso8601String(),
      'hypocenter': _serializeHypocenter(eq.hypocenter),
      'maxIntensity': eq.intensity?.maxIntensity.label,
      'status': eq.status.name,
    };
  }

  Map<String, Object?> _serializeEarthquake(Earthquake eq) {
    return {
      'eventId': eq.eventId,
      'originTime': eq.originTime?.toIso8601String(),
      'arrivalTime': eq.arrivalTime?.toIso8601String(),
      'hypocenter': _serializeHypocenter(eq.hypocenter),
      'maxIntensity': eq.intensity?.maxIntensity.label,
      'status': eq.status.name,
    };
  }

  Map<String, Object?>? _serializeHypocenter(EarthquakeHypocenter? h) {
    if (h == null) {
      return null;
    }
    final coord = h.coordinates;
    return {
      'code': h.code,
      'name': h.name,
      'detailedName': h.detailedName,
      'latitude': switch (coord) {
        CoordinateLatLng(:final latitude) => latitude,
        CoordinateUnknown() => null,
      },
      'longitude': switch (coord) {
        CoordinateLatLng(:final longitude) => longitude,
        CoordinateUnknown() => null,
      },
      'magnitude': switch (h.magnitude) {
        EarthquakeMagnitudeValue(:final value) => value,
        EarthquakeMagnitudeOverM8() => 'M8以上',
        EarthquakeMagnitudeUnknown() => null,
      },
      'depthKm': switch (h.depth) {
        EarthquakeDepthValue(:final value) => value,
        EarthquakeDepthShallow() => 'ごく浅い',
        EarthquakeDepthOver700km() => '700km以上',
        EarthquakeDepthUnknown() => null,
      },
    };
  }

  JmaIntensity? _parseIntensity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final v = value.trim().toLowerCase();
    for (final intensity in JmaIntensity.values) {
      if (intensity.label.toLowerCase() == v ||
          intensity.name.toLowerCase() == v) {
        return intensity;
      }
    }
    const map = <String, JmaIntensity>{
      '1': JmaIntensity.one,
      '2': JmaIntensity.two,
      '3': JmaIntensity.three,
      '4': JmaIntensity.four,
      '5弱': JmaIntensity.fiveLower,
      '5-': JmaIntensity.fiveLower,
      '5+': JmaIntensity.fiveUpper,
      '5強': JmaIntensity.fiveUpper,
      '6弱': JmaIntensity.sixLower,
      '6-': JmaIntensity.sixLower,
      '6+': JmaIntensity.sixUpper,
      '6強': JmaIntensity.sixUpper,
      '7': JmaIntensity.seven,
    };
    return map[v];
  }
}
