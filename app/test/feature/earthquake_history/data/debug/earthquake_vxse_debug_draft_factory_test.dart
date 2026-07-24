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
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:flutter_test/flutter_test.dart';

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

    test('VXSE52は現在の震源を使う', () {
      final draft = factory.create(
        current: current,
        type: EarthquakeTelegramType.vxse52,
      );

      expect(draft, isA<EarthquakeVxse52DebugDraft>());
      expect(
        (draft as EarthquakeVxse52DebugDraft).hypocenter,
        current.hypocenter,
      );
    });

    test('VXSE53は現在の震源と震度明細を使う', () {
      final draft = factory.create(
        current: current,
        type: EarthquakeTelegramType.vxse53,
      );

      expect(draft, isA<EarthquakeVxse53DebugDraft>());
      final vxse53 = draft as EarthquakeVxse53DebugDraft;
      expect(vxse53.hypocenter, current.hypocenter);
      expect(vxse53.maxIntensity, JmaIntensity.fiveLower);
      expect(vxse53.regions, current.intensity?.regions);
      expect(vxse53.intensityTree, current.intensity?.intensityTree);
    });

    test('VXSE61は現在の更新対象震源を使う', () {
      final draft = factory.create(
        current: current,
        type: EarthquakeTelegramType.vxse61,
      );

      expect(draft, isA<EarthquakeVxse61DebugDraft>());
      expect(
        (draft as EarthquakeVxse61DebugDraft).hypocenter,
        current.hypocenter,
      );
    });

    test('VXSE62は現在の長周期地震動階級と明細を使う', () {
      final draft = factory.create(
        current: current,
        type: EarthquakeTelegramType.vxse62,
      );

      expect(draft, isA<EarthquakeVxse62DebugDraft>());
      final vxse62 = draft as EarthquakeVxse62DebugDraft;
      expect(vxse62.hypocenter, current.hypocenter);
      expect(vxse62.maxLpgmIntensity, JmaLpgmIntensity.two);
      expect(vxse62.lpgmIntensityTree, current.intensity?.lpgmIntensityTree);
      expect(vxse62.lpgmRegions[JmaLpgmIntensity.two]?.single.region, _region);
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

    test('各電文のfield ownershipはbackend writerと一致する', () {
      expect(
        EarthquakeVxseFieldOwnership.forType(
          EarthquakeTelegramType.vxse51,
        ).fields,
        {
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
          EarthquakeVxseOwnedField.hypocenter,
          EarthquakeVxseOwnedField.magnitude,
          EarthquakeVxseOwnedField.depth,
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
          EarthquakeVxseOwnedField.hypocenter,
          EarthquakeVxseOwnedField.magnitude,
          EarthquakeVxseOwnedField.depth,
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

const _region = EarthquakeParameterRegionItem(
  code: '130000',
  name: LocalizedName(ja: '東京都'),
  kana: 'とうきょうと',
  cities: [],
);

const _prefecture = EarthquakeParameterPrefectureItem(
  code: '13',
  name: LocalizedName(ja: '東京都'),
  regions: [_region],
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
    code: '471',
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
          cities: [],
        ),
      ],
    },
    lpgmIntensityTree: {
      JmaLpgmIntensity.two: [
        PrefectureLpgmIntensityNode(
          region: _region,
          maxLpgmIntensity: JmaLpgmIntensity.two,
          cities: [],
        ),
      ],
    },
  ),
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
  estimatedIntensityTileUrl: null,
);
