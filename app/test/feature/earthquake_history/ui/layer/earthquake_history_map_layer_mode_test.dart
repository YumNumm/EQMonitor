import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/earthquake_history_map_layer_mode.dart';
import 'package:eqmonitor/feature/map/data/model/base_map_tile_spec.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:test/test.dart';

void main() {
  final testData = EarthquakeHistoryMapLayerModeTestData();
  const resolver = EarthquakeHistoryMapLayerModeResolver();

  group('resolveFillLayerMode', () {
    test('fillMode=none なら none を返す', () {
      final earthquake = testData.earthquake(
        intensity: testData.fullIntensity(),
      );

      final mode = resolver.resolveFillLayerMode(
        earthquake: earthquake,
        fillMode: EarthquakeHistoryFillMode.none,
        showingLpgmIntensity: false,
      );

      expect(mode, EarthquakeHistoryMapLayerMode.none);
    });

    test('regions のみなら city/auto は region にフォールバックする', () {
      final earthquake = testData.earthquake(
        intensity: testData.regionOnlyIntensity(),
      );

      for (final fillMode in [
        EarthquakeHistoryFillMode.city,
        EarthquakeHistoryFillMode.auto,
      ]) {
        expect(
          resolver.resolveFillLayerMode(
            earthquake: earthquake,
            fillMode: fillMode,
            showingLpgmIntensity: false,
          ),
          EarthquakeHistoryMapLayerMode.region,
        );
      }
    });

    test('regions + cities + stations がある場合は設定通り解決する', () {
      final earthquake = testData.earthquake(
        intensity: testData.fullIntensity(),
      );

      final cases = {
        EarthquakeHistoryFillMode.region: EarthquakeHistoryMapLayerMode.region,
        EarthquakeHistoryFillMode.city: EarthquakeHistoryMapLayerMode.city,
        EarthquakeHistoryFillMode.auto: EarthquakeHistoryMapLayerMode.auto,
      };

      for (final entry in cases.entries) {
        expect(
          resolver.resolveFillLayerMode(
            earthquake: earthquake,
            fillMode: entry.key,
            showingLpgmIntensity: false,
          ),
          entry.value,
        );
      }
    });

    test('長周期地震動階級モードでは LPGM 側のデータ可用性で解決する', () {
      final earthquake = testData.earthquake(
        intensity: testData.lpgmFullJmaRegionOnly(),
      );

      expect(
        resolver.resolveFillLayerMode(
          earthquake: earthquake,
          fillMode: EarthquakeHistoryFillMode.city,
          showingLpgmIntensity: false,
        ),
        EarthquakeHistoryMapLayerMode.region,
      );
      expect(
        resolver.resolveFillLayerMode(
          earthquake: earthquake,
          fillMode: EarthquakeHistoryFillMode.city,
          showingLpgmIntensity: true,
        ),
        EarthquakeHistoryMapLayerMode.city,
      );
    });

    test('intensity がない不正な地震データは none を返す', () {
      final earthquake = testData.earthquake();

      expect(
        resolver.resolveFillLayerMode(
          earthquake: earthquake,
          fillMode: EarthquakeHistoryFillMode.auto,
          showingLpgmIntensity: false,
        ),
        EarthquakeHistoryMapLayerMode.none,
      );
    });
  });

  group('opacity expressions', () {
    test('auto の regionFillOpacity は regionToCity でカットオフする', () {
      expect(
        resolver.regionFillOpacity(
          mode: EarthquakeHistoryMapLayerMode.auto,
          regionToCity: 7.5,
          visibleOpacity: 0.6,
        ),
        [
          'step',
          ['zoom'],
          0.6,
          7.5,
          0.0,
        ],
      );
    });

    test('auto の cityFillOpacity は regionToCity 以上で表示（上限カットオフなし）', () {
      expect(
        resolver.cityFillOpacity(
          mode: EarthquakeHistoryMapLayerMode.auto,
          regionToCity: 7.5,
          visibleOpacity: 0.6,
        ),
        [
          'step',
          ['zoom'],
          0.0,
          7.5,
          0.6,
        ],
      );
    });

    test('切り替え点はタイルに市区町村が存在する最小ズームを下回らない', () {
      // 市区町村ポリゴンが無いズームに切り替え点を置くと、
      // 細分区域も市区町村も塗られない帯ができてしまう。
      // タイル側の下限が 0 になったので今は設定値がそのまま効く。
      expect(
        resolver.effectiveRegionToCityZoom(BaseMapTileSpec.cityMinZoom - 1),
        BaseMapTileSpec.cityMinZoom,
      );
      expect(resolver.effectiveRegionToCityZoom(3), 3);
      expect(resolver.effectiveRegionToCityZoom(9), 9);
    });

    test('切り上げられた閾値で region / city の opacity が隙間なく入れ替わる', () {
      const belowMinZoom = BaseMapTileSpec.cityMinZoom - 1;
      final regionOpacity = resolver.regionFillOpacity(
        mode: EarthquakeHistoryMapLayerMode.auto,
        regionToCity: belowMinZoom,
        visibleOpacity: 0.6,
      ) as List<Object>;
      final cityOpacity = resolver.cityFillOpacity(
        mode: EarthquakeHistoryMapLayerMode.auto,
        regionToCity: belowMinZoom,
        visibleOpacity: 0.6,
      ) as List<Object>;

      expect(regionOpacity[3], BaseMapTileSpec.cityMinZoom);
      expect(cityOpacity[3], BaseMapTileSpec.cityMinZoom);
      // 閾値未満は region が可視 / city は不可視、閾値以上はその逆。
      expect(regionOpacity[2], 0.6);
      expect(regionOpacity[4], 0.0);
      expect(cityOpacity[2], 0.0);
      expect(cityOpacity[4], 0.6);
    });

    test('既定の regionToCity はタイルの市区町村最小ズーム以上である', () {
      const parameter = EarthquakeHistoryMapLayerParameter();
      expect(
        parameter.regionToCity,
        greaterThanOrEqualTo(BaseMapTileSpec.cityMinZoom),
      );
    });

    test('region モードの regionFillOpacity は固定値を返す', () {
      expect(
        resolver.regionFillOpacity(
          mode: EarthquakeHistoryMapLayerMode.region,
          regionToCity: 8,
          visibleOpacity: 0.6,
        ),
        0.6,
      );
    });

    test('city モードの cityFillOpacity は固定値を返す', () {
      expect(
        resolver.cityFillOpacity(
          mode: EarthquakeHistoryMapLayerMode.city,
          regionToCity: 8,
          visibleOpacity: 0.6,
        ),
        0.6,
      );
    });
  });
}

