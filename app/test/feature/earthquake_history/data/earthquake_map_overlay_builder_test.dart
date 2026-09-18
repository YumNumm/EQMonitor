import 'dart:typed_data';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_metadata.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

const _regionA = EarthquakeParameterRegionItem(
  code: 'R-A',
  name: LocalizedName(ja: '地域A'),
  kana: null,
  cities: [],
);
const _prefecture = IntensityPrefecture(
  prefecture: EarthquakeParameterPrefectureItem(
    code: 'P-FORECAST-ONLY',
    name: LocalizedName(ja: '都道府県'),
    regions: [],
  ),
  maxIntensity: JmaIntensity.four,
);

EarthquakeParameterCityItem _city(String code) => EarthquakeParameterCityItem(
  code: code,
  name: LocalizedName(ja: code),
  kana: null,
  stations: const [],
);

StationIntensityNode _station({
  required String code,
  required JmaIntensity intensity,
  required LatLng location,
}) {
  final station = EarthquakeParameterStationItem(
    code: code,
    noCode: code,
    name: LocalizedName(ja: code),
    kana: null,
    status: EarthquakeStationStatus.operating,
    sourceStatus: 'test',
    owner: 'test',
    location: location,
  );
  return StationIntensityNode(
    station: station,
    intensity: IntensityStation(
      code: code,
      name: code,
      sva: null,
      prePeriods: null,
      maxIntensity: intensity,
      maxLpgmIntensity: null,
    ),
  );
}

EarthquakeIntensity _intensity() {
  final maxStation = _station(
    code: 'ST-MAX',
    intensity: JmaIntensity.four,
    location: const LatLng(35.25, 139.75),
  );
  final otherStation = _station(
    code: 'ST-OTHER',
    intensity: JmaIntensity.three,
    location: const LatLng(34.5, 138.5),
  );
  final strongerDuplicate = _station(
    code: 'ST-OTHER',
    intensity: JmaIntensity.four,
    location: const LatLng(35, 140),
  );
  final firstStation = _station(
    code: 'ST-A',
    intensity: JmaIntensity.three,
    location: const LatLng(33, 137),
  );
  final lastStation = _station(
    code: 'ST-Z',
    intensity: JmaIntensity.three,
    location: const LatLng(36, 141),
  );
  return EarthquakeIntensity(
    maxIntensity: JmaIntensity.four,
    maxLpgmIntensity: null,
    regions: const {
      JmaIntensity.three: [
        IntensityRegion(region: _regionA, maxIntensity: JmaIntensity.three),
      ],
      JmaIntensity.four: [
        IntensityRegion(region: _regionA, maxIntensity: JmaIntensity.four),
      ],
    },
    intensityTree: {
      JmaIntensity.three: [
        PrefectureIntensityNode(
          prefecture: _prefecture,
          cities: [
            CityIntensityNode(
              city: _city('C-A'),
              maxIntensity: JmaIntensity.three,
              stations: [lastStation, otherStation],
            ),
          ],
        ),
      ],
      JmaIntensity.four: [
        PrefectureIntensityNode(
          prefecture: _prefecture,
          cities: [
            CityIntensityNode(
              city: _city('C-A'),
              maxIntensity: JmaIntensity.four,
              stations: [strongerDuplicate, maxStation, firstStation],
            ),
          ],
        ),
      ],
    },
    lpgmIntensityTree: const {},
  );
}

Earthquake _earthquake({
  required EarthquakeIntensity? intensity,
  required List<EarthquakeTelegramMetadata> metadata,
  EarthquakeHypocenter? hypocenter,
}) => Earthquake(
  eventId: '20260823123456',
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026, 8, 23, 12, 34, 56),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: const [],
  telegramTypes: const [EarthquakeTelegramType.vxse53],
  telegramMetadata: metadata,
  hypocenter: hypocenter,
  intensity: intensity,
  estimatedIntensityTileUrl: null,
);

EarthquakeHypocenter _hypocenter(Coordinate? coordinates) =>
    EarthquakeHypocenter(
      code: '477',
      name: '東京湾',
      coordinates: coordinates,
      magnitude: const EarthquakeMagnitude.value(value: 5.2),
      depth: const EarthquakeDepth.value(value: 40),
      detailedCode: null,
      detailedName: null,
    );

MapSpriteAtlas _spriteAtlas() => createMapSpriteAtlas(
  identity: createMapSourceIdentity(value: 'sha256:atlas-a'),
  width: 2,
  height: 1,
  rgbaBytes: Uint8List.fromList(const [255, 0, 0, 255, 0, 0, 255, 255]),
  regions: const [
    MapSpriteRegion(
      id: 'normal',
      normalizedUv: Rect.fromLTRB(0.25, 0.5, 0.25, 0.5),
      logicalSize: Size(1, 1),
    ),
    MapSpriteRegion(
      id: 'low-precision',
      normalizedUv: Rect.fromLTRB(0.75, 0.5, 0.75, 0.5),
      logicalSize: Size(1, 1),
    ),
  ],
  limits: const MapSpriteAtlasLimits(
    maxWidth: 2,
    maxHeight: 1,
    maxPixelBytes: 8,
    maxRegions: 2,
  ),
);

