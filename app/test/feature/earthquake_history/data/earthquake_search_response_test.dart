import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('市区町村レスポンスは市区町村震度と地震最大震度を分けて変換する', () {
    final response = api.IntensityCitySearchResponse.fromJson({
      'items': [
        {
          'event_id': '20260824000000',
          'intensity': '2',
          'earthquake': {
            'event_id': '20260824000000',
            'status': 'NORMAL',
            'origin_time_precision': 'SECOND',
            'intensity': {'max_intensity': '4'},
            'datasources': ['JMA_DISASTER_INFORMATION_XML'],
            'telegram_types': ['VXSE53'],
            'earthquake_type': 'NORMAL',
          },
        },
      ],
    });

    final result = response.toAppResponse(
      cityItem: _city,
      parameter: _earthquakeParameter,
    );
    final item = result.items.single;

    expect(item, isA<EarthquakePartialCity>());
    expect(item.cityIntensity, JmaIntensity.two);
    expect(item.earthquake.intensity?.maxIntensity, JmaIntensity.four);
  });
}

const _metadata = ParameterMetadata(
  type: ParameterType.jmaCodeTable,
  schemaVersion: 1,
  sourceVersion: 'test',
  sourceUpdatedAt: null,
  sourceUrls: [],
  sha256: 'test',
);

const _city = EarthquakeParameterCityItem(
  code: '0110110',
  name: LocalizedName(ja: '札幌市中央区'),
  kana: null,
  stations: [],
);

const _earthquakeParameter = EarthquakeParameter(
  metadata: _metadata,
  prefectures: [],
);
