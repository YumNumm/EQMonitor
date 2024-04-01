import 'package:eqapi_types/lib.dart';
import 'package:eqapi_types/model/v1/websocket/realtime_postgres_changes_payload.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('realtimePostgresChangesPayloadTableMessageProvider<T>', () {
    test(
      '上流からEewV1-Insertが流れてきた時に、正しくパースすること',
      () {
        // arrange
        final demoPayload = <String, dynamic>{
          'commit_timestamp': '2024-04-01T12:10:32.747Z',
          'eventType': 'INSERT',
          'new': {
            'id': -1,
            'event_id': 20240401210952,
            'info_type': '発表',
            'schema_type': 'eew-information',
            'status': '通常',
            'type': '緊急地震速報（地震動予報）',
            'headline': null,
            'serial_no': 1,
            'is_canceled': false,
            'is_last_info': false,
            'arrival_time': '2024-04-01T21:09:52+09:00',
            'depth': 40,
            'forecast_max_intensity': '1',
            'forecast_max_intensity_is_over': false,
            'forecast_max_lpgm_intensity': '0',
            'forecast_max_lpgm_intensity_is_over': false,
            'hypo_name': '石垣島北西沖',
            'is_warning': false,
            'latitude': 25.2,
            'longitude': 123.6,
            'magnitude': 3.6,
            'origin_time': '2024-04-01T21:09:37+09:00',
            'regions': <void>[],
          },
          'old': <void, void>{},
          'schema': 'public',
          'table': 'eew',
          'errors': null,
        };
        // act
        final result = RealtimePostgresChangesPayloadBase.fromJson(demoPayload);
        // assert
        expect(result, isA<RealtimePostgresInsertPayload<EewV1>>());
      },
    );
    test('上流からEarthquakeV1-Insertが流れてきた時に、正しくパースすること`', () {
      // arrange
      final demoData = <String, dynamic>{
        'schema': 'public',
        'table': 'earthquake',
        'commit_timestamp': '2024-04-01T14:07:58.933Z',
        'eventType': 'INSERT',
        'new': {
          'arrival_time': '2024-04-01T23:05:00+09:00',
          'depth': 60,
          'epicenter_code': 161,
          'epicenter_detail_code': null,
          'event_id': 20240401230517,
          'headline': '　１日２３時０５分こ ろ、地震がありました。',
          'intensity_cities': [
            {'code': '0122300', 'maxInt': '1', 'name': '根室市'},
            {'code': '0166300', 'maxInt': '1', 'name': '浜中町'},
          ],
          'intensity_prefectures': [
            {'code': '01', 'maxInt': '1', 'name': '北海道'},
          ],
          'intensity_regions': [
            {'code': '161', 'maxInt': '1', 'name': '釧路地方中南部'},
            {'code': '167', 'maxInt': '1', 'name': '根室地方南部'},
          ],
          'intensity_stations': [
            {'code': '0122321', 'maxInt': '1', 'name': '根室市厚床＊'},
            {'code': '0166321', 'maxInt': '1', 'name': '浜中町茶内＊'},
          ],
          'latitude': 43,
          'longitude': 145,
          'lpgm_intensity_prefectures': null,
          'lpgm_intensity_regions': null,
          'lpgm_intenstiy_stations': null,
          'magnitude': 3.3,
          'magnitude_condition': null,
          'max_intensity': '1',
          'max_intensity_region_ids': [161, 167],
          'max_lpgm_intensity': null,
          'origin_time': '2024-04-01T23:05:00+09:00',
          'status': '通常',
          'text': 'この地震による津波の心配はありません。',
        },
        'old': <void, void>{},
        'errors': null,
      };
      // act
      final result = RealtimePostgresChangesPayloadBase.fromJson(demoData);
      // assert
      expect(result, isA<RealtimePostgresInsertPayload<EarthquakeV1>>());
    });
  });
}
