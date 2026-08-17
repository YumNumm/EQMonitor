import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_layer_builder.dart';
import 'package:eqmonitor/feature/map/data/model/base_map_tile_spec.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Test fixtures
// ---------------------------------------------------------------------------

LocalizedName _name(String ja) => LocalizedName(ja: ja, en: ja);

EarthquakeParameterCityItem _city(String code) => EarthquakeParameterCityItem(
  code: code,
  name: _name('city-$code'),
  kana: null,
  stations: const [],
);

EarthquakeParameterRegionItem _region(String code, List<String> cityCodes) =>
    EarthquakeParameterRegionItem(
      code: code,
      name: _name('region-$code'),
      kana: null,
      cities: cityCodes.map(_city).toList(),
    );

final _prefectures = [
  EarthquakeParameterPrefectureItem(
    code: '01',
    name: _name('北海道'),
    regions: [
      _region('100', ['0110100']),
      _region('101', ['0110200']),
    ],
  ),
  EarthquakeParameterPrefectureItem(
    code: '04',
    name: _name('宮城県'),
    regions: [
      _region('220', ['0410000']),
    ],
  ),
];

final _earthquake = EarthquakePartialNormal(
  eventId: '20240101000000',
  status: TelegramStatus.normal,
  originTime: DateTime(2024, 1, 1, 16, 10),
  originTimePrecision: OriginTimePrecision.minute,
  arrivalTime: DateTime(2024, 1, 1, 16, 11),
  dataSources: const [EarthquakeDataSource.jmaIntensityDatabase],
  hypocenter: const EarthquakeHypocenter(
    code: '123',
    name: '能登半島沖',
    coordinates: null,
    magnitude: EarthquakeMagnitude.value(value: 7.6),
    depth: EarthquakeDepth.shallow(),
    detailedCode: null,
    detailedName: null,
  ),
  intensity: const EarthquakeIntensityPartial(
    maxIntensity: JmaIntensity.seven,
    maxLpgmIntensity: null,
  ),
  earthquakeType: EarthquakeType.normal,
  telegramTypes: const [EarthquakeTelegramType.vxse53],
  estimatedIntensityTileUrl: null,
);

HighestIntensityEntry _entry(String code, JmaIntensity intensity) =>
    HighestIntensityEntry(
      code: code,
      name: 'name-$code',
      intensity: intensity,
      count: 1,
      earthquake: _earthquake,
    );

