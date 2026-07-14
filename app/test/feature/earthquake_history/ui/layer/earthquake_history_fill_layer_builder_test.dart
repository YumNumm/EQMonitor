import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_fill_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/earthquake_history_map_layer_mode.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:maplibre/maplibre.dart';
import 'package:test/test.dart';

void main() {
  const resolver = EarthquakeHistoryMapLayerModeResolver();
  const builder = EarthquakeHistoryFillLayerBuilder(modeResolver: resolver);
  final colorModel = AppTheme.eqmonitorDefault().light!.intensity;
  const parameter = EarthquakeHistoryMapLayerParameter();

  // ──────────────────────────────────────────────
  // regionCodeFilter
  // ──────────────────────────────────────────────

  group('regionCodeFilter', () {
    test('areaForecastLocalE の code フィールドで in フィルタを生成する', () {
      expect(builder.regionCodeFilter(['001', '002', '003']), [
        'in',
        ['get', 'code'],
        [
          'literal',
          ['001', '002', '003'],
        ],
      ]);
    });

    test('空リストでもフィルタ構造は変わらない', () {
      final result = builder.regionCodeFilter([]);
      expect(result[1], ['get', 'code']);
    });
  });

  // ──────────────────────────────────────────────
  // cityCodeFilter
  // ──────────────────────────────────────────────

  group('cityCodeFilter', () {
    test('areaInformationCityQuake の regioncode フィールドで in フィルタを生成する', () {
      expect(builder.cityCodeFilter(['1010001', '1310000']), [
        'in',
        ['get', 'regioncode'],
        [
          'literal',
          ['1010001', '1310000'],
        ],
      ]);
    });

    test('regionCodeFilter と異なるフィールド名を使う', () {
      final regionFilter = builder.regionCodeFilter(['001']);
      final cityFilter = builder.cityCodeFilter(['001']);
      // region は 'code'、city は 'regioncode'
      expect(regionFilter[1], ['get', 'code']);
      expect(cityFilter[1], ['get', 'regioncode']);
    });
  });

  // ──────────────────────────────────────────────
  // buildRegionLayers
  // ──────────────────────────────────────────────

  group('buildRegionLayers', () {
    const mode = EarthquakeHistoryMapLayerMode.region;

    test('Fill + Line の 2 レイヤーを返す', () {
      final layers = builder.buildRegionLayers(
        idPrefix: 'test',
        codes: ['001'],
        color: '#FF0000',
        mode: mode,
        parameter: parameter,
      );
      expect(layers, hasLength(2));
      expect(layers[0], isA<FillStyleLayer>());
      expect(layers[1], isA<LineStyleLayer>());
    });

    test('sourceId は eqmonitor_map', () {
      final layers = builder.buildRegionLayers(
        idPrefix: 'test',
        codes: ['001'],
        color: '#FF0000',
        mode: mode,
        parameter: parameter,
      );
      expect((layers[0] as FillStyleLayer).sourceId, 'eqmonitor_map');
      expect((layers[1] as LineStyleLayer).sourceId, 'eqmonitor_map');
    });

    test('sourceLayerId は areaForecastLocalE', () {
      final layers = builder.buildRegionLayers(
        idPrefix: 'test',
        codes: ['001'],
        color: '#FF0000',
        mode: mode,
        parameter: parameter,
      );
      expect((layers[0] as FillStyleLayer).sourceLayerId, 'areaForecastLocalE');
      expect((layers[1] as LineStyleLayer).sourceLayerId, 'areaForecastLocalE');
    });

    test('レイヤー ID は {prefix}-region-fill / {prefix}-region-line', () {
      final layers = builder.buildRegionLayers(
        idPrefix: 'eq-history-jma-four',
        codes: ['001'],
        color: '#FF0000',
        mode: mode,
        parameter: parameter,
      );
      expect(layers[0].id, 'eq-history-jma-four-region-fill');
      expect(layers[1].id, 'eq-history-jma-four-region-line');
    });

    test('filter に code フィールドを使う', () {
      final layers = builder.buildRegionLayers(
        idPrefix: 'test',
        codes: ['001', '002'],
        color: '#FF0000',
        mode: mode,
        parameter: parameter,
      );
      final fill = layers[0] as FillStyleLayer;
      expect(fill.filter, [
        'in',
        ['get', 'code'],
        [
          'literal',
          ['001', '002'],
        ],
      ]);
    });

    test('fill-color に指定した色が入る', () {
      final layers = builder.buildRegionLayers(
        idPrefix: 'test',
        codes: ['001'],
        color: '#ABCDEF',
        mode: mode,
        parameter: parameter,
      );
      expect((layers[0] as FillStyleLayer).paint['fill-color'], '#ABCDEF');
    });

    test('line-color は固定で白 (#ffffff)', () {
      final layers = builder.buildRegionLayers(
        idPrefix: 'test',
        codes: ['001'],
        color: '#FF0000',
        mode: mode,
        parameter: parameter,
      );
      expect((layers[1] as LineStyleLayer).paint['line-color'], '#ffffff');
    });
  });

  // ──────────────────────────────────────────────
  // buildCityLayer
  // ──────────────────────────────────────────────

  group('buildCityLayer', () {
    const mode = EarthquakeHistoryMapLayerMode.city;

    test('FillStyleLayer 1 枚を返す', () {
      final layer = builder.buildCityLayer(
        idPrefix: 'test',
        codes: ['1010001'],
        color: '#FF0000',
        mode: mode,
        parameter: parameter,
      );
      expect(layer, isA<FillStyleLayer>());
    });

    test('sourceId は eqmonitor_map', () {
      final layer =
          builder.buildCityLayer(
                idPrefix: 'test',
                codes: ['1010001'],
                color: '#FF0000',
                mode: mode,
                parameter: parameter,
              )
              as FillStyleLayer;
      expect(layer.sourceId, 'eqmonitor_map');
    });

    test('sourceLayerId は areaInformationCityQuake', () {
      final layer =
          builder.buildCityLayer(
                idPrefix: 'test',
                codes: ['1010001'],
                color: '#FF0000',
                mode: mode,
                parameter: parameter,
              )
              as FillStyleLayer;
      expect(layer.sourceLayerId, 'areaInformationCityQuake');
    });

    test('レイヤー ID は {prefix}-city-fill', () {
      final layer = builder.buildCityLayer(
        idPrefix: 'eq-history-jma-four',
        codes: ['1010001'],
        color: '#FF0000',
        mode: mode,
        parameter: parameter,
      );
      expect(layer.id, 'eq-history-jma-four-city-fill');
    });

    test('filter に regioncode フィールドを使う', () {
      final layer =
          builder.buildCityLayer(
                idPrefix: 'test',
                codes: ['1010001', '1310000'],
                color: '#FF0000',
                mode: mode,
                parameter: parameter,
              )
              as FillStyleLayer;
      expect(layer.filter, [
        'in',
        ['get', 'regioncode'],
        [
          'literal',
          ['1010001', '1310000'],
        ],
      ]);
    });

    test('fill-color に指定した色が入る', () {
      final layer =
          builder.buildCityLayer(
                idPrefix: 'test',
                codes: ['1010001'],
                color: '#ABCDEF',
                mode: mode,
                parameter: parameter,
              )
              as FillStyleLayer;
      expect(layer.paint['fill-color'], '#ABCDEF');
    });
  });

  // ──────────────────────────────────────────────
  // buildJmaLayers の統合テスト
  // ──────────────────────────────────────────────

  group('buildJmaLayers', () {
    final testData = _FillLayerTestData();

    test('mode=none は空リストを返す', () {
      final layers = builder.build(
        intensity: testData.regionAndCityIntensity(),
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.none,
        showingLpgmIntensity: false,
        parameter: parameter,
      );
      expect(layers, isEmpty);
    });

    test('mode=station は空リストを返す', () {
      final layers = builder.build(
        intensity: testData.regionAndCityIntensity(),
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.station,
        showingLpgmIntensity: false,
        parameter: parameter,
      );
      expect(layers, isEmpty);
    });

    test('mode=region は Fill+Line のみ、city レイヤーは含まない', () {
      final layers = builder.buildJmaLayers(
        intensity: testData.regionAndCityIntensity(),
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.region,
        parameter: parameter,
      );
      expect(layers, isNotEmpty);
      expect(layers.every((l) => l.id.contains('region')), isTrue);
      expect(layers.any((l) => l.id.contains('city')), isFalse);
    });

    test('mode=city は city Fill のみ、region レイヤーは含まない', () {
      final layers = builder.buildJmaLayers(
        intensity: testData.regionAndCityIntensity(),
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.city,
        parameter: parameter,
      );
      expect(layers, isNotEmpty);
      expect(layers.every((l) => l.id.contains('city')), isTrue);
      expect(layers.any((l) => l.id.contains('region')), isFalse);
    });

    test('震度ごとに別レイヤーを生成する', () {
      final intensity = testData.multiLevelIntensity();
      final layers = builder.buildJmaLayers(
        intensity: intensity,
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.region,
        parameter: parameter,
      );
      // 震度 3, 4 の 2 レベル × (fill + line) = 4 レイヤー
      expect(layers, hasLength(4));
      expect(layers.any((l) => l.id.contains('three')), isTrue);
      expect(layers.any((l) => l.id.contains('four')), isTrue);
    });

    test('codes が空の震度レベルはスキップする', () {
      // regions に震度 4 しかないデータ
      final intensity = testData.regionOnlyIntensity();
      final layers = builder.buildJmaLayers(
        intensity: intensity,
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.region,
        parameter: parameter,
      );
      // 震度 4 のみ → fill + line = 2 レイヤー
      expect(layers, hasLength(2));
      expect(layers.every((l) => l.id.contains('four')), isTrue);
    });

    test('region レイヤーの filter は code フィールドを使う', () {
      final layers = builder.buildJmaLayers(
        intensity: testData.regionAndCityIntensity(),
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.region,
        parameter: parameter,
      );
      final fills = layers.whereType<FillStyleLayer>().toList();
      for (final fill in fills) {
        final filterField = (fill.filter![1] as List<Object>)[1] as String;
        expect(filterField, 'code', reason: 'region filter は code フィールドを使う');
      }
    });

    test('city レイヤーの filter は regioncode フィールドを使う', () {
      final layers = builder.buildJmaLayers(
        intensity: testData.regionAndCityIntensity(),
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.city,
        parameter: parameter,
      );
      final fills = layers.whereType<FillStyleLayer>().toList();
      for (final fill in fills) {
        final filterField = (fill.filter![1] as List<Object>)[1] as String;
        expect(
          filterField,
          'regioncode',
          reason: 'city filter は regioncode フィールドを使う',
        );
      }
    });
  });

  // ──────────────────────────────────────────────
  // buildLpgmLayers の統合テスト
  // ──────────────────────────────────────────────

  group('buildLpgmLayers', () {
    final testData = _FillLayerTestData();

    test('mode=region は region Fill+Line を返す', () {
      final layers = builder.buildLpgmLayers(
        intensity: testData.lpgmIntensity(),
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.region,
        parameter: parameter,
      );
      expect(layers, isNotEmpty);
      expect(layers.every((l) => l.id.contains('region')), isTrue);
    });

    test('mode=city は city Fill を返す', () {
      final layers = builder.buildLpgmLayers(
        intensity: testData.lpgmIntensity(),
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.city,
        parameter: parameter,
      );
      expect(layers, isNotEmpty);
      expect(layers.every((l) => l.id.contains('city')), isTrue);
    });

    test('city レイヤーの filter は regioncode フィールドを使う', () {
      final layers = builder.buildLpgmLayers(
        intensity: testData.lpgmIntensity(),
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.city,
        parameter: parameter,
      );
      final fills = layers.whereType<FillStyleLayer>().toList();
      for (final fill in fills) {
        final filterField = (fill.filter![1] as List<Object>)[1] as String;
        expect(filterField, 'regioncode');
      }
    });

    test('showingLpgmIntensity=true のとき build() は buildLpgmLayers に委譲する', () {
      final lpgm = builder.build(
        intensity: testData.lpgmIntensity(),
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.region,
        showingLpgmIntensity: true,
        parameter: parameter,
      );
      final jma = builder.build(
        intensity: testData.lpgmIntensity(),
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.region,
        showingLpgmIntensity: false,
        parameter: parameter,
      );
      // LPGM レイヤー ID には 'lpgm' が含まれ、JMA には含まれない
      expect(lpgm.every((l) => l.id.contains('lpgm')), isTrue);
      expect(jma.every((l) => !l.id.contains('lpgm')), isTrue);
    });
  });

  // ──────────────────────────────────────────────
  // 複数震度レベルに跨る市区町村・細分区域の重複排除
  // (重複すると半透明 fill が重なり、意図しない混色になる)
  // ──────────────────────────────────────────────

  group('jmaCityCodes の重複排除', () {
    final testData = _FillLayerTestData();

    test('複数レベルに登場する市区町村は最大レベルにのみ含まれる', () {
      final intensity = testData.cityInMultipleLevelsIntensity();
      expect(builder.jmaCityCodes(intensity, JmaIntensity.four), ['2110001']);
      expect(builder.jmaCityCodes(intensity, JmaIntensity.three), ['2110002']);
    });

    test('buildJmaLayers の city filter に同一市区町村が複数レイヤーで現れない', () {
      final layers = builder.buildJmaLayers(
        intensity: testData.cityInMultipleLevelsIntensity(),
        colorModel: colorModel,
        mode: EarthquakeHistoryMapLayerMode.city,
        parameter: parameter,
      );
      final codes = layers
          .whereType<FillStyleLayer>()
          .expand((l) => ((l.filter![2] as List<Object>)[1] as List<String>))
          .toList();
      expect(codes.toSet(), hasLength(codes.length), reason: '市区町村コードの重複なし');
    });
  });

  group('lpgmCityCodes / lpgmRegionCodes の重複排除', () {
    final testData = _FillLayerTestData();

    test('複数階級に登場する市区町村は最大階級にのみ含まれる', () {
      final intensity = testData.lpgmMultiLevelIntensity();
      expect(builder.lpgmCityCodes(intensity, JmaLpgmIntensity.two), [
        '2110001',
      ]);
      expect(builder.lpgmCityCodes(intensity, JmaLpgmIntensity.one), [
        '2210001',
      ]);
    });

    test('複数階級に登場する細分区域は最大階級にのみ含まれる', () {
      final intensity = testData.lpgmMultiLevelIntensity();
      expect(builder.lpgmRegionCodes(intensity, JmaLpgmIntensity.two), ['210']);
      expect(builder.lpgmRegionCodes(intensity, JmaLpgmIntensity.one), ['220']);
    });
  });
}

