import 'dart:convert';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_field_ownership.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_metadata.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

void main() {
  const factory = EarthquakeVxseDebugDraftFactory();

  group('EarthquakeVxseDebugDraftFactory', () {
    final current = _fullEarthquake();

    test('VXSE51は現在の最大震度・地域・都道府県を使う', () {
      final draft = factory.create(
        current: current,
        type: EarthquakeTelegramType.vxse51,
      );

      expect(draft, isA<EarthquakeVxse51DebugDraft>());
      final vxse51 = draft as EarthquakeVxse51DebugDraft;
      expect(vxse51.status, TelegramStatus.normal);
      expect(vxse51.maxIntensity, JmaIntensity.fiveLower);
      expect(vxse51.regions, current.intensity?.regions);
      expect(vxse51.prefectures[JmaIntensity.fiveLower], [
        current
            .intensity
            ?.intensityTree[JmaIntensity.fiveLower]
            ?.single
            .prefecture,
      ]);
    });

    test('reportedAtはcommentではなく選択typeのtelegram metadataを使う', () {
      final draft = factory.create(
        current: current.copyWith(
          telegramMetadata: [
            EarthquakeTelegramMetadata(
              type: EarthquakeTelegramType.vxse53,
              reportedAt: DateTime.utc(2026, 7, 24, 9),
            ),
          ],
        ),
        type: EarthquakeTelegramType.vxse53,
      );

      expect(draft.reportedAt, DateTime.utc(2026, 7, 24, 9));
    });

    test('VXSE52は現在の震源を使う', () {
      final draft = factory.create(
        current: current,
        type: EarthquakeTelegramType.vxse52,
      );

      expect(draft, isA<EarthquakeVxse52DebugDraft>());
      final vxse52 = draft as EarthquakeVxse52DebugDraft;
      expect(vxse52.hypocenter, current.hypocenter);
      expect(vxse52.status, TelegramStatus.normal);
      expect(vxse52.originTime, current.originTime);
      expect(vxse52.arrivalTime, current.arrivalTime);
    });

    test('VXSE53は現在の震源と震度明細を使う', () {
      final draft = factory.create(
        current: current,
        type: EarthquakeTelegramType.vxse53,
      );

      expect(draft, isA<EarthquakeVxse53DebugDraft>());
      final vxse53 = draft as EarthquakeVxse53DebugDraft;
      expect(vxse53.hypocenter, current.hypocenter);
      expect(vxse53.status, TelegramStatus.normal);
      expect(vxse53.originTime, current.originTime);
      expect(vxse53.arrivalTime, current.arrivalTime);
      expect(vxse53.earthquakeType, EarthquakeType.distant);
      expect(vxse53.maxIntensity, JmaIntensity.fiveLower);
      expect(vxse53.regions, current.intensity?.regions);
      expect(vxse53.intensityTree, current.intensity?.intensityTree);
      expect(
        vxse53
            .intensityTree[JmaIntensity.fiveLower]
            ?.single
            .cities
            .single
            .stations
            .single
            .station,
        _station,
      );
      expect(_jsonRoundTrip(vxse53), vxse53);
    });

    test('VXSE61は現在の更新対象震源を使う', () {
      final draft = factory.create(
        current: current,
        type: EarthquakeTelegramType.vxse61,
      );

      expect(draft, isA<EarthquakeVxse61DebugDraft>());
      final vxse61 = draft as EarthquakeVxse61DebugDraft;
      expect(vxse61.hypocenter, current.hypocenter);
      expect(vxse61.status, TelegramStatus.normal);
      expect(vxse61.originTime, current.originTime);
      expect(vxse61.arrivalTime, current.arrivalTime);
    });

    test('VXSE62は現在の長周期地震動階級と明細を使う', () {
      final draft = factory.create(
        current: current,
        type: EarthquakeTelegramType.vxse62,
      );

      expect(draft, isA<EarthquakeVxse62DebugDraft>());
      final vxse62 = draft as EarthquakeVxse62DebugDraft;
      expect(vxse62.hypocenter, current.hypocenter);
      expect(vxse62.status, TelegramStatus.normal);
      expect(vxse62.originTime, current.originTime);
      expect(vxse62.arrivalTime, current.arrivalTime);
      expect(vxse62.maxIntensity, JmaIntensity.fiveLower);
      expect(vxse62.maxLpgmIntensity, JmaLpgmIntensity.two);
      expect(vxse62.regions, current.intensity?.regions);
      expect(vxse62.intensityTree, current.intensity?.intensityTree);
      expect(vxse62.lpgmIntensityTree, current.intensity?.lpgmIntensityTree);
      expect(vxse62.lpgmRegions[JmaLpgmIntensity.two]?.single.region, _region);
      expect(
        vxse62
            .lpgmIntensityTree[JmaLpgmIntensity.two]
            ?.single
            .cities
            .single
            .stations
            .single
            .station,
        _station,
      );
      expect(_jsonRoundTrip(vxse62), vxse62);
    });

    test('不足値を補完したfactory出力は繰り返し同一JSONになる', () {
      final minimal = _minimalEarthquake();

      for (final type in const [
        EarthquakeTelegramType.vxse51,
        EarthquakeTelegramType.vxse52,
        EarthquakeTelegramType.vxse53,
        EarthquakeTelegramType.vxse61,
        EarthquakeTelegramType.vxse62,
      ]) {
        final first = factory.create(current: minimal, type: type);
        final second = factory.create(current: minimal, type: type);

        expect(second.toJson(), first.toJson(), reason: type.name);
        final json =
            jsonDecode(jsonEncode(first.toJson())) as Map<String, dynamic>;
        expect(EarthquakeVxseDebugDraft.fromJson(json), first);
      }
    });

    test('不足震度明細はchecked-in JMA identityで補完する', () {
      final draft =
          factory.create(
                current: _minimalEarthquake(),
                type: EarthquakeTelegramType.vxse53,
              )
              as EarthquakeVxse53DebugDraft;
      final region = draft.regions.values.single.single.region;
      final city = draft.intensityTree.values.single.single.cities.single.city;
      final station = draft
          .intensityTree
          .values
          .single
          .single
          .cities
          .single
          .stations
          .single
          .station;

      expect((region.code, region.name.ja), ('350', '東京都２３区'));
      expect((city.code, city.name.ja), ('1310100', '東京千代田区'));
      expect(
        (station.code, station.noCode, station.name.ja),
        ('1310100', '3500000', '東京千代田区大手町'),
      );
    });

    test('各電文のfield ownershipはbackend writerと一致する', () {
      expect(
        EarthquakeVxseFieldOwnership.forType(
          EarthquakeTelegramType.vxse51,
        ).fields,
        {
          EarthquakeVxseOwnedField.status,
          EarthquakeVxseOwnedField.reportedAt,
          EarthquakeVxseOwnedField.maxIntensity,
          EarthquakeVxseOwnedField.intensityRegions,
          EarthquakeVxseOwnedField.intensityPrefectures,
          EarthquakeVxseOwnedField.comments,
        },
      );
      expect(
        EarthquakeVxseFieldOwnership.forType(
          EarthquakeTelegramType.vxse52,
        ).fields,
        {
          EarthquakeVxseOwnedField.status,
          EarthquakeVxseOwnedField.reportedAt,
          EarthquakeVxseOwnedField.arrivalTime,
          EarthquakeVxseOwnedField.originTime,
          EarthquakeVxseOwnedField.hypocenter,
          EarthquakeVxseOwnedField.magnitude,
          EarthquakeVxseOwnedField.depth,
          EarthquakeVxseOwnedField.comments,
        },
      );
      expect(
        EarthquakeVxseFieldOwnership.forType(
          EarthquakeTelegramType.vxse53,
        ).fields,
        {
          EarthquakeVxseOwnedField.status,
          EarthquakeVxseOwnedField.reportedAt,
          EarthquakeVxseOwnedField.arrivalTime,
          EarthquakeVxseOwnedField.originTime,
          EarthquakeVxseOwnedField.hypocenter,
          EarthquakeVxseOwnedField.magnitude,
          EarthquakeVxseOwnedField.depth,
          EarthquakeVxseOwnedField.earthquakeType,
          EarthquakeVxseOwnedField.maxIntensity,
          EarthquakeVxseOwnedField.intensityRegions,
          EarthquakeVxseOwnedField.intensityPrefectures,
          EarthquakeVxseOwnedField.intensityCities,
          EarthquakeVxseOwnedField.intensityStations,
          EarthquakeVxseOwnedField.comments,
        },
      );
      expect(
        EarthquakeVxseFieldOwnership.forType(
          EarthquakeTelegramType.vxse61,
        ).fields,
        {
          EarthquakeVxseOwnedField.status,
          EarthquakeVxseOwnedField.reportedAt,
          EarthquakeVxseOwnedField.arrivalTime,
          EarthquakeVxseOwnedField.originTime,
          EarthquakeVxseOwnedField.hypocenter,
          EarthquakeVxseOwnedField.magnitude,
          EarthquakeVxseOwnedField.depth,
          EarthquakeVxseOwnedField.comments,
        },
      );
      expect(
        EarthquakeVxseFieldOwnership.forType(
          EarthquakeTelegramType.vxse62,
        ).fields,
        {
          EarthquakeVxseOwnedField.status,
          EarthquakeVxseOwnedField.reportedAt,
          EarthquakeVxseOwnedField.arrivalTime,
          EarthquakeVxseOwnedField.originTime,
          EarthquakeVxseOwnedField.hypocenter,
          EarthquakeVxseOwnedField.magnitude,
          EarthquakeVxseOwnedField.depth,
          EarthquakeVxseOwnedField.maxIntensity,
          EarthquakeVxseOwnedField.intensityRegions,
          EarthquakeVxseOwnedField.intensityPrefectures,
          EarthquakeVxseOwnedField.intensityStations,
          EarthquakeVxseOwnedField.maxLpgmIntensity,
          EarthquakeVxseOwnedField.lpgmRegions,
          EarthquakeVxseOwnedField.lpgmPrefectures,
          EarthquakeVxseOwnedField.lpgmStations,
          EarthquakeVxseOwnedField.comments,
        },
      );
    });
  });
}