void main() {
  final colors = AppTheme.eqmonitorDefault()
      .colorSetFor(Brightness.light)
      .intensity;
  const builder = EarthquakeMapOverlayBuilder();
  const parameter = EarthquakeHistoryMapLayerParameter();

  MapOverlayVersionStamp versionStamp({
    String sourceIdentity = '20260823123456',
  }) => createMapOverlayVersionStamp(
    sourceIdentity: createMapSourceIdentity(value: sourceIdentity),
    sourceIncarnation: createMapSourceIncarnation(value: 'incarnation-a'),
    dataSequence: 0,
    dataDigest: 'data-a',
    renderGeneration: 0,
    renderDigest: 'render-a',
  );

  test('同一region/city codeを最大震度styleだけへ正規化する', () {
    final result = builder.build(
      earthquake: _earthquake(
        intensity: _intensity(),
        metadata: [
          EarthquakeTelegramMetadata(
            type: EarthquakeTelegramType.vxse53,
            reportedAt: DateTime.utc(2026, 8, 23, 12, 35),
          ),
        ],
      ),
      colorModel: colors,
      versionStamp: versionStamp(),
      parameter: parameter,
      spriteAtlas: _spriteAtlas(),
    );

    expect(result, isA<EarthquakeMapOverlayAvailable>());
    final snapshot = (result as EarthquakeMapOverlayAvailable).snapshot;
    expect(snapshot.regionStyles.map((style) => style.code), ['R-A']);
    expect(snapshot.regionStyles.single.color, colors.four.background);
    expect(snapshot.cityStyles.map((style) => style.code), ['C-A']);
    expect(snapshot.cityStyles.single.color, colors.four.background);
    expect(
      snapshot.regionStyles.map((style) => style.code),
      isNot(contains('P-FORECAST-ONLY')),
    );
  });

  test('station code・座標・震度色・最大震度半径をsnapshotへ変換する', () {
    final result = builder.build(
      earthquake: _earthquake(
        intensity: _intensity(),
        metadata: [
          EarthquakeTelegramMetadata(
            type: EarthquakeTelegramType.vxse53,
            reportedAt: DateTime.utc(2026, 8, 23, 12, 35),
          ),
        ],
      ),
      colorModel: colors,
      versionStamp: versionStamp(),
      parameter: parameter,
      spriteAtlas: _spriteAtlas(),
    ) as EarthquakeMapOverlayAvailable;
    final snapshot = result.snapshot;
    final max = snapshot.stations.singleWhere((point) => point.id == 'ST-MAX');
    final other = snapshot.stations.singleWhere(
      (point) => point.id == 'ST-OTHER',
    );

    expect(snapshot.stations.map((point) => point.id), [
      'ST-A',
      'ST-MAX',
      'ST-OTHER',
      'ST-Z',
    ]);
    expect((max.longitude, max.latitude), (139.75, 35.25));
    expect(max.color, colors.four.background);
    expect(max.radiusLogicalPixels, 6.7);
    expect((other.longitude, other.latitude), (140.0, 35.0));
    expect(other.color, colors.four.background);
    expect(other.radiusLogicalPixels, 6.7);
    expect(snapshot.regionToCityZoom, 6);
    expect(snapshot.stationMinZoom, 6);
    expect(snapshot.regionStyles.single.opacity, 0.6);
    expect(snapshot.cityStyles.single.opacity, 0.6);
  });

  test('providerが発行したversion stampをsnapshotへ保持する', () {
    final latest = DateTime.parse('2026-08-23T21:00:00.123456+09:00');
    final stamp = versionStamp();
    final result = builder.build(
      earthquake: _earthquake(
        intensity: _intensity(),
        metadata: [
          EarthquakeTelegramMetadata(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: DateTime.utc(2026, 8, 23, 11),
          ),
          EarthquakeTelegramMetadata(
            type: EarthquakeTelegramType.vxse53,
            reportedAt: latest,
          ),
        ],
      ),
      colorModel: colors,
      versionStamp: stamp,
      parameter: parameter,
      spriteAtlas: _spriteAtlas(),
    ) as EarthquakeMapOverlayAvailable;

    expect(result.snapshot.versionStamp, same(stamp));
  });

  test('event IDと異なるsource identityを拒否する', () {
    expect(
      () => builder.build(
        earthquake: _earthquake(
          intensity: _intensity(),
          metadata: [
            EarthquakeTelegramMetadata(
              type: EarthquakeTelegramType.vxse53,
              reportedAt: DateTime.utc(2026, 8, 23, 12, 35),
            ),
          ],
        ),
        colorModel: colors,
        versionStamp: versionStamp(sourceIdentity: 'another-event'),
        parameter: parameter,
        spriteAtlas: _spriteAtlas(),
      ),
      throwsArgumentError,
    );
  });

  test('telegram metadataが空ならtyped unavailableを返す', () {
    final result = builder.build(
      earthquake: _earthquake(intensity: _intensity(), metadata: const []),
      colorModel: colors,
      versionStamp: versionStamp(),
      parameter: parameter,
      spriteAtlas: _spriteAtlas(),
    );

    expect(result, isA<EarthquakeMapOverlayUnavailable>());
    expect(
      (result as EarthquakeMapOverlayUnavailable).reason,
      EarthquakeMapOverlayUnavailableReason.missingTelegramMetadata,
    );
  });

  test('震度データがなければtyped unavailableを返す', () {
    final result = builder.build(
      earthquake: _earthquake(intensity: null, metadata: const []),
      colorModel: colors,
      versionStamp: versionStamp(),
      parameter: parameter,
      spriteAtlas: _spriteAtlas(),
    );

    expect(result, isA<EarthquakeMapOverlayUnavailable>());
    expect(
      (result as EarthquakeMapOverlayUnavailable).reason,
      EarthquakeMapOverlayUnavailableReason.noIntensity,
    );
  });

  test('有限かつ範囲内のCoordinateLatLngだけをnormal震源spriteへ変換する', () {
    final result = builder.build(
      earthquake: _earthquake(
        intensity: _intensity(),
        metadata: [
          EarthquakeTelegramMetadata(
            type: EarthquakeTelegramType.vxse53,
            reportedAt: DateTime.utc(2026, 8, 23, 12, 35),
          ),
        ],
        hypocenter: _hypocenter(
          const Coordinate.latLng(latitude: 35.5, longitude: 139.8),
        ),
      ),
      colorModel: colors,
      versionStamp: versionStamp(),
      parameter: parameter,
      spriteAtlas: _spriteAtlas(),
    ) as EarthquakeMapOverlayAvailable;

    final sprite = result.snapshot.sprites.single;
    expect(sprite.id, 'hypocenter:20260823123456');
    expect((sprite.longitude, sprite.latitude), (139.8, 35.5));
    expect(sprite.spriteRegionId, 'normal');
    expect(sprite.priority, 0);
    expect(sprite.sizeScale.valueAt(zoom: 3), 0.15);
    expect(sprite.sizeScale.valueAt(zoom: 20), 0.4);
    expect(sprite.opacity.valueAt(zoom: 7.999), 1);
    expect(sprite.opacity.valueAt(zoom: 8), 0.6);
  });

  test('missing・unknown・非有限・範囲外の震源座標へ固定位置を作らない', () {
    final invalidHypocenters = <EarthquakeHypocenter?>[
      null,
      _hypocenter(null),
      _hypocenter(const Coordinate.unknown()),
      _hypocenter(
        const Coordinate.latLng(latitude: double.nan, longitude: 139),
      ),
      _hypocenter(
        const Coordinate.latLng(latitude: 35, longitude: double.infinity),
      ),
      _hypocenter(const Coordinate.latLng(latitude: 91, longitude: 139)),
      _hypocenter(const Coordinate.latLng(latitude: 35, longitude: 181)),
    ];
    for (final hypocenter in invalidHypocenters) {
      final result = builder.build(
        earthquake: _earthquake(
          intensity: _intensity(),
          metadata: [
            EarthquakeTelegramMetadata(
              type: EarthquakeTelegramType.vxse53,
              reportedAt: DateTime.utc(2026, 8, 23, 12, 35),
            ),
          ],
          hypocenter: hypocenter,
        ),
        colorModel: colors,
        versionStamp: versionStamp(),
        parameter: parameter,
        spriteAtlas: _spriteAtlas(),
      ) as EarthquakeMapOverlayAvailable;

      expect(result.snapshot.sprites, isEmpty);
    }
  });

  test('parameterのzoom・size・fade policyをsnapshotへ変換する', () {
    const customParameter = EarthquakeHistoryMapLayerParameter(
      regionToCity: 7,
      stationMinZoom: 8,
      hypocenterFadeZoom: 9,
      hypocenterIconSizeMin: 0.2,
      hypocenterIconSizeMax: 0.5,
      hypocenterFadeOpacity: 0.4,
    );
    final result = builder.build(
      earthquake: _earthquake(
        intensity: _intensity(),
        metadata: [
          EarthquakeTelegramMetadata(
            type: EarthquakeTelegramType.vxse53,
            reportedAt: DateTime.utc(2026, 8, 23, 12, 35),
          ),
        ],
        hypocenter: _hypocenter(
          const Coordinate.latLng(latitude: 35.5, longitude: 139.8),
        ),
      ),
      colorModel: colors,
      versionStamp: versionStamp(),
      parameter: customParameter,
      spriteAtlas: _spriteAtlas(),
    ) as EarthquakeMapOverlayAvailable;

    final sprite = result.snapshot.sprites.single;
    expect(result.snapshot.regionToCityZoom, 7);
    expect(result.snapshot.stationMinZoom, 8);
    expect(sprite.sizeScale.valueAt(zoom: 3), 0.2);
    expect(sprite.sizeScale.valueAt(zoom: 20), 0.5);
    expect(sprite.opacity.valueAt(zoom: 8.999), 1);
    expect(sprite.opacity.valueAt(zoom: 9), 0.4);
  });
}
