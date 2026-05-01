import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree_converter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:jma_parameter_types/earthquake_param.pb.dart';
import 'package:test/test.dart';

EarthquakeParameter _buildParameter({
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

api.Intensity _buildIntensity({
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

api.IntensityStationItem _station({
  required String code,
  required String name,
  api.JmaIntensity? maxIntensity,
  api.JmaLpgmIntensity? maxLpgm,
}) {
  return api.IntensityStationItem(
    value: api.CodeName(code: code, name: name),
    sva: 0,
    prePeriods: const [],
    maxIntensity: maxIntensity,
    maxLpgmIntensity: maxLpgm,
  );
}

void main() {
  group('convertToIntensityTree', () {
    test('空のデータの場合、空のMapを返す', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        prefectures: [],
        regions: [],
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
        prefectures: [
          (code: '040000', name: '宮城県', maxIntensity: api.JmaIntensity.value4),
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
        prefectures: [
          (
            code: '040000',
            name: '宮城県',
            maxIntensity: api.JmaIntensity.value5plus,
          ),
        ],
        regions: [
          (
            code: '0420100',
            name: '宮城県北部',
            maxIntensity: api.JmaIntensity.value5plus,
            maxLpgmIntensity: null,
          ),
          (
            code: '0420200',
            name: '宮城県南部',
            maxIntensity: api.JmaIntensity.value4,
            maxLpgmIntensity: null,
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

      // 震度5強と震度4の2グループが存在
      expect(result.keys.toList(), [JmaIntensity.fiveUpper, JmaIntensity.four]);

      // 震度5強グループ: 宮城県 -> 宮城県北部
      final group5Plus = result[JmaIntensity.fiveUpper]!;
      expect(group5Plus.length, 1);
      expect(group5Plus[0].region.region.name, '宮城県');
      expect(group5Plus[0].cities.length, 1);
      expect(group5Plus[0].cities[0].city.name, '宮城県北部');

      // 震度4グループ: 宮城県 -> 宮城県南部
      final group4 = result[JmaIntensity.four]!;
      expect(group4.length, 1);
      expect(group4[0].region.region.name, '宮城県');
      expect(group4[0].cities.length, 1);
      expect(group4[0].cities[0].city.name, '宮城県南部');
    });

    test('複数都道府県が同一震度グループに含まれる', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        prefectures: [
          (code: '040000', name: '宮城県', maxIntensity: api.JmaIntensity.value4),
          (code: '070000', name: '福島県', maxIntensity: api.JmaIntensity.value4),
        ],
        regions: [
          (
            code: '0420100',
            name: '宮城県北部',
            maxIntensity: api.JmaIntensity.value4,
            maxLpgmIntensity: null,
          ),
          (
            code: '0720100',
            name: '中通り',
            maxIntensity: api.JmaIntensity.value4,
            maxLpgmIntensity: null,
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
        prefectures: [
          (
            code: '040000',
            name: '宮城県',
            maxIntensity: api.JmaIntensity.value6minus,
          ),
        ],
        regions: [
          (
            code: '0420100',
            name: '宮城県北部',
            maxIntensity: api.JmaIntensity.value6minus,
            maxLpgmIntensity: null,
          ),
          (
            code: '0420200',
            name: '宮城県南部',
            maxIntensity: api.JmaIntensity.value4,
            maxLpgmIntensity: null,
          ),
          (
            code: '0420300',
            name: '宮城県中部',
            maxIntensity: api.JmaIntensity.value5minus,
            maxLpgmIntensity: null,
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
        prefectures: [
          (code: '040000', name: '宮城県', maxIntensity: api.JmaIntensity.value4),
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

    test('maxIntensityがnullのregionはスキップされる', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        prefectures: [
          (code: '040000', name: '宮城県', maxIntensity: api.JmaIntensity.value4),
        ],
        regions: [
          (
            code: '0420100',
            name: '宮城県北部',
            maxIntensity: null,
            maxLpgmIntensity: null,
          ),
          (
            code: '0420200',
            name: '宮城県南部',
            maxIntensity: api.JmaIntensity.value4,
            maxLpgmIntensity: null,
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

      expect(result.keys.toList(), [JmaIntensity.four]);
      expect(result[JmaIntensity.four]![0].cities.length, 1);
      expect(result[JmaIntensity.four]![0].cities[0].city.name, '宮城県南部');
    });

    test('regionsのみの場合はstationノードは空リスト', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value3,
        prefectures: [
          (code: '130000', name: '東京都', maxIntensity: api.JmaIntensity.value3),
        ],
        regions: [
          (
            code: '1310000',
            name: '東京都23区',
            maxIntensity: api.JmaIntensity.value3,
            maxLpgmIntensity: null,
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

    test('citiesフィールドがある場合は市区町村・観測点ツリーを優先する', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value3,
        prefectures: [
          (code: '130000', name: '東京都', maxIntensity: api.JmaIntensity.value3),
        ],
        regions: [
          (
            code: '1310000',
            name: '東京都23区_ regions側',
            maxIntensity: api.JmaIntensity.value3,
            maxLpgmIntensity: null,
          ),
        ],
      );
      final cities = [
        const api.IntensityItem(
          value: api.CodeName(code: '1310000', name: '東京都23区'),
          maxIntensity: api.JmaIntensity.value3,
          maxLpgmIntensity: api.JmaLpgmIntensity.value2,
        ),
      ];
      final stations = [
        _station(
          code: '13100000001',
          name: 'テスト観測点',
          maxIntensity: api.JmaIntensity.value3,
          maxLpgm: api.JmaLpgmIntensity.value2,
        ),
      ];
      final parameter = _buildParameter(
        regions: [
          (
            code: '130000',
            name: '東京都',
            cities: [
              (
                code: '1310000',
                name: '東京都23区',
                stations: [(code: '13100000001', name: 'テスト観測点')],
              ),
            ],
          ),
        ],
      );

      final result = IntensityTreeConverter(parameter: parameter)
          .convertToIntensityTree(
            intensity: intensity,
            cities: cities,
            stations: stations,
          );

      final cityNode = result[JmaIntensity.three]![0].cities[0];
      expect(cityNode.city.name, '東京都23区');
      expect(cityNode.maxLpgmIntensity, JmaLpgmIntensity.two);
      expect(cityNode.stations.length, 1);
      expect(cityNode.stations[0].station.name, 'テスト観測点');
      expect(cityNode.stations[0].intensity?.maxIntensity, JmaIntensity.three);
      expect(
        cityNode.stations[0].intensity?.maxLpgmIntensity,
        JmaLpgmIntensity.two,
      );
    });

    test('観測点の所属市区町村はパラメータで解決し、観測点自身の震度を保持する', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        prefectures: [
          (code: '130000', name: '東京都', maxIntensity: api.JmaIntensity.value4),
        ],
        regions: const [],
      );
      final cities = [
        const api.IntensityItem(
          value: api.CodeName(code: '1310000', name: '東京都23区'),
          maxIntensity: api.JmaIntensity.value4,
        ),
      ];
      final stations = [
        _station(
          code: '999999',
          name: '市区町村コード接頭辞と一致しない観測点',
          maxIntensity: api.JmaIntensity.value2,
        ),
      ];
      final parameter = _buildParameter(
        regions: [
          (
            code: '130000',
            name: '東京都',
            cities: [
              (
                code: '1310000',
                name: '東京都23区',
                stations: [(code: '999999', name: '市区町村コード接頭辞と一致しない観測点')],
              ),
            ],
          ),
        ],
      );

      final result = IntensityTreeConverter(parameter: parameter)
          .convertToIntensityTree(
            intensity: intensity,
            cities: cities,
            stations: stations,
          );

      final stationNode = result[JmaIntensity.four]![0].cities[0].stations[0];
      expect(stationNode.station.name, '市区町村コード接頭辞と一致しない観測点');
      expect(stationNode.intensity?.maxIntensity, JmaIntensity.two);
    });

    test('regionsが空でIntensity.citiesのみの場合もツリーが構築される', () {
      final cities = [
        const api.IntensityItem(
          value: api.CodeName(code: '1310000', name: '東京都23区'),
          maxIntensity: api.JmaIntensity.value3,
        ),
      ];
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value3,
        prefectures: [
          (code: '130000', name: '東京都', maxIntensity: api.JmaIntensity.value3),
        ],
        regions: [],
        cities: cities,
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

      expect(result.keys.toList(), [JmaIntensity.three]);
      expect(result[JmaIntensity.three]![0].cities[0].city.name, '東京都23区');
    });

    test('regions・citiesが空でprefecturesのみの場合は都道府県ノードのみ', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        prefectures: [
          (code: '040000', name: '宮城県', maxIntensity: api.JmaIntensity.value4),
        ],
        regions: [],
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

    test('max_intensityのみで子要素がすべて空の場合は空のMap', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        prefectures: [],
        regions: [],
      );
      final parameter = _buildParameter(regions: []);

      final result = IntensityTreeConverter(
        parameter: parameter,
      ).convertToIntensityTree(intensity: intensity);

      expect(result, isEmpty);
    });
  });

  group('convertToLpgmIntensityTree', () {
    test('空のデータの場合、空のMapを返す', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        prefectures: [],
        regions: [],
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
        prefectures: [
          (
            code: '040000',
            name: '宮城県',
            maxIntensity: api.JmaIntensity.value5plus,
          ),
        ],
        regions: [
          (
            code: '0420100',
            name: '宮城県北部',
            maxIntensity: api.JmaIntensity.value5plus,
            maxLpgmIntensity: api.JmaLpgmIntensity.value3,
          ),
          (
            code: '0420200',
            name: '宮城県南部',
            maxIntensity: api.JmaIntensity.value4,
            maxLpgmIntensity: api.JmaLpgmIntensity.value1,
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

    test('lpgmIntensityがnullのregionはスキップされる', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value4,
        prefectures: [
          (code: '040000', name: '宮城県', maxIntensity: api.JmaIntensity.value4),
        ],
        regions: [
          (
            code: '0420100',
            name: '宮城県北部',
            maxIntensity: api.JmaIntensity.value4,
            maxLpgmIntensity: null,
          ),
          (
            code: '0420200',
            name: '宮城県南部',
            maxIntensity: api.JmaIntensity.value3,
            maxLpgmIntensity: api.JmaLpgmIntensity.value2,
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

      expect(result.keys.toList(), [JmaLpgmIntensity.two]);
      expect(result[JmaLpgmIntensity.two]![0].cities.length, 1);
      expect(result[JmaLpgmIntensity.two]![0].cities[0].city.name, '宮城県南部');
    });

    test('LPGM震度キーは降順にソートされる', () {
      final intensity = _buildIntensity(
        maxIntensity: api.JmaIntensity.value5plus,
        maxLpgmIntensity: api.JmaLpgmIntensity.value4,
        prefectures: [
          (
            code: '040000',
            name: '宮城県',
            maxIntensity: api.JmaIntensity.value5plus,
          ),
          (code: '070000', name: '福島県', maxIntensity: api.JmaIntensity.value4),
        ],
        regions: [
          (
            code: '0420100',
            name: '宮城県北部',
            maxIntensity: api.JmaIntensity.value5plus,
            maxLpgmIntensity: api.JmaLpgmIntensity.value4,
          ),
          (
            code: '0420200',
            name: '宮城県南部',
            maxIntensity: api.JmaIntensity.value4,
            maxLpgmIntensity: api.JmaLpgmIntensity.value1,
          ),
          (
            code: '0720100',
            name: '中通り',
            maxIntensity: api.JmaIntensity.value4,
            maxLpgmIntensity: api.JmaLpgmIntensity.value2,
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