void main() {
  const builder = IntensityFillLayerBuilder();
  late IntensityColors colorModel;

  setUp(() {
    colorModel = AppTheme.eqmonitorDefault().light!.intensity;
  });

  List<String> idsOf(IntensityHistoryState state, {bool withCity = true}) =>
      builder
          .build(
            state: state,
            prefectureHighest: [
              _entry('01', JmaIntensity.fiveLower),
              _entry('04', JmaIntensity.four),
            ],
            cityHighest: withCity
                ? [_entry('0110100', JmaIntensity.fiveLower)]
                : const [],
            prefectures: _prefectures,
            colorModel: colorModel,
            isDarkMode: false,
          )
          .map((entry) => entry.layer.id)
          .toList();

  group('build', () {
    test('全国表示では細分区域の塗りだけを返す', () {
      expect(idsOf(const IntensityHistoryState.prefecture()), [
        IntensityFillLayerBuilder.regionFillLayerId,
      ]);
    });

    test('都道府県フォーカス中は 下→上 の決定的な順序で返す', () {
      expect(
        idsOf(
          const IntensityHistoryState.city(
            prefectureCode: '01',
            prefectureName: '北海道',
            selectedCityCode: '0110100',
            selectedCityName: '札幌中央区',
          ),
        ),
        [
          IntensityFillLayerBuilder.regionFillLayerId,
          IntensityFillLayerBuilder.focusedRegionFillLayerId,
          IntensityFillLayerBuilder.cityFillLayerId,
          IntensityFillLayerBuilder.dimFillLayerId,
          IntensityFillLayerBuilder.selectedCityLineLayerId,
        ],
      );
    });

    test('市区町村が未選択なら輪郭線レイヤーを追加しない', () {
      expect(
        idsOf(
          const IntensityHistoryState.city(
            prefectureCode: '01',
            prefectureName: '北海道',
          ),
        ),
        isNot(contains(IntensityFillLayerBuilder.selectedCityLineLayerId)),
      );
    });

    test('市区町村の最高震度が未取得なら市区町村の塗りを追加しない', () {
      expect(
        idsOf(
          const IntensityHistoryState.city(
            prefectureCode: '01',
            prefectureName: '北海道',
          ),
          withCity: false,
        ),
        isNot(contains(IntensityFillLayerBuilder.cityFillLayerId)),
      );
    });

    test('全国の塗りはフォーカス中の都道府県を除外する', () {
      final layers = builder.build(
        state: const IntensityHistoryState.city(
          prefectureCode: '01',
          prefectureName: '北海道',
        ),
        prefectureHighest: [_entry('01', JmaIntensity.fiveLower)],
        cityHighest: [_entry('0110100', JmaIntensity.fiveLower)],
        prefectures: _prefectures,
        colorModel: colorModel,
        isDarkMode: false,
      );

      final regionFill = layers
          .where(
            (entry) =>
                entry.layer.id == IntensityFillLayerBuilder.regionFillLayerId,
          )
          .single;
      expect(regionFill.layer.filter, [
        '!',
        [
          'in',
          ['get', 'code'],
          [
            'literal',
            ['100', '101'],
          ],
        ],
      ]);
    });

    test('市区町村の塗りが出るズームではフォーカス中都道府県の塗りを透明にする', () {
      final layers = builder.build(
        state: const IntensityHistoryState.city(
          prefectureCode: '01',
          prefectureName: '北海道',
        ),
        prefectureHighest: [_entry('01', JmaIntensity.fiveLower)],
        cityHighest: [_entry('0110100', JmaIntensity.fiveLower)],
        prefectures: _prefectures,
        colorModel: colorModel,
        isDarkMode: false,
      );

      final focused = layers
          .where(
            (entry) =>
                entry.layer.id ==
                IntensityFillLayerBuilder.focusedRegionFillLayerId,
          )
          .single;
      expect(focused.layer.paint['fill-opacity'], [
        'step',
        ['zoom'],
        IntensityFillLayerBuilder.regionFillOpacity,
        BaseMapTileSpec.cityMinZoom,
        0.0,
      ]);
    });

    test('市区町村の最高震度が未取得ならフォーカス中都道府県の塗りを維持する', () {
      final layers = builder.build(
        state: const IntensityHistoryState.city(
          prefectureCode: '01',
          prefectureName: '北海道',
        ),
        prefectureHighest: [_entry('01', JmaIntensity.fiveLower)],
        cityHighest: const [],
        prefectures: _prefectures,
        colorModel: colorModel,
        isDarkMode: false,
      );

      final focused = layers
          .where(
            (entry) =>
                entry.layer.id ==
                IntensityFillLayerBuilder.focusedRegionFillLayerId,
          )
          .single;
      expect(
        focused.layer.paint['fill-opacity'],
        IntensityFillLayerBuilder.regionFillOpacity,
      );
    });

    test('塗りは細分区域の境界線より下、選択輪郭線はその上に挿入する', () {
      final layers = builder.build(
        state: const IntensityHistoryState.city(
          prefectureCode: '01',
          prefectureName: '北海道',
          selectedCityCode: '0110100',
          selectedCityName: '札幌中央区',
        ),
        prefectureHighest: [_entry('01', JmaIntensity.fiveLower)],
        cityHighest: [_entry('0110100', JmaIntensity.fiveLower)],
        prefectures: _prefectures,
        colorModel: colorModel,
        isDarkMode: false,
      );

      for (final entry in layers) {
        if (entry.layer.id ==
            IntensityFillLayerBuilder.selectedCityLineLayerId) {
          expect(entry.aboveLayerId, BaseLayer.areaForecastLocalELine.name);
          expect(entry.belowLayerId, isNull);
        } else {
          expect(entry.belowLayerId, BaseLayer.areaForecastLocalELine.name);
          expect(entry.aboveLayerId, isNull);
        }
      }
    });

    test('都道府県の最高震度が空ならレイヤーを生成しない', () {
      final layers = builder.build(
        state: const IntensityHistoryState.prefecture(),
        prefectureHighest: const [],
        cityHighest: const [],
        prefectures: _prefectures,
        colorModel: colorModel,
        isDarkMode: false,
      );

      expect(layers, isEmpty);
    });
  });

  group('regionIntensityPairs', () {
    test('都道府県コードを配下の細分区域コードへ展開する', () {
      final pairs = builder.regionIntensityPairs(
        prefectureHighest: [
          _entry('01', JmaIntensity.fiveLower),
          _entry('04', JmaIntensity.four),
        ],
        prefectures: _prefectures,
      );

      expect(pairs, [
        (code: '100', intensity: JmaIntensity.fiveLower),
        (code: '101', intensity: JmaIntensity.fiveLower),
        (code: '220', intensity: JmaIntensity.four),
      ]);
    });

    test('パラメータに存在しない都道府県コードは無視する', () {
      final pairs = builder.regionIntensityPairs(
        prefectureHighest: [_entry('99', JmaIntensity.fiveLower)],
        prefectures: _prefectures,
      );

      expect(pairs, isEmpty);
    });
  });
}
