import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_reducer.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const reducer = EarthquakeVxseDebugReducer();
  const factory = EarthquakeVxseDebugDraftFactory();
  final draftSource = _draftSource();

  group('EarthquakeVxseDebugReducer', () {
    test('VXSE51-onlyへVXSE52をmergeしても最大震度を保持する', () {
      final current = _current().copyWith(
        telegramTypes: const [
          EarthquakeTelegramType.vxse51,
          EarthquakeTelegramType.vxse51,
        ],
      );
      final draft = factory.create(
        current: draftSource,
        type: EarthquakeTelegramType.vxse52,
      );

      final result = reducer.apply(
        current: current,
        draft: draft,
        mode: EarthquakeVxseApplyMode.merge,
      );

      expect(result.intensity?.maxIntensity, JmaIntensity.fiveLower);
      expect(result.hypocenter, earthquakeVxseDebugSampleHypocenter);
      expect(result.telegramTypes, [
        EarthquakeTelegramType.vxse51,
        EarthquakeTelegramType.vxse52,
      ]);
    });

    for (final mode in EarthquakeVxseApplyMode.values) {
      for (final type in _supportedTypes) {
        test('${type.name}を${mode.name}で全owned fieldsへ適用する', () {
          final current = _current();
          final draft = factory.create(current: draftSource, type: type);

          final result = reducer.apply(
            current: current,
            draft: draft,
            mode: mode,
          );

          expect(result.status, TelegramStatus.training);
          expect(result.telegramTypes.where((item) => item == type), [type]);
          expect(result.eventId, current.eventId);
          expect(result.dataSources, current.dataSources);
          expect(result.originTimePrecision, current.originTimePrecision);
          expect(
            result.estimatedIntensityTileUrl,
            current.estimatedIntensityTileUrl,
          );
          expect(
            result.telegramComments,
            contains(
              _comment(
                type: type,
                reportedAt: earthquakeVxseDebugSampleReportedAt,
                text: type.name,
              ),
            ),
          );
          _expectOwnedFieldsApplied(
            result: result,
            current: current,
            type: type,
          );
        });
      }
    }

    test('mergeは同じtype/reportedAtのコメントだけをupsertする', () {
      final reportedAt = DateTime.utc(2026, 7, 24, 3);
      final current = _current().copyWith(
        telegramComments: [
          _comment(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: reportedAt,
            text: 'old',
          ),
          _comment(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: DateTime.utc(2026, 7, 24, 2),
            text: 'older',
          ),
          _comment(
            type: EarthquakeTelegramType.vxse52,
            reportedAt: reportedAt,
            text: 'outside',
          ),
        ],
      );
      final draft = EarthquakeVxseDebugDraft.vxse51(
        eventId: current.eventId,
        reportedAt: reportedAt,
        status: TelegramStatus.normal,
        maxIntensity: JmaIntensity.four,
        regions: const {},
        prefectures: const {},
        comments: [
          _comment(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: reportedAt,
            text: 'new',
          ),
          _comment(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: reportedAt,
            text: 'newest',
          ),
        ],
      );

      final result = reducer.apply(
        current: current,
        draft: draft,
        mode: EarthquakeVxseApplyMode.merge,
      );

      expect(result.telegramComments, [
        _comment(
          type: EarthquakeTelegramType.vxse51,
          reportedAt: DateTime.utc(2026, 7, 24, 2),
          text: 'older',
        ),
        _comment(
          type: EarthquakeTelegramType.vxse52,
          reportedAt: reportedAt,
          text: 'outside',
        ),
        _comment(
          type: EarthquakeTelegramType.vxse51,
          reportedAt: reportedAt,
          text: 'newest',
        ),
      ]);
    });

    test('clearAndApplyは選択typeの旧コメントだけをclearしてから適用する', () {
      final current = _current().copyWith(
        telegramComments: [
          _comment(
            type: EarthquakeTelegramType.vxse62,
            reportedAt: DateTime.utc(2026, 7, 24, 1),
            text: 'old-1',
          ),
          _comment(
            type: EarthquakeTelegramType.vxse62,
            reportedAt: DateTime.utc(2026, 7, 24, 2),
            text: 'old-2',
          ),
          _comment(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: DateTime.utc(2026, 7, 24, 1),
            text: 'outside',
          ),
        ],
      );
      final draft = factory.create(
        current: draftSource,
        type: EarthquakeTelegramType.vxse62,
      );

      final result = reducer.apply(
        current: current,
        draft: draft,
        mode: EarthquakeVxseApplyMode.clearAndApply,
      );

      expect(
        result.telegramComments.where(
          (comment) => comment.type == EarthquakeTelegramType.vxse62,
        ),
        draft.comments,
      );
      expect(
        result.telegramComments.where(
          (comment) => comment.type == EarthquakeTelegramType.vxse51,
        ),
        [
          _comment(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: DateTime.utc(2026, 7, 24, 1),
            text: 'outside',
          ),
        ],
      );
    });

    test('VXSE51適用は非ownedのcity/stationとLPGMを保持する', () {
      final current = _current();
      final result = reducer.apply(
        current: current,
        draft: factory.create(
          current: draftSource,
          type: EarthquakeTelegramType.vxse51,
        ),
        mode: EarthquakeVxseApplyMode.clearAndApply,
      );

      final city =
          result.intensity?.intensityTree.values.single.single.cities.single;
      expect(
        city,
        current.intensity?.intensityTree.values.single.single.cities.single,
      );
      expect(
        result.intensity?.maxLpgmIntensity,
        current.intensity?.maxLpgmIntensity,
      );
      expect(
        result.intensity?.lpgmIntensityTree,
        current.intensity?.lpgmIntensityTree,
      );
    });

    test('VXSE62適用は非ownedの通常・LPGM city fieldsを保持する', () {
      final current = _current();
      final result = reducer.apply(
        current: current,
        draft: factory.create(
          current: draftSource,
          type: EarthquakeTelegramType.vxse62,
        ),
        mode: EarthquakeVxseApplyMode.clearAndApply,
      );

      final currentIntensity = current.intensity;
      final resultIntensity = result.intensity;
      expect(
        resultIntensity
            ?.intensityTree
            .values
            .single
            .single
            .cities
            .single
            .maxIntensity,
        currentIntensity
            ?.intensityTree
            .values
            .single
            .single
            .cities
            .single
            .maxIntensity,
      );
      expect(
        resultIntensity
            ?.lpgmIntensityTree
            .values
            .single
            .single
            .cities
            .single
            .maxLpgmIntensity,
        currentIntensity
            ?.lpgmIntensityTree
            .values
            .single
            .single
            .cities
            .single
            .maxLpgmIntensity,
      );
    });
  });
}