EarthquakeVxseDebugDraft _jsonRoundTrip(EarthquakeVxseDebugDraft draft) =>
    EarthquakeVxseDebugDraft.fromJson(
      jsonDecode(jsonEncode(draft.toJson())) as Map<String, dynamic>,
    );

const _station = EarthquakeParameterStationItem(
  code: '1310100',
  noCode: '3500000',
  name: LocalizedName(ja: '東京千代田区大手町'),
  kana: 'トウキョウチヨダクオオテマチ',
  status: EarthquakeStationStatus.operating,
  sourceStatus: '現',
  owner: '気象庁',
  location: LatLng(35.6889, 139.7558),
  arv400: 1.43,
);

const _city = EarthquakeParameterCityItem(
  code: '1310100',
  name: LocalizedName(ja: '東京千代田区'),
  kana: 'トウキョウチヨダク',
  stations: [_station],
);

const _region = EarthquakeParameterRegionItem(
  code: '350',
  name: LocalizedName(ja: '東京都２３区'),
  kana: 'トウキョウトニジュウサンク',
  cities: [_city],
);

const _prefecture = EarthquakeParameterPrefectureItem(
  code: '13',
  name: LocalizedName(ja: '東京都'),
  regions: [_region],
);

const _stationIntensity = IntensityStation(
  code: '1310100',
  name: '東京千代田区大手町',
  sva: 12.3,
  prePeriods: [
    PrePeriod(band: 1.6, lpgmIntensity: JmaLpgmIntensity.two, sva: 12.3),
  ],
  maxIntensity: JmaIntensity.fiveLower,
  maxLpgmIntensity: JmaLpgmIntensity.two,
);

