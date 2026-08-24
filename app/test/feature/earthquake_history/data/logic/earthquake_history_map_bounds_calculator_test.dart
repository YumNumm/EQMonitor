import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_history_map_bounds_calculator.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:jma_map/jma_map.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:test/test.dart';

void main() {
  const calculator = EarthquakeHistoryMapBoundsCalculator();

  test('震度速報のみの場合は対象細分区域の境界を表示領域に含める', () {
    final points = calculator.calculate(
      earthquake: _earthquake(intensity: _regionOnlyIntensity),
      regionMap: _regionMap,
    );

    expect(points, const [
      (latitude: 34.0, longitude: 138.0),
      (latitude: 36.0, longitude: 140.0),
    ]);
  });

  test('震度速報と震源情報がある場合は対象地域と震源を表示領域に含める', () {
    final points = calculator.calculate(
      earthquake: _earthquake(
        intensity: _regionOnlyIntensity,
        hypocenter: _hypocenter,
      ),
      regionMap: _regionMap,
    );

    expect(points, const [
      (latitude: 34.0, longitude: 138.0),
      (latitude: 36.0, longitude: 140.0),
      (latitude: 37.0, longitude: 141.0),
    ]);
  });

  test('観測点がある場合は従来どおり観測点と震源だけを表示領域に含める', () {
    final points = calculator.calculate(
      earthquake: _earthquake(
        intensity: _stationIntensity,
        hypocenter: _hypocenter,
      ),
      regionMap: _regionMap,
    );

    expect(points, const [
      (latitude: 35.0, longitude: 139.0),
      (latitude: 37.0, longitude: 141.0),
    ]);
  });

  test('観測点のない震度速報だけが細分区域地図を必要とする', () {
    expect(
      calculator.requiresRegionMap(
        earthquake: _earthquake(intensity: _regionOnlyIntensity),
        dbTree: null,
      ),
      isTrue,
    );
    expect(
      calculator.requiresRegionMap(
        earthquake: _earthquake(intensity: _stationIntensity),
        dbTree: null,
      ),
      isFalse,
    );
  });
}

Earthquake _earthquake({
  required EarthquakeIntensity intensity,
  EarthquakeHypocenter? hypocenter,
}) => Earthquake(
  eventId: '202608230001',
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026, 8, 23),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: DateTime.utc(2026, 8, 23),
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  telegramTypes: const [EarthquakeTelegramType.vxse51],
  hypocenter: hypocenter,
  intensity: intensity,
  estimatedIntensityTileUrl: null,
);

const _regionOnlyIntensity = EarthquakeIntensity(
  maxIntensity: JmaIntensity.four,
  maxLpgmIntensity: null,
  regions: {
    JmaIntensity.four: [
      IntensityRegion(
        region: _region,
        maxIntensity: JmaIntensity.four,
      ),
    ],
  },
  intensityTree: {},
  lpgmIntensityTree: {},
);

const _stationIntensity = EarthquakeIntensity(
  maxIntensity: JmaIntensity.four,
  maxLpgmIntensity: null,
  regions: {
    JmaIntensity.four: [
      IntensityRegion(
        region: _region,
        maxIntensity: JmaIntensity.four,
      ),
    ],
  },
  intensityTree: {
    JmaIntensity.four: [
      PrefectureIntensityNode(
        prefecture: IntensityPrefecture(
          prefecture: _prefecture,
          maxIntensity: JmaIntensity.four,
        ),
        cities: [
          CityIntensityNode(
            city: _city,
            maxIntensity: JmaIntensity.four,
            stations: [
              StationIntensityNode(station: _station, intensity: null),
            ],
          ),
        ],
      ),
    ],
  },
  lpgmIntensityTree: {},
);

const _region = EarthquakeParameterRegionItem(
  code: '100',
  name: LocalizedName(ja: 'テスト細分区域'),
  kana: null,
  cities: [],
);

const _prefecture = EarthquakeParameterPrefectureItem(
  code: '10',
  name: LocalizedName(ja: 'テスト都道府県'),
  regions: [_region],
);

const _city = EarthquakeParameterCityItem(
  code: '100001',
  name: LocalizedName(ja: 'テスト市区町村'),
  kana: null,
  stations: [],
);

const _station = EarthquakeParameterStationItem(
  code: '1000010',
  noCode: '1000010',
  name: LocalizedName(ja: 'テスト観測点'),
  kana: null,
  status: EarthquakeStationStatus.operating,
  sourceStatus: 'test',
  owner: 'test',
  location: LatLng(35, 139),
);

const _hypocenter = EarthquakeHypocenter(
  code: '100',
  name: 'テスト震央',
  coordinates: Coordinate.latLng(latitude: 37, longitude: 141),
  magnitude: EarthquakeMagnitude.value(value: 5),
  depth: EarthquakeDepth.value(value: 10),
  detailedCode: null,
  detailedName: null,
);

final _regionMap = JmaMap_JmaMapData(
  mapType: JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_E,
  data: [
    JmaMap_JmaMapData_JmaMapDataItem(
      bounds: JmaMap_LatLngBounds(
        southWest: JmaMap_LatLng(lat: 34, lng: 138),
        northEast: JmaMap_LatLng(lat: 36, lng: 140),
      ),
      property: JmaMap_JmaMapData_JmaMapDataItem_Property(
        code: _region.code,
        name: _region.name.ja,
      ),
    ),
  ],
);
