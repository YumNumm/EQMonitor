import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree_converter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:test/test.dart';

final _testMetadata = ParameterMetadata(
  type: ParameterType.earthquakeStations,
  schemaVersion: '1.0',
  sourceVersion: '1.0',
  sourceUpdatedAt: null,
  generatedAt: '2024-01-01T00:00:00Z',
  sourceUrls: const [],
  sha256: 'test_hash',
);

EarthquakeParameter _buildParameter({
  required List<
    ({
      String code,
      String name,
      List<({String code, String name, List<({String code, String name})> stations})> cities,
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
        regions: regions.map(
          (r) => EarthquakeParameterRegionItem(
            code: r.code,
            name: LocalizedName(ja: r.name),
            kana: null,
            cities: r.cities.map(
              (c) => EarthquakeParameterCityItem(
                code: c.code,
                name: LocalizedName(ja: c.name),
                kana: null,
                stations: const [],
              ),
            ).toList(),
          ),
        ).toList(),
      ),
    ],
  );
}

api.Intensity _buildIntensity({
  required api.JmaIntensity maxIntensity,
  required List<api.IntensityTree> intensityTree,
  api.JmaLpgmIntensity? maxLpgmIntensity,
  List<api.LpgmIntensityTree>? lpgmIntensityTree,
}) {
  return api.Intensity(
    maxIntensity: maxIntensity,
    maxLpgmIntensity: maxLpgmIntensity,
    intensityTree: intensityTree,
    lpgmIntensityTree: lpgmIntensityTree,
  );
}

api.IntensityTree _jmaTree({
  required api.JmaIntensity intensity,
  required List<String> regions,
  List<String>? stations,
}) {
  return api.IntensityTree(
    intensity: intensity,
    regions: regions,
    stations: stations,
  );
}