void _expectOwnedFieldsApplied({
  required Earthquake result,
  required Earthquake current,
  required EarthquakeTelegramType type,
}) {
  switch (type) {
    case .vxse51:
      expect(result.intensity?.maxIntensity, JmaIntensity.four);
      expect(result.intensity?.regions, _draftIntensity.regions);
      expect(
        result.intensity?.intensityTree.values.single.single.prefecture,
        _draftIntensity.intensityTree.values.single.single.prefecture,
      );
      expect(result.hypocenter, current.hypocenter);
      expect(result.originTime, current.originTime);
      expect(result.earthquakeType, current.earthquakeType);
    case .vxse52 || .vxse61:
      expect(result.hypocenter, earthquakeVxseDebugSampleHypocenter);
      expect(result.originTime, earthquakeVxseDebugSampleOriginTime);
      expect(result.arrivalTime, earthquakeVxseDebugSampleArrivalTime);
      expect(result.intensity, current.intensity);
      expect(result.earthquakeType, current.earthquakeType);
    case .vxse53:
      expect(result.hypocenter, earthquakeVxseDebugSampleHypocenter);
      expect(result.originTime, earthquakeVxseDebugSampleOriginTime);
      expect(result.arrivalTime, earthquakeVxseDebugSampleArrivalTime);
      expect(result.intensity?.maxIntensity, JmaIntensity.four);
      expect(result.intensity?.regions, _draftIntensity.regions);
      expect(result.intensity?.intensityTree, _draftIntensity.intensityTree);
      expect(
        result.intensity?.maxLpgmIntensity,
        current.intensity?.maxLpgmIntensity,
      );
      expect(
        result.intensity?.lpgmIntensityTree,
        current.intensity?.lpgmIntensityTree,
      );
      expect(result.earthquakeType, EarthquakeType.distant);
    case .vxse62:
      expect(result.hypocenter, earthquakeVxseDebugSampleHypocenter);
      expect(result.originTime, earthquakeVxseDebugSampleOriginTime);
      expect(result.arrivalTime, earthquakeVxseDebugSampleArrivalTime);
      expect(result.intensity?.maxIntensity, JmaIntensity.four);
      expect(result.intensity?.regions, _draftIntensity.regions);
      expect(
        result.intensity?.intensityTree.values.single.single.prefecture,
        _draftIntensity.intensityTree.values.single.single.prefecture,
      );
      expect(
        result
            .intensity
            ?.intensityTree
            .values
            .single
            .single
            .cities
            .single
            .stations,
        _draftIntensity
            .intensityTree
            .values
            .single
            .single
            .cities
            .single
            .stations,
      );
      expect(result.earthquakeType, current.earthquakeType);
      expect(result.intensity?.maxLpgmIntensity, JmaLpgmIntensity.two);
      expect(
        result
            .intensity
            ?.lpgmIntensityTree
            .values
            .single
            .single
            .maxLpgmIntensity,
        JmaLpgmIntensity.two,
      );
      expect(
        result
            .intensity
            ?.lpgmIntensityTree
            .values
            .single
            .single
            .cities
            .single
            .stations,
        _draftIntensity
            .lpgmIntensityTree
            .values
            .single
            .single
            .cities
            .single
            .stations,
      );
    case .vxse45Forecast || .vxse45Warning:
      throw ArgumentError.value(type, 'type', 'VXSE51/52/53/61/62 only');
  }
}

