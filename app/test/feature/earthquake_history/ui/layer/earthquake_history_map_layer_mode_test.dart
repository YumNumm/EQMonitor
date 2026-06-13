import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/earthquake_history_map_layer_mode.dart';
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
      const config = EarthquakeHistoryDetailConfig(
        fillMode: EarthquakeHistoryFillMode.none,
      );

      final mode = resolver.resolveFillLayerMode(
        earthquake: earthquake,
        config: config,
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
        final config = EarthquakeHistoryDetailConfig(fillMode: fillMode);

        expect(
          resolver.resolveFillLayerMode(
            earthquake: earthquake,
            config: config,
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
        final config = EarthquakeHistoryDetailConfig(fillMode: entry.key);

        expect(
          resolver.resolveFillLayerMode(
            earthquake: earthquake,
            config: config,
          ),
          entry.value,
        );
      }
    });

    test('長周期地震動階級モードでは LPGM 側のデータ可用性で解決する', () {
      final earthquake = testData.earthquake(
        intensity: testData.lpgmFullJmaRegionOnly(),
      );

      const jmaConfig = EarthquakeHistoryDetailConfig(
        fillMode: EarthquakeHistoryFillMode.city,
      );
      const lpgmConfig = EarthquakeHistoryDetailConfig(
        fillMode: EarthquakeHistoryFillMode.city,
        showingLpgmIntensity: true,
      );

      expect(
        resolver.resolveFillLayerMode(
          earthquake: earthquake,
          config: jmaConfig,
        ),
        EarthquakeHistoryMapLayerMode.region,
      );
      expect(
        resolver.resolveFillLayerMode(
          earthquake: earthquake,
          config: lpgmConfig,
        ),
        EarthquakeHistoryMapLayerMode.city,
      );
    });

    test('intensity がない不正な地震データは none を返す', () {
      final earthquake = testData.earthquake();
      const config = EarthquakeHistoryDetailConfig();

      expect(
        resolver.resolveFillLayerMode(
          earthquake: earthquake,
          config: config,
        ),
        EarthquakeHistoryMapLayerMode.none,
      );
    });
  });

  group('opacity expressions', () {
    test('auto の regionFillOpacity は regionToCity でカットオフする', () {
      const zoomThresholds = EarthquakeHistoryMapLayerZoomThresholds(
        regionToCity: 7.5,
      );

      expect(
        resolver.regionFillOpacity(
          mode: EarthquakeHistoryMapLayerMode.auto,
          zoomThresholds: zoomThresholds,
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
      const zoomThresholds = EarthquakeHistoryMapLayerZoomThresholds(
        regionToCity: 7.5,
      );

      expect(
        resolver.cityFillOpacity(
          mode: EarthquakeHistoryMapLayerMode.auto,
          zoomThresholds: zoomThresholds,
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

    test('region モードの regionFillOpacity は固定値を返す', () {
      const zoomThresholds = defaultEarthquakeHistoryMapLayerZoomThresholds;

      expect(
        resolver.regionFillOpacity(
          mode: EarthquakeHistoryMapLayerMode.region,
          zoomThresholds: zoomThresholds,
          visibleOpacity: 0.6,
        ),
        0.6,
      );
    });

    test('city モードの cityFillOpacity は固定値を返す', () {
      const zoomThresholds = defaultEarthquakeHistoryMapLayerZoomThresholds;

      expect(
        resolver.cityFillOpacity(
          mode: EarthquakeHistoryMapLayerMode.city,
          zoomThresholds: zoomThresholds,
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
      dataSource: EarthquakeDataSource.jmaDisasterInformationXml,
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