class EarthquakeHistoryMapLayerModeTestData {
  Earthquake earthquake({EarthquakeIntensity? intensity}) {
    return Earthquake(
      eventId: '202605030001',
      status: TelegramStatus.normal,
      originTime: DateTime(2026),
      originTimePrecision: OriginTimePrecision.second,
      arrivalTime: DateTime(2026),
      dataSources: [EarthquakeDataSource.jmaDisasterInformationXml],
      telegramTypes: const [],
      hypocenter: null,
      intensity: intensity,
      estimatedIntensityTileUrl: null,
    );
  }

  EarthquakeIntensity regionOnlyIntensity() {
    final region = regionNode(maxIntensity: JmaIntensity.four);
    final prefecture = prefectureNode(maxIntensity: JmaIntensity.four);
    return EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: null,
      regions: {
        JmaIntensity.four: [region],
      },
      intensityTree: {
        JmaIntensity.four: [
          PrefectureIntensityNode(prefecture: prefecture, cities: const []),
        ],
      },
      lpgmIntensityTree: const {},
    );
  }

  EarthquakeIntensity fullIntensity() {
    final region = regionNode(maxIntensity: JmaIntensity.four);
    final prefecture = prefectureNode(maxIntensity: JmaIntensity.four);
    final city = cityNode();
    final station = stationNode(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: JmaLpgmIntensity.two,
    );
    final lpgmCity = lpgmCityNode();

    return EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: JmaLpgmIntensity.two,
      regions: {
        JmaIntensity.four: [region],
      },
      intensityTree: {
        JmaIntensity.four: [
          PrefectureIntensityNode(
            prefecture: prefecture,
            cities: [
              CityIntensityNode(
                city: city,
                maxIntensity: JmaIntensity.four,
                maxLpgmIntensity: JmaLpgmIntensity.two,
                stations: [station],
              ),
            ],
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
                city: lpgmCity,
                maxLpgmIntensity: JmaLpgmIntensity.two,
                stations: [
                  StationLpgmIntensityNode(
                    station: station.station,
                    intensity: station.intensity,
                  ),
                ],
              ),
            ],
          ),
        ],
      },
    );
  }

  EarthquakeIntensity lpgmFullJmaRegionOnly() {
    final region = regionNode(maxIntensity: JmaIntensity.four);
    final prefecture = prefectureNode(maxIntensity: JmaIntensity.four);
    final station = stationNode(
      maxIntensity: null,
      maxLpgmIntensity: JmaLpgmIntensity.two,
    );
    final lpgmCity = lpgmCityNode();

    return EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: JmaLpgmIntensity.two,
      regions: {
        JmaIntensity.four: [region],
      },
      intensityTree: {
        JmaIntensity.four: [
          PrefectureIntensityNode(prefecture: prefecture, cities: const []),
        ],
      },
      lpgmIntensityTree: {
        JmaLpgmIntensity.two: [
          PrefectureLpgmIntensityNode(
            region: region.region,
            maxLpgmIntensity: JmaLpgmIntensity.two,
            cities: [
              CityLpgmIntensityNode(
                city: lpgmCity,
                maxLpgmIntensity: JmaLpgmIntensity.two,
                stations: [
                  StationLpgmIntensityNode(
                    station: station.station,
                    intensity: station.intensity,
                  ),
                ],
              ),
            ],
          ),
        ],
      },
    );
  }

  IntensityRegion regionNode({required JmaIntensity? maxIntensity}) {
    return IntensityRegion(
      region: const EarthquakeParameterRegionItem(
        code: '001',
        name: LocalizedName(ja: 'テスト地域'),
        kana: null,
        cities: [],
      ),
      maxIntensity: maxIntensity,
    );
  }

  IntensityPrefecture prefectureNode({required JmaIntensity? maxIntensity}) {
    return IntensityPrefecture(
      prefecture: const EarthquakeParameterPrefectureItem(
        code: '001',
        name: LocalizedName(ja: 'テスト都道府県'),
        regions: [],
      ),
      maxIntensity: maxIntensity,
    );
  }

  EarthquakeParameterCityItem cityNode() {
    return const EarthquakeParameterCityItem(
      code: '001001',
      name: LocalizedName(ja: 'テスト市区町村'),
      kana: null,
      stations: [],
    );
  }

  EarthquakeParameterCityItem lpgmCityNode() {
    return const EarthquakeParameterCityItem(
      code: '001001',
      name: LocalizedName(ja: 'テスト市区町村'),
      kana: null,
      stations: [],
    );
  }

  StationIntensityNode stationNode({
    required JmaIntensity? maxIntensity,
    required JmaLpgmIntensity? maxLpgmIntensity,
  }) {
    const station = EarthquakeParameterStationItem(
      code: '001001001',
      noCode: '001001001',
      name: LocalizedName(ja: 'テスト観測点'),
      kana: null,
      status: EarthquakeStationStatus.operating,
      sourceStatus: 'test',
      owner: 'test',
      location: LatLng(0, 0),
    );
    return StationIntensityNode(
      station: station,
      intensity: IntensityStation(
        code: station.code,
        name: station.name.ja,
        sva: null,
        prePeriods: null,
        maxIntensity: maxIntensity,
        maxLpgmIntensity: maxLpgmIntensity,
      ),
    );
  }
}
