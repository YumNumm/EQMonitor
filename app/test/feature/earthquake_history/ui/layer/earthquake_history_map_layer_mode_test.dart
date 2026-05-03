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
import 'package:jma_parameter_types/earthquake_param.pb.dart';
import 'package:test/test.dart';

void main() {
  final testData = EarthquakeHistoryMapLayerModeTestData();
  const resolver = EarthquakeHistoryMapLayerModeResolver();

  group('resolveEarthquakeHistoryMapLayerMode', () {
    test('fill無効ならnoneを返す', () {
      final earthquake = testData.earthquake(
        intensity: testData.fullIntensity(),
      );
      const config = EarthquakeHistoryDetailConfig();

      final mode = resolver.resolveFillLayerMode(
        earthquake: earthquake,
        config: config,
      );

      expect(mode, EarthquakeHistoryMapLayerMode.none);
    });

    test('regionsのみなら市区町村・観測点・autoはregionにフォールバックする', () {
      final earthquake = testData.earthquake(
        intensity: testData.regionOnlyIntensity(),
      );

      for (final iconMode in [
        EarthquakeHistoryIconMode.municipality,
        EarthquakeHistoryIconMode.station,
        EarthquakeHistoryIconMode.auto,
      ]) {
        final config = EarthquakeHistoryDetailConfig(
          fillMode: EarthquakeHistoryFillMode.matchIcon,
          iconMode: iconMode,
        );

        expect(
          resolver.resolveFillLayerMode(
            earthquake: earthquake,
            config: config,
          ),
          EarthquakeHistoryMapLayerMode.region,
        );
      }
    });

    test('regions + cities + stationsがある場合は設定通り解決する', () {
      final earthquake = testData.earthquake(
        intensity: testData.fullIntensity(),
      );

      final cases = {
        EarthquakeHistoryIconMode.region: EarthquakeHistoryMapLayerMode.region,
        EarthquakeHistoryIconMode.municipality:
            EarthquakeHistoryMapLayerMode.city,
        EarthquakeHistoryIconMode.station:
            EarthquakeHistoryMapLayerMode.station,
        EarthquakeHistoryIconMode.auto: EarthquakeHistoryMapLayerMode.auto,
      };

      for (final entry in cases.entries) {
        final config = EarthquakeHistoryDetailConfig(iconMode: entry.key);

        expect(
          resolver.resolveMapLayerMode(
            earthquake: earthquake,
            config: config,
          ),
          entry.value,
        );
      }
    });

    test('長周期地震動階級モードではLPGM側のデータ可用性で解決する', () {
      final earthquake = testData.earthquake(
        intensity: testData.lpgmFullJmaRegionOnly(),
      );

      const jmaConfig = EarthquakeHistoryDetailConfig(
        iconMode: EarthquakeHistoryIconMode.station,
      );
      const lpgmConfig = EarthquakeHistoryDetailConfig(
        iconMode: EarthquakeHistoryIconMode.station,
        showingLpgmIntensity: true,
      );

      expect(
        resolver.resolveMapLayerMode(
          earthquake: earthquake,
          config: jmaConfig,
        ),
        EarthquakeHistoryMapLayerMode.region,
      );
      expect(
        resolver.resolveMapLayerMode(
          earthquake: earthquake,
          config: lpgmConfig,
        ),
        EarthquakeHistoryMapLayerMode.station,
      );
    });

    test('intensityがない不正な地震データはnoneを返す', () {
      final earthquake = testData.earthquake();
      const config = EarthquakeHistoryDetailConfig(
        fillMode: EarthquakeHistoryFillMode.matchIcon,
      );

      expect(
        resolver.resolveMapLayerMode(
          earthquake: earthquake,
          config: config,
        ),
        EarthquakeHistoryMapLayerMode.none,
      );
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
    test('autoのfill opacityは引数のzoomThresholdsを使う', () {
      const zoomThresholds = EarthquakeHistoryMapLayerZoomThresholds(
        regionToCity: 7.5,
        cityToStation: 12.25,
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
          12.25,
          0.0,
        ],
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
    return EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: null,
      intensityTree: {
        JmaIntensity.four: [
          PrefectureIntensityNode(region: region, cities: const []),
        ],
      },
      lpgmIntensityTree: const {},
    );
  }

  EarthquakeIntensity fullIntensity() {
    final region = regionNode(maxIntensity: JmaIntensity.four);
    final city = cityNode();
    final station = stationNode(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: JmaLpgmIntensity.two,
    );
    final lpgmCity = lpgmCityNode();

    return EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: JmaLpgmIntensity.two,
      intensityTree: {
        JmaIntensity.four: [
          PrefectureIntensityNode(
            region: region,
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
    final station = stationNode(
      maxIntensity: null,
      maxLpgmIntensity: JmaLpgmIntensity.two,
    );
    final lpgmCity = lpgmCityNode();

    return EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: JmaLpgmIntensity.two,
      intensityTree: {
        JmaIntensity.four: [
          PrefectureIntensityNode(region: region, cities: const []),
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
      region: EarthquakeParameterRegionItem(code: '001', name: 'テスト地域'),
      maxIntensity: maxIntensity,
    );
  }

  EarthquakeParameterCityItem cityNode() {
    return EarthquakeParameterCityItem(code: '001001', name: 'テスト市区町村');
  }

  EarthquakeParameterCityItem lpgmCityNode() {
    return EarthquakeParameterCityItem(code: '001001', name: 'テスト市区町村');
  }

  StationIntensityNode stationNode({
    required JmaIntensity? maxIntensity,
    required JmaLpgmIntensity? maxLpgmIntensity,
  }) {
    final station = EarthquakeParameterStationItem(
      code: '001001001',
      name: 'テスト観測点',
    );
    return StationIntensityNode(
      station: station,
      intensity: IntensityStation(
        code: station.code,
        name: station.name,
        sva: null,
        prePeriods: null,
        maxIntensity: maxIntensity,
        maxLpgmIntensity: maxLpgmIntensity,
      ),
    );
  }
}
