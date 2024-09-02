import 'package:eqapi_types/eqapi_types.dart';
import 'package:test/test.dart';

void main() {
  final basePayload = {
    'schema': 'public',
    'commit_timestamp': '2021-10-01T00:00:00Z',
    'errors': <void>[],
  };
  group(
    'INSERT',
    () {
      final insertPayload = {
        ...basePayload,
        'eventType': 'INSERT',
        'old': <String, dynamic>{},
      };
      test('EEW insert', () {
        final payload = {
          ...insertPayload,
          'table': 'eew',
          'new': {
            'id': 1009,
            'event_id': 20240329001440,
            'type': '緊急地震速報（地震動予報）',
            'schema_type': 'eew-information',
            'status': '通常',
            'info_type': '発表',
            'serial_no': 1,
            'headline': null,
            'is_canceled': false,
            'is_warning': false,
            'is_last_info': false,
            'origin_time': '2024-03-29T00:14:33+09:00',
            'arrival_time': '2024-03-29T00:14:40+09:00',
            'hypo_name': '能登半島沖',
            'depth': 20,
            'latitude': 37.3,
            'longitude': 136.4,
            'magnitude': 3.5,
            'forecast_max_intensity': '2',
            'forecast_max_lpgm_intensity': '0',
            'regions': <void>[],
            'forecast_max_intensity_is_over': null,
            'forecast_max_lpgm_intensity_is_over': null,
            'report_time': '2024-03-29T00:14:33+09:00',
          },
        };
        final result = RealtimePostgresChangesPayloadBase.fromJson(payload);
        expect(result, isA<RealtimePostgresInsertPayload<EewV1>>());
      });

      test(
        'ShakeDetectionEvent insert',
        () {
          final payload = {
            ...insertPayload,
            'new': {
              'events': [
                {
                  'id': '59490fd7-2029-4e5e-85f9-0bbde3e70083',
                  'created_at': '2024-09-03T02:58:33.9009509',
                  'point_count': 1,
                  'max_intensity': '0',
                  'regions': [
                    {
                      'name': '愛知県',
                      'maxIntensity': '0',
                      'points': [
                        {
                          'intensity': '0',
                          'code': 'AICH18',
                        }
                      ],
                    }
                  ],
                  'top_left': {
                    'latitude': 34.9635,
                    'longitude': 136.7847,
                  },
                  'bottom_right': {
                    'latitude': 36.1537,
                    'longitude': 137.7268,
                  },
                }
              ],
            },
            'schema': 'public',
            'table': 'shake_detection_events',
            'errors': <void>[],
          };
          final result = RealtimePostgresChangesPayloadBase.fromJson(payload);
          expect(
            result,
            isA<RealtimePostgresInsertPayload<
                    ShakeDetectionWebSocketTelegram>>(),
          );
        },
      );
    },
  );
}
