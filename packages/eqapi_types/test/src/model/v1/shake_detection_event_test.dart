import 'package:eqapi_types/eqapi_types.dart';
import 'package:test/test.dart';

void main() {
  group(
    'ShakeDetectionEvent.fromJson',
    () {
      const json = {
        'id': 13,
        'event_id': '4fde0e4b-7781-4ba3-988c-9a3563c1ef02',
        'serial_no': 10,
        'created_at': '2024-09-03T01:14:26.9+09:00',
        'inserted_at': '2024-09-03T01:14:58.12969+09:00',
        'max_intensity': '1',
        'regions': [
          {
            'name': '石川県',
            'points': [
              {'code': 'ISKH05', 'intensity': '1'},
            ],
            'maxIntensity': '1',
          }
        ],
        'top_left': {'latitude': 37.0426, 'longitude': 136.7176},
        'bottom_right': {'latitude': 37.3924, 'longitude': 137.1471},
        'point_count': 1,
      };

      test('正常系', () {
        final event = ShakeDetectionEvent.fromJson(json);
        expect(event.id, 13);
        expect(event.eventId, '4fde0e4b-7781-4ba3-988c-9a3563c1ef02');
        expect(event.serialNo, 10);
        expect(event.createdAt, DateTime.parse('2024-09-03T01:14:26.9+09:00'));
        expect(
          event.insertedAt,
          DateTime.parse('2024-09-03T01:14:58.12969+09:00'),
        );
        expect(event.maxIntensity, JmaIntensity.one);
        expect(event.regions, [
          const ShakeDetectionRegion(
            name: '石川県',
            maxIntensity: JmaForecastIntensity.one,
            points: [
              ShakeDetectionPoint(
                code: 'ISKH05',
                intensity: JmaForecastIntensity.one,
              ),
            ],
          ),
        ]);
      });
    },
  );
}
