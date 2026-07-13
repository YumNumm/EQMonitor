import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_fill_layer.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:test/test.dart';

void main() {
  group('computeShindoDbFillCodes', () {
    test('複数階級に登場する市区町村は最大階級にのみ含まれる', () {
      // 市区町村 01100 は階級 3・4 の両方に観測点を持つ
      final tree = _tree({
        ShindoDbIntensityClass.four: [
          _prefNode([_cityNode('01100', '010100')]),
        ],
        ShindoDbIntensityClass.three: [
          _prefNode([
            _cityNode('01100', '010100'),
            _cityNode('01200', '010200'),
          ]),
        ],
      });

      final codes = computeShindoDbFillCodes(tree);

      expect(codes[ShindoDbIntensityClass.four]?.cityCodes, ['01100']);
      expect(codes[ShindoDbIntensityClass.three]?.cityCodes, ['01200']);
    });

    test('複数階級に登場する細分区域は最大階級にのみ含まれる', () {
      final tree = _tree({
        ShindoDbIntensityClass.four: [
          _prefNode([_cityNode('01100', '010100')]),
        ],
        ShindoDbIntensityClass.three: [
          _prefNode([
            _cityNode('01200', '010100'),
            _cityNode('01300', '010200'),
          ]),
        ],
      });

      final codes = computeShindoDbFillCodes(tree);

      expect(codes[ShindoDbIntensityClass.four]?.regionCodes, ['010100']);
      expect(codes[ShindoDbIntensityClass.three]?.regionCodes, ['010200']);
    });

    test('低階級→高階級の順で返す (高階級レイヤーが上に描画される)', () {
      final tree = _tree({
        ShindoDbIntensityClass.four: [
          _prefNode([_cityNode('01100', '010100')]),
        ],
        ShindoDbIntensityClass.one: [
          _prefNode([_cityNode('01200', '010200')]),
        ],
      });

      expect(computeShindoDbFillCodes(tree).keys.toList(), [
        ShindoDbIntensityClass.one,
        ShindoDbIntensityClass.four,
      ]);
    });

    test('色を持たない歴史的階級は含まない', () {
      final tree = _tree({
        ShindoDbIntensityClass.unknownFelt: [
          _prefNode([_cityNode('01100', '010100')]),
        ],
        ShindoDbIntensityClass.two: [
          _prefNode([_cityNode('01200', '010200')]),
        ],
      });

      expect(computeShindoDbFillCodes(tree).keys.toList(), [
        ShindoDbIntensityClass.two,
      ]);
    });
  });
}

ShindoDbIntensityTree _tree(
  Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>> tree,
) => ShindoDbIntensityTree(
  tree: tree,
  unresolvedStations: const {},
  totalStationCount: 0,
);

ShindoDbPrefectureNode _prefNode(List<ShindoDbCityNode> cities) =>
    ShindoDbPrefectureNode(
      prefecture: EarthquakeParameterPrefectureItem(
        code: '01',
        name: const LocalizedName(ja: 'テスト都道府県'),
        regions: const [],
      ),
      cities: cities,
    );

ShindoDbCityNode _cityNode(String cityCode, String regionCode) =>
    ShindoDbCityNode(
      city: EarthquakeParameterCityItem(
        code: cityCode,
        name: const LocalizedName(ja: 'テスト市区町村'),
        kana: null,
        stations: const [],
      ),
      region: EarthquakeParameterRegionItem(
        code: regionCode,
        name: const LocalizedName(ja: 'テスト地域'),
        kana: null,
        cities: const [],
      ),
      stations: const [],
    );
