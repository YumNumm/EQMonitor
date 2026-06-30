import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree_converter.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

void main() {
  group('IntensityTreeConverter.convertToLpgmIntensityTree', () {
    test('観測点の SVA と周期別階級を保持する', () {
      const converter = IntensityTreeConverter(parameter: _parameter);
      const intensity = api.Intensity(
        maxIntensity: api.JmaIntensity.value1,
        intensityTree: [],
        maxLpgmIntensity: api.JmaLpgmIntensity.value3,
        lpgmIntensityTree: [
          api.LpgmIntensityTree(
            lpgmIntensity: api.JmaLpgmIntensity.value3,
            regions: [],
            stations: [
              api.IntensityStationItem(
                code: _stationCode,
                sva: 123.4,
                prePeriods: [
                  api.LpgmPrePeriod(
                    band: 1,
                    lpgmIntensity: api.JmaLpgmIntensity.value2,
                    sva: 45.6,
                  ),
                  api.LpgmPrePeriod(
                    band: 2,
                    lpgmIntensity: api.JmaLpgmIntensity.value3,
                    sva: 78.9,
                  ),
                ],
              ),
            ],
          ),
        ],
      );

      final result = converter.convertToLpgmIntensityTree(
        intensity: intensity,
      );

      final nodes = result[JmaLpgmIntensity.three];
      expect(nodes, hasLength(1));
      final stationNode = nodes?.single.cities.single.stations.single;
      expect(stationNode?.intensity?.sva, 123.4);
      expect(stationNode?.intensity?.maxLpgmIntensity, JmaLpgmIntensity.three);
      final prePeriods = stationNode?.intensity?.prePeriods;
      expect(prePeriods, hasLength(2));
      expect(prePeriods?.first.band, 1);
      expect(prePeriods?.first.lpgmIntensity, JmaLpgmIntensity.two);
      expect(prePeriods?.first.sva, 45.6);
      expect(prePeriods?.last.band, 2);
      expect(prePeriods?.last.lpgmIntensity, JmaLpgmIntensity.three);
      expect(prePeriods?.last.sva, 78.9);
    });
  });
}

const _stationCode = '001001001';

const _parameter = EarthquakeParameter(
  metadata: ParameterMetadata(
    type: ParameterType.earthquakeStations,
    schemaVersion: 1,
    sourceVersion: 'test',
    sourceUpdatedAt: null,
    sourceUrls: [],
    sha256: 'test',
  ),
  prefectures: [
    EarthquakeParameterPrefectureItem(
      code: '01',
      name: LocalizedName(ja: 'テスト都道府県'),
      regions: [
        EarthquakeParameterRegionItem(
          code: '001',
          name: LocalizedName(ja: 'テスト地方'),
          kana: null,
          cities: [
            EarthquakeParameterCityItem(
              code: '001001',
              name: LocalizedName(ja: 'テスト市区町村'),
              kana: null,
              stations: [
                EarthquakeParameterStationItem(
                  code: _stationCode,
                  noCode: _stationCode,
                  name: LocalizedName(ja: 'テスト観測点'),
                  kana: null,
                  status: EarthquakeStationStatus.operating,
                  sourceStatus: 'test',
                  owner: 'test',
                  location: LatLng(0, 0),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
