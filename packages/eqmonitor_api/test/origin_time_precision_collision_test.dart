import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:test/test.dart';

Map<String, Object?> fixture(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, Object?>;

void main() {
  test('地震と震源カタログで異なる時刻精度をパースできる', () {
    final earthquakeJson = fixture(
      'test/fixtures/contract/get__v2_earthquake_eventId.json',
    );
    final earthquake = earthquakeJson['earthquake']! as Map<String, Object?>;
    earthquake['origin_time_precision'] = 'MILLISECOND';

    final earthquakeResponse = EarthquakeDetailResponse.fromJson(
      earthquakeJson,
    );
    final hypocenterResponse = HypocenterListResponse.fromJson(
      fixture('test/fixtures/contract/get__v2_hypocenters.json'),
    );

    expect(
      earthquakeResponse.earthquake.originTimePrecision.toJson(),
      'MILLISECOND',
    );
    expect(
      hypocenterResponse.data.items.first.originTimePrecision.toJson(),
      'CENTISECOND',
    );
  });
}
