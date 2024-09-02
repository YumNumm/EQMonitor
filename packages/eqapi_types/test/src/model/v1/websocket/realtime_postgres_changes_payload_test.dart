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
    },
  );
}
