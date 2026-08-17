import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/jma_code_table/jma_code_table_parameter.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/notification_region_catalog_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

const metadata = ParameterMetadata(
  type: ParameterType.jmaCodeTable,
  schemaVersion: 1,
  sourceVersion: 'test',
  sourceUpdatedAt: null,
  sourceUrls: [],
  sha256: 'test',
);

LocalizedName name(String value) => LocalizedName(ja: value);

EarthquakeParameterStationItem station(String code) =>
    EarthquakeParameterStationItem(
      code: code,
      noCode: code,
      name: name('観測点$code'),
      kana: null,
      status: EarthquakeStationStatus.operating,
      sourceStatus: 'OPERATING',
      owner: 'test',
      location: const LatLng(35, 135),
    );

EarthquakeParameterCityItem city({
  required String code,
  required String cityName,
  required List<String> stationCodes,
}) => EarthquakeParameterCityItem(
  code: code,
  name: name(cityName),
  kana: '$cityName-kana',
  stations: stationCodes.map(station).toList(),
);

void main() {
  test('観測点の親EEW regionへ正しい市区町村を重複なく結合する', () {
    final codeTable = JmaCodeTableParameter(
      metadata: metadata,
      codeTables: JmaCodeTableCodeTables(
        areaForecastLocalEew: [
          JmaCodeTableItem(
            code: '100',
            name: name('地域A'),
            kana: 'ちいきえー',
            description: null,
          ),
          JmaCodeTableItem(
            code: '200',
            name: name('地域B'),
            kana: 'ちいきびー',
            description: null,
          ),
        ],
        areaInformationPrefectureEarthquake: const [],
        areaInformationCity: [
          JmaCodeTableCityItem(
            code: 'station-a',
            name: name('観測点A'),
            parentAreaForecastLocalEewCode: '100',
            parentAreaInformationPrefectureEarthquakeCode: '01',
          ),
          JmaCodeTableCityItem(
            code: 'station-b',
            name: name('観測点B'),
            parentAreaForecastLocalEewCode: '100',
            parentAreaInformationPrefectureEarthquakeCode: '01',
          ),
          JmaCodeTableCityItem(
            code: 'station-c',
            name: name('観測点C'),
            parentAreaForecastLocalEewCode: '200',
            parentAreaInformationPrefectureEarthquakeCode: '01',
          ),
        ],
        areaEpicenter: const [],
        areaEpicenterAbbreviation: const [],
        areaEpicenterDetail: const [],
      ),
    );
    final earthquake = EarthquakeParameter(
      metadata: metadata,
      prefectures: [
        EarthquakeParameterPrefectureItem(
          code: '01',
          name: name('県'),
          regions: [
            EarthquakeParameterRegionItem(
              code: '10',
              name: name('一次細分区域'),
              kana: null,
              cities: [
                city(
                  code: 'city-1',
                  cityName: '正しい市名',
                  stationCodes: ['station-a', 'station-b'],
                ),
                city(
                  code: 'city-2',
                  cityName: '複数地域市',
                  stationCodes: ['station-a', 'station-c'],
                ),
                city(
                  code: 'city-unmapped',
                  cityName: '未対応市',
                  stationCodes: ['station-unknown'],
                ),
              ],
            ),
          ],
        ),
      ],
    );

    final catalog = const NotificationRegionCatalogBuilder().build(
      codeTable: codeTable,
      earthquake: earthquake,
    );

    expect(catalog.regionByCode('100')?.cities.map((item) => item.name), [
      '正しい市名',
      '複数地域市',
    ]);
    expect(catalog.regionByCode('200')?.cities.map((item) => item.name), [
      '複数地域市',
    ]);
    expect(
      catalog.regionByCode('100')?.cityByCode('city-1')?.kana,
      '正しい市名-kana',
    );
    expect(catalog.unmappedCityCodes, ['city-unmapped']);
  });
}