// ──────────────────────────────────────────────
// テストデータ
// ──────────────────────────────────────────────

class _FillLayerTestData {
  static const _regionCode = '210';
  static const _regionCode2 = '220';
  static const _cityCode = '2110001';

  EarthquakeIntensity regionOnlyIntensity() {
    return EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: null,
      regions: {
        JmaIntensity.four: [_region(_regionCode, JmaIntensity.four)],
      },
      intensityTree: {
        JmaIntensity.four: [
          PrefectureIntensityNode(
            prefecture: _prefecture('21'),
            cities: const [],
          ),
        ],
      },
      lpgmIntensityTree: const {},
    );
  }

  EarthquakeIntensity regionAndCityIntensity() {
    return EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: null,
      regions: {
        JmaIntensity.four: [_region(_regionCode, JmaIntensity.four)],
      },
      intensityTree: {
        JmaIntensity.four: [
          PrefectureIntensityNode(
            prefecture: _prefecture('21'),
            cities: [
              CityIntensityNode(
                city: _city(_cityCode),
                maxIntensity: JmaIntensity.four,
                stations: const [],
              ),
            ],
          ),
        ],
      },
      lpgmIntensityTree: const {},
    );
  }

  EarthquakeIntensity multiLevelIntensity() {
    return EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: null,
      regions: {
        JmaIntensity.three: [_region(_regionCode, JmaIntensity.three)],
        JmaIntensity.four: [_region(_regionCode2, JmaIntensity.four)],
      },
      intensityTree: {
        JmaIntensity.three: [
          PrefectureIntensityNode(
            prefecture: _prefecture('21'),
            cities: const [],
          ),
        ],
        JmaIntensity.four: [
          PrefectureIntensityNode(
            prefecture: _prefecture('22'),
            cities: const [],
          ),
        ],
      },
      lpgmIntensityTree: const {},
    );
  }

  EarthquakeIntensity lpgmIntensity() {
    final region = _region(_regionCode, JmaIntensity.four);
    return EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: JmaLpgmIntensity.two,
      regions: {
        JmaIntensity.four: [region],
      },
      intensityTree: {
        JmaIntensity.four: [
          PrefectureIntensityNode(
            prefecture: _prefecture('21'),
            cities: const [],
          ),
        ],
      },
      lpgmIntensityTree: {
        JmaLpgmIntensity.two: [
          PrefectureLpgmIntensityNode(
            region: region.region,
            maxLpgmIntensity: JmaLpgmIntensity.two,
            cities: [
              CityLpgmIntensityNode(
                city: _city(_cityCode),
                maxLpgmIntensity: JmaLpgmIntensity.two,
                stations: const [],
              ),
            ],
          ),
        ],
      },
    );
  }

  /// 市区町村 2110001 が震度 3・4 の両バケツに登場するデータ
  /// (震度3の観測点と震度4の観測点を両方持つ市区町村を再現)
  EarthquakeIntensity cityInMultipleLevelsIntensity() {
    return EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: null,
      regions: const {},
      intensityTree: {
        JmaIntensity.three: [
          PrefectureIntensityNode(
            prefecture: _prefecture('21'),
            cities: [
              CityIntensityNode(
                city: _city('2110001'),
                maxIntensity: JmaIntensity.three,
                stations: const [],
              ),
              CityIntensityNode(
                city: _city('2110002'),
                maxIntensity: JmaIntensity.three,
                stations: const [],
              ),
            ],
          ),
        ],
        JmaIntensity.four: [
          PrefectureIntensityNode(
            prefecture: _prefecture('21'),
            cities: [
              CityIntensityNode(
                city: _city('2110001'),
                maxIntensity: JmaIntensity.four,
                stations: const [],
              ),
            ],
          ),
        ],
      },
      lpgmIntensityTree: const {},
    );
  }

  /// 細分区域 210 (市区町村 2110001) が階級 1・2 の両バケツに、
  /// 細分区域 220 (市区町村 2210001) が階級 1 のみに登場するデータ
  EarthquakeIntensity lpgmMultiLevelIntensity() {
    return EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: JmaLpgmIntensity.two,
      regions: const {},
      intensityTree: const {},
      lpgmIntensityTree: {
        JmaLpgmIntensity.one: [
          PrefectureLpgmIntensityNode(
            region: _regionItem(_regionCode),
            maxLpgmIntensity: JmaLpgmIntensity.one,
            cities: [
              CityLpgmIntensityNode(
                city: _city('2110001'),
                maxLpgmIntensity: JmaLpgmIntensity.one,
                stations: const [],
              ),
            ],
          ),
          PrefectureLpgmIntensityNode(
            region: _regionItem(_regionCode2),
            maxLpgmIntensity: JmaLpgmIntensity.one,
            cities: [
              CityLpgmIntensityNode(
                city: _city('2210001'),
                maxLpgmIntensity: JmaLpgmIntensity.one,
                stations: const [],
              ),
            ],
          ),
        ],
        JmaLpgmIntensity.two: [
          PrefectureLpgmIntensityNode(
            region: _regionItem(_regionCode),
            maxLpgmIntensity: JmaLpgmIntensity.two,
            cities: [
              CityLpgmIntensityNode(
                city: _city('2110001'),
                maxLpgmIntensity: JmaLpgmIntensity.two,
                stations: const [],
              ),
            ],
          ),
        ],
      },
    );
  }

  EarthquakeParameterRegionItem _regionItem(String code) {
    return EarthquakeParameterRegionItem(
      code: code,
      name: const LocalizedName(ja: 'テスト地域'),
      kana: null,
      cities: const [],
    );
  }

  IntensityRegion _region(String code, JmaIntensity intensity) {
    return IntensityRegion(
      region: EarthquakeParameterRegionItem(
        code: code,
        name: const LocalizedName(ja: 'テスト地域'),
        kana: null,
        cities: const [],
      ),
      maxIntensity: intensity,
    );
  }

  IntensityPrefecture _prefecture(String code) {
    return IntensityPrefecture(
      prefecture: EarthquakeParameterPrefectureItem(
        code: code,
        name: const LocalizedName(ja: 'テスト都道府県'),
        regions: const [],
      ),
      maxIntensity: JmaIntensity.four,
    );
  }

  EarthquakeParameterCityItem _city(String code) {
    return EarthquakeParameterCityItem(
      code: code,
      name: const LocalizedName(ja: 'テスト市区町村'),
      kana: null,
      stations: const [],
    );
  }
}
