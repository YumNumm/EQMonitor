import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_geojson_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GeoJSON FeatureCollection を SeismicityEvent のリストへ変換する', () {
    const parser = SeismicityGeoJsonParser();
    final json =
        jsonDecode(
              File(
                'test/fixtures/seismicity/geojson_p1m.json',
              ).readAsStringSync(),
            )
            as Map<String, dynamic>;

    final events = parser.parse(json);

    expect(events.length, 2);
    expect(events[0].eventId, 'eq-1');
    expect(events[0].latitude, 35.6);
    expect(events[0].longitude, 139.7);
    expect(events[0].magnitude, 4.5);
    expect(events[0].depth, 30.0);
    expect(events[0].maxIntensity, '4');
    expect(events[1].eventId, 'eq-2');
    expect(events[1].magnitude, isNull);
    expect(events[1].depth, isNull);
    expect(events[1].maxIntensity, isNull);
  });

  test('event_id または origin_time が欠けた Feature はスキップする', () {
    const parser = SeismicityGeoJsonParser();
    final json = {
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [139.0, 35.0],
          },
          'properties': <String, dynamic>{},
        },
      ],
    };

    expect(parser.parse(json), isEmpty);
  });
}
