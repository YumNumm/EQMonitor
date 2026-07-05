import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_response.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

const _parameter = EarthquakeParameter(
  metadata: ParameterMetadata(
    type: ParameterType.jmaCodeTable,
    schemaVersion: 1,
    sourceVersion: 'test',
    sourceUpdatedAt: null,
    sourceUrls: [],
    sha256: 'test',
  ),
  prefectures: [],
);

api.HighestIntensityItem _apiItem({
  required String code,
  required String name,
  required api.JmaIntensity intensity,
}) => api.HighestIntensityItem(
  code: code,
  name: name,
  intensity: intensity,
  count: 3,
  earthquake: api.EarthquakePartial(
    eventId: 'evt-$code',
    status: api.TelegramStatus.normal,
    originTimePrecision: api.OriginTimePrecision.second,
    datasources: [api.EarthquakeDatasource.jmaDisasterInformationXml],
    telegramTypes: const [],
    earthquakeType: api.EarthquakeType.normal,
  ),
);

void main() {
  group('HighestIntensityItem.toAppEntry', () {
    test('HighestIntensityItem を HighestIntensityEntry に変換できる', () {
      final apiItem = _apiItem(
        code: '010101',
        name: 'テスト地域',
        intensity: api.JmaIntensity.value4,
      );
      final entry = apiItem.toAppEntry(parameter: _parameter);
      expect(entry.code, '010101');
      expect(entry.name, 'テスト地域');
      expect(entry.intensity, JmaIntensity.four);
      expect(entry.count, 3);
      expect(entry.earthquake.earthquake.eventId, 'evt-010101');
    });
  });

  group('HighestIntensityResponse.toAppResponse', () {
    test('items を HighestIntensityEntry のリストに変換して返す', () {
      final apiResponse = api.HighestIntensityResponse(
        aggregatedAt: DateTime.utc(2026),
        items: [
          _apiItem(
            code: '0100',
            name: '北海道',
            intensity: api.JmaIntensity.value5plus,
          ),
          _apiItem(
            code: '0200',
            name: '青森県',
            intensity: api.JmaIntensity.value3,
          ),
        ],
      );

      final result = apiResponse.toAppResponse(parameter: _parameter);

      expect(result.items.length, 2);
      expect(result.items[0].code, '0100');
      expect(result.items[0].intensity, JmaIntensity.fiveUpper);
      expect(result.items[1].code, '0200');
      expect(result.items[1].intensity, JmaIntensity.three);
    });
  });
}
