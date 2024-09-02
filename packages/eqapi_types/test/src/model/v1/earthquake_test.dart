import 'dart:convert';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:test/test.dart';

void main() {
  group(
    'EarthquakeV1',
    () {
      final json = <String, dynamic>{
        'event_id': 20240222185554,
        'status': '通常',
        'magnitude': 2,
        'magnitude_condition': null,
        'max_intensity': '1',
        'max_lpgm_intensity': null,
        'depth': 10,
        'latitude': 37.5,
        'longitude': 137.2,
        'epicenter_code': 390,
        'epicenter_detail_code': null,
        'arrival_time': '2024-02-22T09:55:00.000Z',
        'origin_time': '2024-02-22T09:55:00.000Z',
        'headline': '２２日１８時５５分ころ、地震がありました。',
        'text': 'この地震による津波の心配はありません。',
        'max_intensity_region_ids': [390],
        'intensity_regions': [
          {'code': '390', 'name': '石川県能登', 'maxInt': '1'},
        ],
        'intensity_prefectures': [
          {'code': '17', 'name': '石川県', 'maxInt': '1'},
        ],
        'intensity_cities': [
          {'code': '1720500', 'name': '珠洲市', 'maxInt': '1'},
        ],
        'intensity_stations': [
          {'code': '1720521', 'name': '珠洲市大谷町＊', 'maxInt': '1'},
        ],
        'lpgm_intensity_prefectures': null,
        'lpgm_intensity_regions': null,
        'lpgm_intenstiy_stations': null,
      };
      test(
        'fromJsonが正常に動作すること',
        () {
          // Arrange
          // Act
          final object = EarthquakeV1.fromJson(json);
          // Assert
          expect(object, isNotNull);
          expect(object.eventId, 20240222185554);
          expect(object.status, '通常');
          expect(object.magnitude, 2);
          expect(object.magnitudeCondition, null);
          expect(object.maxIntensity, JmaIntensity.one);
          expect(object.maxLpgmIntensity, null);
          expect(object.depth, 10);
          expect(object.latitude, 37.5);
          expect(object.longitude, 137.2);
          expect(object.epicenterCode, 390);
          expect(object.epicenterDetailCode, null);
          expect(
            object.arrivalTime,
            DateTime.parse('2024-02-22T09:55:00.000Z'),
          );
          expect(
            object.originTime,
            DateTime.parse('2024-02-22T09:55:00.000Z'),
          );
          expect(object.headline, '２２日１８時５５分ころ、地震がありました。');
          expect(object.text, 'この地震による津波の心配はありません。');
          expect(object.maxIntensityRegionIds, [390]);
          expect(
            object.intensityRegions?.first,
            const ObservedRegionIntensity(
              code: '390',
              name: '石川県能登',
              intensity: JmaIntensity.one,
            ),
          );
          expect(
            object.intensityPrefectures?.first,
            const ObservedRegionIntensity(
              code: '17',
              name: '石川県',
              intensity: JmaIntensity.one,
            ),
          );
          expect(
            object.intensityCities?.first,
            const ObservedRegionIntensity(
              code: '1720500',
              name: '珠洲市',
              intensity: JmaIntensity.one,
            ),
          );
          expect(
            object.intensityStations?.first,
            const ObservedRegionIntensity(
              code: '1720521',
              name: '珠洲市大谷町＊',
              intensity: JmaIntensity.one,
            ),
          );
          expect(object.lpgmIntensityPrefectures, null);
          expect(object.lpgmIntensityRegions, null);
          expect(object.lpgmIntenstiyStations, null);
        },
      );
      test('fromJsonの元JSONは、toJsonで再変換できること', () {
        // Arrange
        final object = EarthquakeV1.fromJson(json);
        // Act
        final json2 = jsonEncode(object.toJson());
        // Assert
        expect(json, jsonDecode(json2));
      });
    },
  );
}