EarthquakeTelegramComment _comment({
  required EarthquakeTelegramType type,
  required DateTime reportedAt,
  required String text,
}) => EarthquakeTelegramComment(
  type: type,
  reportedAt: reportedAt,
  additional: text,
  free: null,
);

const _supportedTypes = [
  EarthquakeTelegramType.vxse51,
  EarthquakeTelegramType.vxse52,
  EarthquakeTelegramType.vxse53,
  EarthquakeTelegramType.vxse61,
  EarthquakeTelegramType.vxse62,
];

const _baseIntensity = EarthquakeIntensity(
  maxIntensity: JmaIntensity.fiveLower,
  maxLpgmIntensity: JmaLpgmIntensity.three,
  regions: {
    JmaIntensity.fiveLower: [
      IntensityRegion(
        region: earthquakeVxseDebugSampleRegion,
        maxIntensity: JmaIntensity.fiveLower,
      ),
    ],
  },
  intensityTree: {
    JmaIntensity.fiveLower: [
      PrefectureIntensityNode(
        prefecture: IntensityPrefecture(
          prefecture: earthquakeVxseDebugSamplePrefecture,
          maxIntensity: JmaIntensity.fiveLower,
        ),
        cities: [
          CityIntensityNode(
            city: earthquakeVxseDebugSampleCity,
            maxIntensity: JmaIntensity.fiveLower,
            stations: [
              StationIntensityNode(
                station: earthquakeVxseDebugSampleStation,
                intensity: earthquakeVxseDebugSampleStationIntensity,
              ),
            ],
            maxLpgmIntensity: JmaLpgmIntensity.three,
          ),
        ],
      ),
    ],
  },
  lpgmIntensityTree: {
    JmaLpgmIntensity.three: [
      PrefectureLpgmIntensityNode(
        region: earthquakeVxseDebugSampleRegion,
        maxLpgmIntensity: JmaLpgmIntensity.three,
        cities: [
          CityLpgmIntensityNode(
            city: earthquakeVxseDebugSampleCity,
            maxLpgmIntensity: JmaLpgmIntensity.three,
            stations: [
              StationLpgmIntensityNode(
                station: earthquakeVxseDebugSampleStation,
                intensity: earthquakeVxseDebugSampleStationIntensity,
              ),
            ],
          ),
        ],
      ),
    ],
  },
);

const _draftIntensity = EarthquakeIntensity(
  maxIntensity: JmaIntensity.four,
  maxLpgmIntensity: JmaLpgmIntensity.two,
  regions: {
    JmaIntensity.four: [earthquakeVxseDebugSampleIntensityRegion],
  },
  intensityTree: {
    JmaIntensity.four: [
      PrefectureIntensityNode(
        prefecture: earthquakeVxseDebugSampleIntensityPrefecture,
        cities: [
          CityIntensityNode(
            city: earthquakeVxseDebugSampleCity,
            maxIntensity: JmaIntensity.four,
            stations: [
              StationIntensityNode(
                station: earthquakeVxseDebugSampleStation,
                intensity: earthquakeVxseDebugSampleStationIntensity,
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
        region: earthquakeVxseDebugSampleRegion,
        maxLpgmIntensity: JmaLpgmIntensity.two,
        cities: [
          CityLpgmIntensityNode(
            city: earthquakeVxseDebugSampleCity,
            maxLpgmIntensity: JmaLpgmIntensity.two,
            stations: [
              StationLpgmIntensityNode(
                station: earthquakeVxseDebugSampleStation,
                intensity: earthquakeVxseDebugSampleStationIntensity,
              ),
            ],
          ),
        ],
      ),
    ],
  },
);

Earthquake _current() => Earthquake(
  eventId: 'event-id',
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026, 7, 24, 1),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: DateTime.utc(2026, 7, 24, 1, 1),
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  telegramTypes: const [EarthquakeTelegramType.vxse51],
  hypocenter: earthquakeVxseDebugSampleHypocenter.copyWith(name: 'current'),
  intensity: _baseIntensity,
  earthquakeType: EarthquakeType.volcano,
  estimatedIntensityTileUrl: 'https://example.com/current.pmtiles',
);

Earthquake _draftSource() => Earthquake(
  eventId: 'event-id',
  status: TelegramStatus.training,
  originTime: earthquakeVxseDebugSampleOriginTime,
  originTimePrecision: OriginTimePrecision.minute,
  arrivalTime: earthquakeVxseDebugSampleArrivalTime,
  dataSources: const [],
  telegramTypes: _supportedTypes,
  telegramComments: [
    for (final type in _supportedTypes)
      _comment(
        type: type,
        reportedAt: earthquakeVxseDebugSampleReportedAt,
        text: type.name,
      ),
  ],
  hypocenter: earthquakeVxseDebugSampleHypocenter,
  intensity: _draftIntensity,
  earthquakeType: EarthquakeType.distant,
  estimatedIntensityTileUrl: null,
);
