import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:lat_lng/lat_lng.dart';
import 'package:test/test.dart';

const _testMetadata = ParameterMetadata(
  type: ParameterType.earthquakeStations,
  schemaVersion: 1,
  sourceVersion: '1.0',
  sourceUpdatedAt: null,
  generatedAt: '2024-01-01T00:00:00Z',
  sourceUrls: [],
  sha256: 'test_hash',
);

EarthquakeParameter _param({
  required List<
    ({
      String code,
      String name,
      List<
        ({
          String code,
          String name,
          List<({String code, String name})> stations,
        })
      >
      cities,
    })
  >
  regions,
}) {
  return EarthquakeParameter(
    metadata: _testMetadata,
    prefectures: [
      EarthquakeParameterPrefectureItem(
        code: 'test_pref',
        name: const LocalizedName(ja: 'テスト都道府県'),
        regions: regions
            .map(
              (r) => EarthquakeParameterRegionItem(
                code: r.code,
                name: LocalizedName(ja: r.name),
                kana: null,
                cities: r.cities
                    .map(
                      (c) => EarthquakeParameterCityItem(
                        code: c.code,
                        name: LocalizedName(ja: c.name),
                        kana: null,
                        stations: c.stations
                            .map(
                              (s) => EarthquakeParameterStationItem(
                                code: s.code,
                                noCode: s.code,
                                name: LocalizedName(ja: s.name),
                                kana: null,
                                status: EarthquakeStationStatus.operating,
                                sourceStatus: '',
                                owner: '',
                                location: const LatLng(0, 0),
                              ),
                            )
                            .toList(),
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      ),
    ],
  );
}

api.Intensity _intensity({
  required api.JmaIntensity maxIntensity,
  required List<api.IntensityTree> intensityTree,
}) {
  return api.Intensity(
    maxIntensity: maxIntensity,
    intensityTree: intensityTree,
  );
}

EarthquakeHistoryRepository _repository(EarthquakeParameter parameter) {
  return EarthquakeHistoryRepository(
    api: api.ApiClient(Dio()),
    earthquakeParameter: parameter,
  );
}

void main() {
  group('EarthquakeHistoryRepository.resolveCurrentLocationIntensity', () {
    test('市区町村コードで細分区域ノードに一致すれば震度を返す', () {
      final intensity = _intensity(
        maxIntensity: api.JmaIntensity.value4,
        intensityTree: const [
          api.IntensityTree(
            intensity: api.JmaIntensity.value4,
            regions: ['0420100'],
            stations: ['042010001'],
          ),
        ],
      );
      final parameter = _param(
        regions: [
          (
            code: '040000',
            name: '宮城県',
            cities: [
              (
                code: '0420100',
                name: '宮城県北部',
                stations: [(code: '042010001', name: '仙台観測点')],
              ),
            ],
          ),
        ],
      );
      final converter = IntensityTreeConverter(parameter: parameter);
      final regions = converter.convertToRegionIntensityTree(
        intensity: intensity,
      );
      final tree = converter.convertToIntensityTree(intensity: intensity);

      final r = _repository(parameter).resolveCurrentLocationIntensity(
        regions: regions,
        intensityTree: tree,
        cityAreaCode: '0420100',
        regionAreaCode: null,
      );

      expect(r, isNotNull);
      expect(r!.intensity, JmaIntensity.four);
      expect(r.usedCityLevelData, isTrue);
    });

    test('市区町村に無く細分区域コードでフォールバックする', () {
      final intensity = _intensity(
        maxIntensity: api.JmaIntensity.value4,
        intensityTree: const [
          api.IntensityTree(
            intensity: api.JmaIntensity.value4,
            regions: ['0420100'],
          ),
        ],
      );
      final parameter = _param(
        regions: [
          (
            code: '0420100',
            name: '宮城県',
            cities: [(code: '0420100', name: '宮城県北部', stations: const [])],
          ),
        ],
      );
      final converter = IntensityTreeConverter(parameter: parameter);
      final regions = converter.convertToRegionIntensityTree(
        intensity: intensity,
      );
      final tree = converter.convertToIntensityTree(intensity: intensity);

      final r = _repository(parameter).resolveCurrentLocationIntensity(
        regions: regions,
        intensityTree: tree,
        cityAreaCode: '9999999',
        regionAreaCode: '0420100',
      );

      expect(r, isNotNull);
      expect(r!.intensity, JmaIntensity.four);
      expect(r.usedCityLevelData, isFalse);
    });

    test('prefecturesのみのツリーでは都道府県コードで解決する', () {
      final intensity = _intensity(
        maxIntensity: api.JmaIntensity.value4,
        intensityTree: const [
          api.IntensityTree(
            intensity: api.JmaIntensity.value4,
            regions: ['040000'],
          ),
        ],
      );
      final parameter = _param(
        regions: [
          (
            code: '040000',
            name: '宮城県',
            cities: [
              (code: '0420100', name: '宮城県北部', stations: const []),
            ],
          ),
        ],
      );
      final converter = IntensityTreeConverter(parameter: parameter);
      final regions = converter.convertToRegionIntensityTree(
        intensity: intensity,
      );
      final tree = converter.convertToIntensityTree(intensity: intensity);

      final r = _repository(parameter).resolveCurrentLocationIntensity(
        regions: regions,
        intensityTree: tree,
        cityAreaCode: '040000',
        regionAreaCode: null,
      );

      expect(r, isNotNull);
      expect(r!.intensity, JmaIntensity.four);
      expect(r.usedCityLevelData, isFalse);
    });
  });
}
