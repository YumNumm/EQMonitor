import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CityMaxIntensityItem.toAppEntry', () {
    test('city_id / max_intensity をアプリのモデルに変換できる', () {
      const apiItem = api.CityMaxIntensityItem(
        cityId: '0110000',
        maxIntensity: api.JmaIntensity.value5minus,
      );

      final entry = apiItem.toAppEntry();

      expect(entry.cityCode, '0110000');
      expect(entry.intensity, JmaIntensity.fiveLower);
    });
  });

  group('CityMaxIntensityResponse.toAppModel', () {
    test('response_at と items を変換して返す', () {
      final apiResponse = api.CityMaxIntensityResponse(
        responseAt: DateTime.utc(2026, 8, 19, 12),
        items: const [
          api.CityMaxIntensityItem(
            cityId: '0110000',
            maxIntensity: api.JmaIntensity.value5minus,
          ),
          api.CityMaxIntensityItem(
            cityId: '0410000',
            maxIntensity: api.JmaIntensity.value3,
          ),
        ],
      );

      final result = apiResponse.toAppModel();

      expect(result.responseAt, DateTime.utc(2026, 8, 19, 12));
      expect(result.items.length, 2);
      expect(result.items[0].cityCode, '0110000');
      expect(result.items[0].intensity, JmaIntensity.fiveLower);
      expect(result.items[1].cityCode, '0410000');
      expect(result.items[1].intensity, JmaIntensity.three);
    });

    test('response_at が null でも items を返す', () {
      const apiResponse = api.CityMaxIntensityResponse(
        responseAt: null,
        items: [
          api.CityMaxIntensityItem(
            cityId: '0110000',
            maxIntensity: api.JmaIntensity.value4,
          ),
        ],
      );

      final result = apiResponse.toAppModel();

      expect(result.responseAt, isNull);
      expect(result.items.single.intensity, JmaIntensity.four);
    });
  });

  group('CityMaxIntensity', () {
    const model = CityMaxIntensity(
      responseAt: null,
      items: [
        CityMaxIntensityEntry(
          cityCode: '0110000',
          intensity: JmaIntensity.fiveLower,
        ),
        CityMaxIntensityEntry(
          cityCode: '0110100',
          intensity: JmaIntensity.sixLower,
        ),
      ],
    );

    test('intensityOfCity は該当市区町村の震度を返す', () {
      expect(model.intensityOfCity('0110100'), JmaIntensity.sixLower);
    });

    test('intensityOfCity は観測実績が無ければ null を返す', () {
      expect(model.intensityOfCity('9999999'), isNull);
    });
  });
}