Earthquake _fullEarthquake() => Earthquake(
  eventId: '20260724010101',
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026, 7, 24, 1),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: DateTime.utc(2026, 7, 24, 1, 1),
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  telegramTypes: const [EarthquakeTelegramType.vxse53],
  telegramComments: [
    EarthquakeTelegramComment(
      type: EarthquakeTelegramType.vxse53,
      reportedAt: DateTime.utc(2026, 7, 24, 1, 2),
      additional: 'テストコメント',
      free: null,
    ),
  ],
  hypocenter: const EarthquakeHypocenter(
    code: '477',
    name: '東京湾',
    coordinates: Coordinate.latLng(latitude: 35.5, longitude: 139.8),
    magnitude: EarthquakeMagnitude.value(value: 5.2),
    depth: EarthquakeDepth.value(value: 40),
    detailedCode: null,
    detailedName: null,
  ),
  intensity: const EarthquakeIntensity(
    maxIntensity: JmaIntensity.fiveLower,
    maxLpgmIntensity: JmaLpgmIntensity.two,
    regions: {
      JmaIntensity.fiveLower: [
        IntensityRegion(region: _region, maxIntensity: JmaIntensity.fiveLower),
      ],
    },
    intensityTree: {
      JmaIntensity.fiveLower: [
        PrefectureIntensityNode(
          prefecture: IntensityPrefecture(
            prefecture: _prefecture,
            maxIntensity: JmaIntensity.fiveLower,
          ),
          cities: [
            CityIntensityNode(
              city: _city,
              maxIntensity: JmaIntensity.fiveLower,
              stations: [
                StationIntensityNode(
                  station: _station,
                  intensity: _stationIntensity,
                ),
              ],
              maxLpgmIntensity: JmaLpgmIntensity.two,
            ),
          ],
        ),
      ],
    },
    lpgmIntensityTree: {
      JmaLpgmIntensity.two: [
        PrefectureLpgmIntensityNode(
          region: _region,
          maxLpgmIntensity: JmaLpgmIntensity.two,
          cities: [
            CityLpgmIntensityNode(
              city: _city,
              maxLpgmIntensity: JmaLpgmIntensity.two,
              stations: [
                StationLpgmIntensityNode(
                  station: _station,
                  intensity: _stationIntensity,
                ),
              ],
            ),
          ],
        ),
      ],
    },
  ),
  earthquakeType: EarthquakeType.distant,
  estimatedIntensityTileUrl: null,
);

Earthquake _minimalEarthquake() => const Earthquake(
  eventId: 'minimal-event',
  status: TelegramStatus.test,
  originTime: null,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: [],
  telegramTypes: [],
  hypocenter: null,
  intensity: null,
  earthquakeType: null,
  estimatedIntensityTileUrl: null,
);
