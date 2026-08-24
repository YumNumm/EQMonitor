import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:test/test.dart';

void main() {
  test('aggregated_at を集計時刻としてデシリアライズする', () {
    final response = CityMaxIntensityResponse.fromJson({
      'aggregated_at': '2026-08-19T12:00:00.000Z',
      'items': <Map<String, dynamic>>[],
    });

    expect(response.toJson()['aggregated_at'], '2026-08-19T12:00:00.000Z');
  });

  test('aggregated_at が null でも items をデシリアライズする', () {
    final response = CityMaxIntensityResponse.fromJson({
      'aggregated_at': null,
      'items': [
        {'city_id': '0110000', 'max_intensity': '4'},
      ],
    });

    expect(response.aggregatedAt, isNull);
    expect(response.items.single.cityId, '0110000');
  });
}