void main() {
  group('convertToIntensityTree', () {
    test('空の intensity_tree の場合、空のMapを返す', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        intensityTree: [],
      );
      final parameter = _buildParameter(regions: []);

      final result = IntensityTreeConverter(
        parameter: parameter,
      ).convertToIntensityTree(intensity: intensity);

      expect(result, isEmpty);
    });

    test('1都道府県・1地域の場合、正しくツリーが構築される', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        intensityTree: [
          _jmaTree(
            intensity: api.JmaIntensity.value4,
            regions: ['0420100'],
          ),
        ],
      );
      final parameter = _buildParameter(
        regions: [
          (
            code: '040000',
            name: '宮城県',
            cities: [(code: '0420100', name: '宮城県北部', stations: const [])],
          ),
        ],
      );

      final result = IntensityTreeConverter(
        parameter: parameter,
      ).convertToIntensityTree(intensity: intensity);

      expect(result.keys.toList(), [JmaIntensity.four]);
      expect(result[JmaIntensity.four]!.length, 1);
      expect(result[JmaIntensity.four]![0].region.region.name, '宮城県');
      expect(
        result[JmaIntensity.four]![0].region.maxIntensity,
        JmaIntensity.four,
      );
      expect(result[JmaIntensity.four]![0].cities.length, 1);
      expect(result[JmaIntensity.four]![0].cities[0].city.name, '宮城県北部');
      expect(
        result[JmaIntensity.four]![0].cities[0].maxIntensity,
        JmaIntensity.four,
      );
    });

    test('同じ都道府県が複数の震度グループに出現する', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value5plus,
        intensityTree: [
          _jmaTree(
            intensity: api.JmaIntensity.value5plus,
            regions: ['0420100'],
          ),
          _jmaTree(
            intensity: api.JmaIntensity.value4,
            regions: ['0420200'],
          ),
        ],
      );
      final parameter = _buildParameter(
        regions: [
          (
            code: '040000',
            name: '宮城県',
            cities: [
              (code: '0420100', name: '宮城県北部', stations: const []),
              (code: '0420200', name: '宮城県南部', stations: const []),
            ],
          ),
        ],
      );

      final result = IntensityTreeConverter(
        parameter: parameter,
      ).convertToIntensityTree(intensity: intensity);

      expect(result.keys.toList(), [JmaIntensity.fiveUpper, JmaIntensity.four]);

      final group5Plus = result[JmaIntensity.fiveUpper]!;
      expect(group5Plus.length, 1);
      expect(group5Plus[0].region.region.name, '宮城県');
      expect(group5Plus[0].cities.length, 1);
      expect(group5Plus[0].cities[0].city.name, '宮城県北部');

      final group4 = result[JmaIntensity.four]!;
      expect(group4.length, 1);
      expect(group4[0].region.region.name, '宮城県');
      expect(group4[0].cities.length, 1);
      expect(group4[0].cities[0].city.name, '宮城県南部');
    });

    test('複数都道府県が同一震度グループに含まれる', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        intensityTree: [
          _jmaTree(
            intensity: api.JmaIntensity.value4,
            regions: ['0420100', '0720100'],
          ),
        ],
      );
      final parameter = _buildParameter(
        regions: [
          (
            code: '040000',
            name: '宮城県',
            cities: [(code: '0420100', name: '宮城県北部', stations: const [])],
          ),
          (
            code: '070000',
            name: '福島県',
            cities: [(code: '0720100', name: '中通り', stations: const [])],
          ),
        ],
      );

      final result = IntensityTreeConverter(
        parameter: parameter,
      ).convertToIntensityTree(intensity: intensity);

      expect(result.keys.toList(), [JmaIntensity.four]);
      expect(result[JmaIntensity.four]!.length, 2);

      final regionNames = result[JmaIntensity.four]!
          .map((r) => r.region.region.name)
          .toList();
      expect(regionNames, contains('宮城県'));
      expect(regionNames, contains('福島県'));
    });

    test('震度キーは降順にソートされる', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value6minus,
        intensityTree: [
          _jmaTree(
            intensity: api.JmaIntensity.value6minus,
            regions: ['0420100'],
          ),
          _jmaTree(
            intensity: api.JmaIntensity.value4,
            regions: ['0420200'],
          ),
          _jmaTree(
            intensity: api.JmaIntensity.value5minus,
            regions: ['0420300'],
          ),
        ],
      );
      final parameter = _buildParameter(
        regions: [
          (
            code: '040000',
            name: '宮城県',
            cities: [
              (code: '0420100', name: '宮城県北部', stations: const []),
              (code: '0420200', name: '宮城県南部', stations: const []),
              (code: '0420300', name: '宮城県中部', stations: const []),
            ],
          ),
        ],
      );

      final result = IntensityTreeConverter(
        parameter: parameter,
      ).convertToIntensityTree(intensity: intensity);

      final keys = result.keys.toList();
      expect(keys, [
        JmaIntensity.sixLower,
        JmaIntensity.fiveLower,
        JmaIntensity.four,
      ]);
    });

    test('regionsに存在しないcityコードはスキップされる', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        intensityTree: [
          _jmaTree(
            intensity: api.JmaIntensity.value4,
            regions: ['0420100'],
          ),
        ],
      );
      final parameter = _buildParameter(
        regions: [
          (
            code: '040000',
            name: '宮城県',
            cities: [
              (code: '0420100', name: '宮城県北部', stations: const []),
              (code: '9999999', name: '存在しない地域', stations: const []),
            ],
          ),
        ],
      );

      final result = IntensityTreeConverter(
        parameter: parameter,
      ).convertToIntensityTree(intensity: intensity);

      expect(result[JmaIntensity.four]![0].cities.length, 1);
      expect(result[JmaIntensity.four]![0].cities[0].city.name, '宮城県北部');
    });

    test('regionsのみの場合はstationノードは空リスト', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value3,
        intensityTree: [
          _jmaTree(
            intensity: api.JmaIntensity.value3,
            regions: ['1310000'],
          ),
        ],
      );
      final parameter = _buildParameter(
        regions: [
          (
            code: '130000',
            name: '東京都',
            cities: [(code: '1310000', name: '東京都23区', stations: const [])],
          ),
        ],
      );

      final result = IntensityTreeConverter(
        parameter: parameter,
      ).convertToIntensityTree(intensity: intensity);

      expect(result[JmaIntensity.three]![0].cities[0].stations, isEmpty);
    });

    test('観測点コードはパラメータで市区町村に紐づけられる', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        intensityTree: [
          _jmaTree(
            intensity: api.JmaIntensity.value4,
            regions: ['1310000'],
            stations: ['999999'],
          ),
        ],
      );
      final parameter = _buildParameter(
        regions: [
          (
            code: '130000',
            name: '東京都',
            cities: [
              (
                code: '1310000',
                name: '東京都23区',
                stations: [(code: '999999', name: 'テスト観測点')],
              ),
            ],
          ),
        ],
      );

      final result = IntensityTreeConverter(parameter: parameter)
          .convertToIntensityTree(intensity: intensity);

      final stationNode = result[JmaIntensity.four]![0].cities[0].stations[0];
      expect(stationNode.station.name, 'テスト観測点');
      expect(stationNode.intensity?.maxIntensity, JmaIntensity.four);
    });

    test('都道府県コードのみのツリーでは都道府県ノードのみ', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        intensityTree: [
          _jmaTree(
            intensity: api.JmaIntensity.value4,
            regions: ['040000'],
          ),
        ],
      );
      final parameter = _buildParameter(
        regions: [
          (
            code: '040000',
            name: '宮城県',
            cities: [(code: '0420100', name: '宮城県北部', stations: const [])],
          ),
        ],
      );

      final result = IntensityTreeConverter(
        parameter: parameter,
      ).convertToIntensityTree(intensity: intensity);

      expect(result.keys.toList(), [JmaIntensity.four]);
      expect(result[JmaIntensity.four]![0].region.region.name, '宮城県');
      expect(result[JmaIntensity.four]![0].cities, isEmpty);
    });
  });

  group('convertToLpgmIntensityTree', () {
    test('空のデータの場合、空のMapを返す', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        intensityTree: [],
        lpgmIntensityTree: const [],
      );
      final parameter = _buildParameter(regions: []);

      final result = IntensityTreeConverter(
        parameter: parameter,
      ).convertToLpgmIntensityTree(intensity: intensity);

      expect(result, isEmpty);
    });

    test('LPGM震度でグループ化される', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value5plus,
        maxLpgmIntensity: api.JmaLpgmIntensity.value3,
        intensityTree: [],
        lpgmIntensityTree: const [
          api.LpgmIntensityTree(
            lpgmIntensity: api.JmaLpgmIntensity.value3,
            regions: ['0420100'],
            stations: [],
          ),
          api.LpgmIntensityTree(
            lpgmIntensity: api.JmaLpgmIntensity.value1,
            regions: ['0420200'],
            stations: [],
          ),
        ],
      );
      final parameter = _buildParameter(
        regions: [
          (
            code: '040000',
            name: '宮城県',
            cities: [
              (code: '0420100', name: '宮城県北部', stations: const []),
              (code: '0420200', name: '宮城県南部', stations: const []),
            ],
          ),
        ],
      );

      final result = IntensityTreeConverter(
        parameter: parameter,
      ).convertToLpgmIntensityTree(intensity: intensity);

      expect(result.keys.toList(), [
        JmaLpgmIntensity.three,
        JmaLpgmIntensity.one,
      ]);

      final group3 = result[JmaLpgmIntensity.three]!;
      expect(group3.length, 1);
      expect(group3[0].region.name, '宮城県');
      expect(group3[0].cities.length, 1);
      expect(group3[0].cities[0].city.name, '宮城県北部');

      final group1 = result[JmaLpgmIntensity.one]!;
      expect(group1.length, 1);
      expect(group1[0].cities[0].city.name, '宮城県南部');
    });

    test('LPGM震度キーは降順にソートされる', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value5plus,
        maxLpgmIntensity: api.JmaLpgmIntensity.value4,
        intensityTree: [],
        lpgmIntensityTree: const [
          api.LpgmIntensityTree(
            lpgmIntensity: api.JmaLpgmIntensity.value4,
            regions: ['0420100'],
            stations: [],
          ),
          api.LpgmIntensityTree(
            lpgmIntensity: api.JmaLpgmIntensity.value1,
            regions: ['0420200'],
            stations: [],
          ),
          api.LpgmIntensityTree(
            lpgmIntensity: api.JmaLpgmIntensity.value2,
            regions: ['0720100'],
            stations: [],
          ),
        ],
      );
      final parameter = _buildParameter(
        regions: [
          (
            code: '040000',
            name: '宮城県',
            cities: [
              (code: '0420100', name: '宮城県北部', stations: const []),
              (code: '0420200', name: '宮城県南部', stations: const []),
            ],
          ),
          (
            code: '070000',
            name: '福島県',
            cities: [(code: '0720100', name: '中通り', stations: const [])],
          ),
        ],
      );

      final result = IntensityTreeConverter(
        parameter: parameter,
      ).convertToLpgmIntensityTree(intensity: intensity);

      final keys = result.keys.toList();
      expect(keys, [
        JmaLpgmIntensity.four,
        JmaLpgmIntensity.two,
        JmaLpgmIntensity.one,
      ]);
    });
  });
}
