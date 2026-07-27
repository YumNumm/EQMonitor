import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_map_focus.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ShakeDetectionLevel;
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

const _homeBounds = LiveMonitorGeoBounds(
  minLat: 20,
  maxLat: 46,
  minLng: 120,
  maxLng: 154,
);

final _now = DateTime.utc(2026, 7, 27, 12);

EewTelegramItem _eew({double? latitude, double? longitude}) => EewTelegramItem(
  eventId: 'eew',
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: _now,
  isPlum: false,
  hypocenter: EewHypocenterInfo(
    code: '001',
    name: 'テスト震源',
    latitude: latitude,
    longitude: longitude,
  ),
);

ShakeDetectionEvent _shake({
  required double minLat,
  required double maxLat,
  required double minLng,
  required double maxLng,
  String? correlatedEewEventId,
}) => ShakeDetectionEvent(
  eventId: 'shake',
  serialNo: 1,
  createdAt: _now,
  updatedAt: _now,
  expiresAt: _now.add(const Duration(minutes: 1)),
  level: ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: minLat,
  maxLat: maxLat,
  minLng: minLng,
  maxLng: maxLng,
  changeReasons: const ['new_event'],
  correlatedEewEventId: correlatedEewEventId,
);

Earthquake _earthquakeWithHypocenterAndStation({
  Coordinate? hypocenterCoordinates,
  LatLng? stationLocation,
  List<({String code, JmaIntensity intensity, LatLng location})>? stations,
}) {
  final stationFixtures =
      stations ??
      [
        (
          code: 'station',
          intensity: JmaIntensity.four,
          location: stationLocation ?? const LatLng(42, 145),
        ),
      ];
  final stationItems = stationFixtures
      .map(
        (fixture) => EarthquakeParameterStationItem(
          code: fixture.code,
          noCode: fixture.code,
          name: LocalizedName(ja: 'テスト観測点${fixture.code}'),
          kana: null,
          status: EarthquakeStationStatus.operating,
          sourceStatus: 'test',
          owner: 'test',
          location: fixture.location,
        ),
      )
      .toList(growable: false);
  final city = EarthquakeParameterCityItem(
    code: 'city',
    name: LocalizedName(ja: 'テスト市'),
    kana: null,
    stations: stationItems,
  );
  final prefecture = EarthquakeParameterPrefectureItem(
    code: 'prefecture',
    name: LocalizedName(ja: 'テスト県'),
    regions: [],
  );
  return Earthquake(
    eventId: 'earthquake',
    status: TelegramStatus.normal,
    originTime: _now,
    originTimePrecision: OriginTimePrecision.second,
    arrivalTime: _now,
    dataSources: const [],
    telegramTypes: const [],
    hypocenter: EarthquakeHypocenter(
      code: '002',
      name: 'テスト震源',
      coordinates:
          hypocenterCoordinates ??
          const Coordinate.latLng(latitude: 34, longitude: 131),
      magnitude: const EarthquakeMagnitude.value(value: 5),
      depth: const EarthquakeDepth.value(value: 10),
      detailedCode: null,
      detailedName: null,
    ),
    intensity: EarthquakeIntensity(
      maxIntensity: JmaIntensity.four,
      maxLpgmIntensity: null,
      regions: const {},
      intensityTree: {
        JmaIntensity.four: [
          PrefectureIntensityNode(
            prefecture: IntensityPrefecture(
              prefecture: prefecture,
              maxIntensity: JmaIntensity.four,
            ),
            cities: [
              CityIntensityNode(
                city: city,
                maxIntensity: JmaIntensity.four,
                stations: stationItems
                    .map(
                      (station) => StationIntensityNode(
                        station: station,
                        intensity: IntensityStation(
                          code: station.code,
                          name: station.name.ja,
                          sva: null,
                          prePeriods: null,
                          maxIntensity: stationFixtures
                              .firstWhere(
                                (fixture) => fixture.code == station.code,
                              )
                              .intensity,
                          maxLpgmIntensity: null,
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ],
          ),
        ],
      },
      lpgmIntensityTree: const {},
    ),
    estimatedIntensityTileUrl: null,
  );
}

void main() {
  const builder = LiveMonitorMapFocusBuilder();

  test('複数EEW点と揺れ検知矩形を一つのboundsへ含める', () {
    final focus = builder.forRealtime(
      homeBounds: _homeBounds,
      eews: [
        _eew(latitude: 35, longitude: 135),
        _eew(latitude: 40, longitude: 142),
      ],
      shakes: [_shake(minLat: 33, maxLat: 34, minLng: 130, maxLng: 132)],
      obscuredBottom: 180,
    );

    expect(focus.bounds.contains(latitude: 33, longitude: 130), isTrue);
    expect(focus.bounds.contains(latitude: 40, longitude: 142), isTrue);
    expect(focus.padding.bottom, 188);
  });

  test('座標の片方が欠けたEEWだけを除外し有効点を使う', () {
    final focus = builder.forRealtime(
      homeBounds: _homeBounds,
      eews: [
        _eew(latitude: 35, longitude: null),
        _eew(latitude: 36, longitude: 140),
      ],
      shakes: const [],
      obscuredBottom: 0,
    );

    expect(focus.bounds.contains(latitude: 36, longitude: 140), isTrue);
    expect(focus.bounds, isNot(_homeBounds));
  });

  test('有効点の周囲へ地理的な余白を加える', () {
    final focus = builder.forRealtime(
      homeBounds: _homeBounds,
      eews: [_eew(latitude: 35, longitude: 140)],
      shakes: const [],
      obscuredBottom: 0,
    );

    expect(focus.bounds.minLat, lessThan(35));
    expect(focus.bounds.maxLat, greaterThan(35));
    expect(focus.bounds.minLng, lessThan(140));
    expect(focus.bounds.maxLng, greaterThan(140));
  });

  test('有効座標がない場合だけHome boundsへ戻る', () {
    final focus = builder.forRealtime(
      homeBounds: _homeBounds,
      eews: [_eew(latitude: null, longitude: null)],
      shakes: const [],
      obscuredBottom: 0,
    );

    expect(focus.bounds, _homeBounds);
  });

  test('結合済み揺れ検知だけではHome fallbackを使う', () {
    final focus = builder.forRealtime(
      homeBounds: _homeBounds,
      eews: const [],
      shakes: [
        _shake(
          minLat: 33,
          maxLat: 34,
          minLng: 130,
          maxLng: 132,
          correlatedEewEventId: 'eew-1',
        ),
      ],
      obscuredBottom: 0,
    );

    expect(focus.bounds, _homeBounds);
  });

  test('未結合揺れ検知と混在しても結合済み矩形を含めない', () {
    final focus = builder.forRealtime(
      homeBounds: _homeBounds,
      eews: const [],
      shakes: [
        _shake(minLat: 33, maxLat: 34, minLng: 130, maxLng: 132),
        _shake(
          minLat: 80,
          maxLat: 81,
          minLng: 170,
          maxLng: 171,
          correlatedEewEventId: 'eew-1',
        ),
      ],
      obscuredBottom: 0,
    );

    expect(focus.bounds.contains(latitude: 33, longitude: 130), isTrue);
    expect(focus.bounds.maxLat, lessThan(80));
    expect(focus.bounds.maxLng, lessThan(170));
  });

  test('不正EEW座標と揺れ矩形を除外して有効点を維持する', () {
    final focus = builder.forRealtime(
      homeBounds: _homeBounds,
      eews: [
        _eew(latitude: double.nan, longitude: 139),
        _eew(latitude: double.infinity, longitude: 139),
        _eew(latitude: 91, longitude: 139),
        _eew(latitude: 36, longitude: 140),
      ],
      shakes: [
        _shake(minLat: double.nan, maxLat: 34, minLng: 130, maxLng: 132),
        _shake(minLat: 33, maxLat: 34, minLng: 181, maxLng: 182),
      ],
      obscuredBottom: 0,
    );

    expect(focus.bounds.contains(latitude: 36, longitude: 140), isTrue);
    expect(focus.bounds.maxLat, lessThan(80));
  });

  test('全ての不正 realtime targetではHome fallbackを使う', () {
    final focus = builder.forRealtime(
      homeBounds: _homeBounds,
      eews: [_eew(latitude: -91, longitude: 139)],
      shakes: [
        _shake(minLat: 33, maxLat: double.infinity, minLng: 130, maxLng: 132),
      ],
      obscuredBottom: 0,
    );

    expect(focus.bounds, _homeBounds);
  });

  test('地震は震源と取得済み観測点を含む', () {
    final focus = builder.forEarthquake(
      earthquake: _earthquakeWithHypocenterAndStation(),
      fallbackBounds: _homeBounds,
      obscuredTop: 0,
      obscuredBottom: 120,
    );

    expect(focus.bounds.contains(latitude: 34, longitude: 131), isTrue);
    expect(focus.bounds.contains(latitude: 42, longitude: 145), isTrue);
    expect(focus.padding.bottom, 128);
  });

  test('地震は震度1以上の観測点だけを含み上下の遮蔽量をpaddingへ加える', () {
    const unknownLocation = LatLng(46, 151);
    const zeroLocation = LatLng(45, 150);
    const oneLocation = LatLng(35, 132);
    const fourLocation = LatLng(36, 133);
    final focus = builder.forEarthquake(
      earthquake: _earthquakeWithHypocenterAndStation(
        stations: const [
          (
            code: 'unknown',
            intensity: JmaIntensity.unknown,
            location: unknownLocation,
          ),
          (code: 'zero', intensity: JmaIntensity.zero, location: zeroLocation),
          (code: 'one', intensity: JmaIntensity.one, location: oneLocation),
          (code: 'four', intensity: JmaIntensity.four, location: fourLocation),
        ],
      ),
      fallbackBounds: _homeBounds,
      obscuredTop: 36,
      obscuredBottom: 92,
    );

    expect(
      focus.bounds.contains(
        latitude: oneLocation.lat,
        longitude: oneLocation.lon,
      ),
      isTrue,
    );
    expect(
      focus.bounds.contains(
        latitude: fourLocation.lat,
        longitude: fourLocation.lon,
      ),
      isTrue,
    );
    expect(
      focus.bounds.contains(
        latitude: zeroLocation.lat,
        longitude: zeroLocation.lon,
      ),
      isFalse,
    );
    expect(
      focus.bounds.contains(
        latitude: unknownLocation.lat,
        longitude: unknownLocation.lon,
      ),
      isFalse,
    );
    expect(focus.padding.top, 44);
    expect(focus.padding.bottom, 100);
  });

  test('地震の座標が欠ける場合はcaller fallbackを使う', () {
    final earthquake = _earthquakeWithHypocenterAndStation().copyWith(
      hypocenter: const EarthquakeHypocenter(
        code: '002',
        name: 'テスト震源',
        coordinates: Coordinate.unknown(),
        magnitude: EarthquakeMagnitude.value(value: 5),
        depth: EarthquakeDepth.value(value: 10),
        detailedCode: null,
        detailedName: null,
      ),
      intensity: null,
    );
    final focus = builder.forEarthquake(
      earthquake: earthquake,
      fallbackBounds: _homeBounds,
      obscuredTop: 0,
      obscuredBottom: 0,
    );

    expect(focus.bounds, _homeBounds);
  });

  test('不正な地震震源を除外して有効な観測点を維持する', () {
    final focus = builder.forEarthquake(
      earthquake: _earthquakeWithHypocenterAndStation(
        hypocenterCoordinates: const Coordinate.latLng(
          latitude: double.nan,
          longitude: 131,
        ),
      ),
      fallbackBounds: _homeBounds,
      obscuredTop: 0,
      obscuredBottom: 0,
    );

    expect(focus.bounds.contains(latitude: 42, longitude: 145), isTrue);
    expect(focus.bounds.minLat, greaterThan(40));
  });

  test('全ての不正な地震座標ではcaller fallbackを使う', () {
    final focus = builder.forEarthquake(
      earthquake: _earthquakeWithHypocenterAndStation(
        hypocenterCoordinates: const Coordinate.latLng(
          latitude: double.infinity,
          longitude: 131,
        ),
        stationLocation: const LatLng(91, 145),
      ),
      fallbackBounds: _homeBounds,
      obscuredTop: 0,
      obscuredBottom: 0,
    );

    expect(focus.bounds, _homeBounds);
  });

  test('範囲外の地震震源を除外して有効な観測点を維持する', () {
    final focus = builder.forEarthquake(
      earthquake: _earthquakeWithHypocenterAndStation(
        hypocenterCoordinates: const Coordinate.latLng(
          latitude: 91,
          longitude: 181,
        ),
      ),
      fallbackBounds: _homeBounds,
      obscuredTop: 0,
      obscuredBottom: 0,
    );

    expect(focus.bounds.contains(latitude: 42, longitude: 145), isTrue);
    expect(focus.bounds.minLat, greaterThan(40));
  });

  test('NaNとInfinityの観測点を除外して有効な震源を維持する', () {
    final focus = builder.forEarthquake(
      earthquake: _earthquakeWithHypocenterAndStation(
        stationLocation: const LatLng(double.nan, double.infinity),
      ),
      fallbackBounds: _homeBounds,
      obscuredTop: 0,
      obscuredBottom: 0,
    );

    expect(focus.bounds.contains(latitude: 34, longitude: 131), isTrue);
    expect(focus.bounds.maxLat, lessThan(40));
  });

  test('範囲外震源と不正観測点だけではcaller fallbackを使う', () {
    final focus = builder.forEarthquake(
      earthquake: _earthquakeWithHypocenterAndStation(
        hypocenterCoordinates: const Coordinate.latLng(
          latitude: -91,
          longitude: 181,
        ),
        stationLocation: const LatLng(double.nan, double.infinity),
      ),
      fallbackBounds: _homeBounds,
      obscuredTop: 0,
      obscuredBottom: 0,
    );

    expect(focus.bounds, _homeBounds);
  });
}
