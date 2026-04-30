import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:jma_parameter_types/earthquake_param.pb.dart';
import 'package:test/test.dart';

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
    regions: regions.map(
      (r) => EarthquakeParameterRegionItem(
        code: r.code,
        name: r.name,
        cities: r.cities.map(
          (c) => EarthquakeParameterCityItem(
            code: c.code,
            name: c.name,
            stations: c.stations.map(
              (s) => EarthquakeParameterStationItem(code: s.code, name: s.name),
            ),
          ),
        ),
      ),
    ),
  );
}

api.Intensity _intensity({
  required api.JmaIntensity maxIntensity,
  required List<({String code, String name, api.JmaIntensity? maxIntensity})>
  prefectures,
  required List<
    ({
      String code,
      String name,
      api.JmaIntensity? maxIntensity,
      api.JmaLpgmIntensity? maxLpgmIntensity,
    })
  >
  regions,
  api.JmaLpgmIntensity? maxLpgmIntensity,
  List<api.IntensityItem>? cities,
  List<api.IntensityStationItem>? stations,
}) {
  return api.Intensity(
    maxIntensity: maxIntensity,
    maxLpgmIntensity: maxLpgmIntensity,
    prefectures: prefectures
        .map(
          (p) => api.IntensityItem(
            value: api.CodeName(code: p.code, name: p.name),
            maxIntensity: p.maxIntensity,
          ),
        )
        .toList(),
    regions: regions
        .map(
          (r) => api.IntensityItem(
            value: api.CodeName(code: r.code, name: r.name),
            maxIntensity: r.maxIntensity,
            maxLpgmIntensity: r.maxLpgmIntensity,
          ),
        )
        .toList(),
    cities: cities,
    stations: stations,
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
        prefectures: [
          (
            code: '040000',
            name: '宮城県',
            maxIntensity: api.JmaIntensity.value4,
          ),
        ],
        regions: [
          (
            code: '0420100',
            name: '宮城県北部',
            maxIntensity: api.JmaIntensity.value4,
            maxLpgmIntensity: null,
          ),
        ],
      );
      final parameter = _param(
        regions: [
          (
            code: '040000',
            name: '宮城県',
            cities: [(code: '0420100', name: '宮城県北部', stations: const [])],
          ),
        ],
      );
      final tree = IntensityTreeConverter(parameter: parameter)
          .convertToIntensityTree(intensity: intensity);

      final r = _repository(parameter).resolveCurrentLocationIntensity(
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
        prefectures: [
          (
            code: '040000',
            name: '宮城県',
            maxIntensity: api.JmaIntensity.value4,
          ),
        ],
        regions: [
          (
            code: '0420100',
            name: '宮城県北部',
            maxIntensity: api.JmaIntensity.value4,
            maxLpgmIntensity: null,
          ),
        ],
      );
      final parameter = _param(
        regions: [
          (
            code: '040000',
            name: '宮城県',
            cities: [(code: '0420100', name: '宮城県北部', stations: const [])],
          ),
        ],
      );
      final tree = IntensityTreeConverter(parameter: parameter)
          .convertToIntensityTree(intensity: intensity);

      final r = _repository(parameter).resolveCurrentLocationIntensity(
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
        prefectures: [
          (
            code: '040000',
            name: '宮城県',
            maxIntensity: api.JmaIntensity.value4,
          ),
        ],
        regions: [],
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
      final tree = IntensityTreeConverter(parameter: parameter)
          .convertToIntensityTree(intensity: intensity);

      final r = _repository(parameter).resolveCurrentLocationIntensity(
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
