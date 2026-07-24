import 'dart:convert';

import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_vxse_debug_editor_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('現在表示中の地震から選択型とJSONを初期化する', () {
    final fixture = _fixture();

    expect(fixture.state.selectedType, EarthquakeTelegramType.vxse53);
    expect(fixture.state.applyMode, EarthquakeVxseApplyMode.merge);
    expect(fixture.state.draft.eventId, _eventId);
    expect(
      jsonDecode(fixture.state.jsonText),
      jsonDecode(jsonEncode(fixture.state.draft.toJson())),
    );
    expect(fixture.state.validationError, isNull);
    expect(fixture.state.canApply, isTrue);
  });

  test('型付きフォーム編集はdraftを更新してJSONを再生成する', () {
    final fixture = _fixture();
    final edited = fixture.state.draft.copyWith(
      reportedAt: DateTime.utc(2026, 7, 24, 2),
    );

    fixture.notifier.updateDraft(edited);

    expect(fixture.state.draft.reportedAt, DateTime.utc(2026, 7, 24, 2));
    expect(
      jsonDecode(fixture.state.jsonText),
      jsonDecode(jsonEncode(edited.toJson())),
    );
    expect(fixture.state.canApply, isTrue);
  });

  test('正しい手動JSONはdraftへ反映する', () {
    final fixture = _fixture();
    final json = jsonEncode(
      fixture.state.draft
          .copyWith(reportedAt: DateTime.utc(2026, 7, 24, 3))
          .toJson(),
    );

    fixture.notifier.validateJson(json);

    expect(fixture.state.jsonText, json);
    expect(fixture.state.draft.reportedAt, DateTime.utc(2026, 7, 24, 3));
    expect(fixture.state.validationError, isNull);
    expect(fixture.state.canApply, isTrue);
  });

  test('不正JSONはraw textを保持して適用を無効にする', () {
    final fixture = _fixture();

    fixture.notifier.validateJson('{broken');

    expect(fixture.state.jsonText, '{broken');
    expect(fixture.state.validationError, 'JSONの形式が正しくありません');
    expect(fixture.state.canApply, isFalse);
  });

  test('選択型またはeventIdと異なるJSONは適用を無効にする', () {
    final fixture = _fixture();
    final vxse51Json = jsonEncode(
      EarthquakeVxseDebugDraft.vxse51(
        eventId: _eventId,
        reportedAt: DateTime.utc(2026, 7, 24),
        status: TelegramStatus.normal,
        maxIntensity: earthquakeVxseDebugSampleMaxIntensity,
        regions: const {},
        prefectures: const {},
        comments: const [],
      ).toJson(),
    );

    fixture.notifier.validateJson(vxse51Json);
    expect(fixture.state.jsonText, vxse51Json);
    expect(fixture.state.validationError, '選択中の電文種類と一致しません');
    expect(fixture.state.canApply, isFalse);

    final otherEventJson = jsonEncode(
      fixture.state.draft.copyWith(eventId: 'other-event').toJson(),
    );
    fixture.notifier.validateJson(otherEventJson);
    expect(fixture.state.jsonText, otherEventJson);
    expect(fixture.state.validationError, '現在の地震とevent IDが一致しません');
    expect(fixture.state.canApply, isFalse);
  });

  test('型切替は現在表示中の地震からdraftを再構築する', () {
    final fixture = _fixture();
    fixture.notifier.updateDraft(
      fixture.state.draft.copyWith(eventId: 'edited-event'),
    );

    fixture.notifier.selectType(EarthquakeTelegramType.vxse52);

    expect(fixture.state.selectedType, EarthquakeTelegramType.vxse52);
    expect(fixture.state.draft, isA<EarthquakeVxse52DebugDraft>());
    expect(fixture.state.draft.eventId, _eventId);
    expect(fixture.state.canApply, isTrue);
  });

  test('同じeventIdのcurrent更新は編集中stateを保持し型切替だけ最新currentを使う', () {
    final container = ProviderContainer.test();
    final first = _currentEarthquake();
    final refreshed = first.copyWith(
      status: TelegramStatus.training,
      telegramTypes: const [EarthquakeTelegramType.vxse52],
    );
    final session = EarthquakeVxseDebugEditorSession(current: first);
    final provider = earthquakeVxseDebugEditorControllerProvider(session);
    final notifier = container.read(provider.notifier);

    notifier.setApplyMode(EarthquakeVxseApplyMode.clearAndApply);
    notifier.validateJson('{editing');
    notifier.updateCurrent(refreshed);

    expect(
      container.read(provider).selectedType,
      EarthquakeTelegramType.vxse53,
    );
    expect(
      container.read(provider).applyMode,
      EarthquakeVxseApplyMode.clearAndApply,
    );
    expect(container.read(provider).jsonText, '{editing');
    expect(container.read(provider).canApply, isFalse);

    notifier.selectType(EarthquakeTelegramType.vxse52);

    expect(
      container.read(provider).selectedType,
      EarthquakeTelegramType.vxse52,
    );
    expect(container.read(provider).draft.status, TelegramStatus.training);
  });

  test('eventIdが異なるeditor sessionは分離する', () {
    final container = ProviderContainer.test();
    final first = _currentEarthquake();
    final second = first.copyWith(eventId: 'other-event');
    final firstProvider = earthquakeVxseDebugEditorControllerProvider(
      EarthquakeVxseDebugEditorSession(current: first),
    );
    final secondProvider = earthquakeVxseDebugEditorControllerProvider(
      EarthquakeVxseDebugEditorSession(current: second),
    );

    container.read(firstProvider.notifier).validateJson('{editing');

    expect(container.read(firstProvider).jsonText, '{editing');
    expect(container.read(secondProvider).draft.eventId, 'other-event');
    expect(container.read(secondProvider).canApply, isTrue);
  });

  test('typed input errorはraw textを保持しApplyを無効にする', () {
    final fixture = _fixture();
    final before = fixture.state.draft.reportedAt;

    fixture.notifier.setTypedInput(
      fieldId: 'reportedAt',
      text: 'invalid-time',
      error: '日時を入力してください',
    );

    expect(fixture.state.typedInputValues['reportedAt'], 'invalid-time');
    expect(fixture.state.typedInputErrors['reportedAt'], '日時を入力してください');
    expect(fixture.state.draft.reportedAt, before);
    expect(fixture.state.canApply, isFalse);

    fixture.notifier.setTypedInput(
      fieldId: 'reportedAt',
      text: '2026-07-24T05:00:00.000Z',
    );
    fixture.notifier.setReportedAt(DateTime.utc(2026, 7, 24, 5));

    expect(fixture.state.typedInputValues['reportedAt'], contains('05:00'));
    expect(fixture.state.typedInputErrors, isEmpty);
    expect(fixture.state.canApply, isTrue);
  });

  test('ordinary grouped level変更はnodeと外Map keyをatomicに移す', () {
    final source = {
      JmaIntensity.four: [earthquakeVxseDebugSampleIntensityRegion],
      JmaIntensity.fiveLower: [
        earthquakeVxseDebugSampleIntensityRegion.copyWith(
          region: earthquakeVxseDebugSampleIntensityRegion.region.copyWith(
            code: '351',
          ),
          maxIntensity: JmaIntensity.fiveLower,
        ),
      ],
    };

    final moved = moveIntensityRegionLevel(
      source: source,
      from: JmaIntensity.four,
      index: 0,
      to: JmaIntensity.fiveLower,
    );

    expect(moved.containsKey(JmaIntensity.four), isFalse);
    expect(moved[JmaIntensity.fiveLower], hasLength(2));
    expect(
      moved[JmaIntensity.fiveLower]!.last.maxIntensity,
      JmaIntensity.fiveLower,
    );
    expect(moved[JmaIntensity.fiveLower]!.first.region.code, '351');
  });

  test('LPGM grouped level変更はnodeと外Map keyをatomicに移す', () {
    final source = {
      JmaLpgmIntensity.two: [earthquakeVxseDebugSampleLpgmRegion],
      JmaLpgmIntensity.three: [
        earthquakeVxseDebugSampleLpgmRegion.copyWith(
          region: earthquakeVxseDebugSampleLpgmRegion.region.copyWith(
            code: '351',
          ),
          maxLpgmIntensity: JmaLpgmIntensity.three,
        ),
      ],
    };

    final moved = moveLpgmRegionLevel(
      source: source,
      from: JmaLpgmIntensity.two,
      index: 0,
      to: JmaLpgmIntensity.three,
    );

    expect(moved.containsKey(JmaLpgmIntensity.two), isFalse);
    expect(moved[JmaLpgmIntensity.three], hasLength(2));
    expect(
      moved[JmaLpgmIntensity.three]!.last.maxLpgmIntensity,
      JmaLpgmIntensity.three,
    );
  });

  test('prefecture grouped level変更もordinary/LPGMの外Map keyを移す', () {
    final ordinary = moveIntensityPrefectureLevel(
      source: {
        JmaIntensity.four: [earthquakeVxseDebugSampleIntensityPrefecture],
      },
      from: JmaIntensity.four,
      index: 0,
      to: JmaIntensity.fiveLower,
    );
    final lpgm = moveLpgmPrefectureLevel(
      source: {
        JmaLpgmIntensity.two: [lpgmTreeOrSample(tree: null).values.first.first],
      },
      from: JmaLpgmIntensity.two,
      index: 0,
      to: JmaLpgmIntensity.three,
    );
    final ordinaryTree = moveIntensityTreePrefectureLevel(
      source: {
        JmaIntensity.four: [
          intensityTreeOrSample(tree: null).values.first.first,
        ],
      },
      from: JmaIntensity.four,
      index: 0,
      to: JmaIntensity.fiveLower,
    );

    expect(ordinary.containsKey(JmaIntensity.four), isFalse);
    expect(
      ordinary[JmaIntensity.fiveLower]!.single.maxIntensity,
      JmaIntensity.fiveLower,
    );
    expect(lpgm.containsKey(JmaLpgmIntensity.two), isFalse);
    expect(
      lpgm[JmaLpgmIntensity.three]!.single.maxLpgmIntensity,
      JmaLpgmIntensity.three,
    );
    expect(ordinaryTree.containsKey(JmaIntensity.four), isFalse);
    expect(
      ordinaryTree[JmaIntensity.fiveLower]!.single.prefecture.maxIntensity,
      JmaIntensity.fiveLower,
    );
  });

  test('group移動先の同一codeは暗黙上書きせず保持してApplyを無効にする', () {
    final fixture = _fixture();
    final draft = fixture.state.draft as EarthquakeVxse53DebugDraft;
    final duplicate = earthquakeVxseDebugSampleIntensityRegion.copyWith(
      maxIntensity: JmaIntensity.fiveLower,
    );
    final moved = moveIntensityRegionLevel(
      source: {
        JmaIntensity.four: [earthquakeVxseDebugSampleIntensityRegion],
        JmaIntensity.fiveLower: [duplicate],
      },
      from: JmaIntensity.four,
      index: 0,
      to: JmaIntensity.fiveLower,
    );

    fixture.notifier.updateDraft(draft.copyWith(regions: moved));

    expect(moved[JmaIntensity.fiveLower], hasLength(2));
    expect(fixture.state.validationError, '同じコードの階級項目が重複しています');
    expect(fixture.state.canApply, isFalse);
  });

  test('group keyとnode scalarが不一致ならApplyを無効にする', () {
    final fixture = _fixture();
    final draft = fixture.state.draft as EarthquakeVxse53DebugDraft;
    fixture.notifier.updateDraft(
      draft.copyWith(
        regions: {
          JmaIntensity.four: [
            earthquakeVxseDebugSampleIntensityRegion.copyWith(
              maxIntensity: JmaIntensity.fiveLower,
            ),
          ],
        },
      ),
    );

    expect(fixture.state.validationError, '階級グループと項目の階級が一致しません');
    expect(fixture.state.canApply, isFalse);
  });

  test('VXSE62のstation親city locatorは両treeへ同期し階級値を変えない', () {
    final fixture = _fixture();
    fixture.notifier.selectType(EarthquakeTelegramType.vxse62);
    final before = fixture.state.draft as EarthquakeVxse62DebugDraft;
    final ordinaryCity = before.intensityTree.values.first.first.cities.first;
    final lpgmCity = before.lpgmIntensityTree.values.first.first.cities.first;

    fixture.notifier.setVxse62StationParentCity(
      currentCode: ordinaryCity.city.code,
      code: '999001',
      name: '親市区町村',
    );

    final after = fixture.state.draft as EarthquakeVxse62DebugDraft;
    final updatedOrdinary = after.intensityTree.values.first.first.cities.first;
    final updatedLpgm = after.lpgmIntensityTree.values.first.first.cities.first;
    expect(updatedOrdinary.city.code, '999001');
    expect(updatedLpgm.city.code, '999001');
    expect(updatedOrdinary.city.name.ja, '親市区町村');
    expect(updatedLpgm.city.name.ja, '親市区町村');
    expect(updatedOrdinary.maxIntensity, ordinaryCity.maxIntensity);
    expect(updatedOrdinary.maxLpgmIntensity, ordinaryCity.maxLpgmIntensity);
    expect(updatedLpgm.maxLpgmIntensity, lpgmCity.maxLpgmIntensity);
    expect(fixture.state.canApply, isTrue);
  });

  test('comment・city・stationのduplicate identityはApplyを無効にする', () {
    final commentFixture = _fixture();
    final commentDraft =
        commentFixture.state.draft as EarthquakeVxse53DebugDraft;
    final comment = EarthquakeTelegramComment(
      type: EarthquakeTelegramType.vxse53,
      reportedAt: DateTime.utc(2026, 7, 24, 6),
      additional: 'first',
      free: 'first',
    );
    commentFixture.notifier.updateDraft(
      commentDraft.copyWith(
        comments: [
          comment,
          comment.copyWith(free: 'second'),
        ],
      ),
    );
    expect(commentFixture.state.canApply, isFalse);

    final cityFixture = _fixture();
    final cityDraft = cityFixture.state.draft as EarthquakeVxse53DebugDraft;
    final prefecture = cityDraft.intensityTree.values.single.single;
    final city = prefecture.cities.single;
    cityFixture.notifier.updateDraft(
      cityDraft.copyWith(
        intensityTree: {
          cityDraft.intensityTree.keys.single: [
            prefecture.copyWith(cities: [city, city]),
          ],
        },
      ),
    );
    expect(cityFixture.state.canApply, isFalse);

    final stationFixture = _fixture();
    stationFixture.notifier.selectType(EarthquakeTelegramType.vxse62);
    final stationDraft =
        stationFixture.state.draft as EarthquakeVxse62DebugDraft;
    final stationPrefecture = stationDraft.intensityTree.values.single.single;
    final stationCity = stationPrefecture.cities.single;
    final station = stationCity.stations.single;
    stationFixture.notifier.updateDraft(
      stationDraft.copyWith(
        intensityTree: {
          stationDraft.intensityTree.keys.single: [
            stationPrefecture.copyWith(
              cities: [
                stationCity.copyWith(stations: [station, station]),
              ],
            ),
          ],
        },
      ),
    );
    expect(stationFixture.state.canApply, isFalse);
  });

  test('debug identity generatorは既存値を飛ばして決定的な次値を返す', () {
    final firstCode = nextEarthquakeVxseDebugCode(
      prefix: 'debug-station',
      usedCodes: const {'debug-station-1'},
    );
    final secondCode = nextEarthquakeVxseDebugCode(
      prefix: 'debug-station',
      usedCodes: {'debug-station-1', firstCode},
    );
    final firstTime = nextEarthquakeVxseDebugCommentTime(
      base: DateTime.utc(2026, 7, 24),
      usedTimes: {DateTime.utc(2026, 7, 24)},
    );
    final secondTime = nextEarthquakeVxseDebugCommentTime(
      base: DateTime.utc(2026, 7, 24),
      usedTimes: {DateTime.utc(2026, 7, 24), firstTime},
    );
    final firstBand = nextEarthquakeVxseDebugPrePeriodBand(
      usedBands: {1.6},
    );
    final secondBand = nextEarthquakeVxseDebugPrePeriodBand(
      usedBands: {1.6, firstBand},
    );

    expect((firstCode, secondCode), ('debug-station-2', 'debug-station-3'));
    expect(firstTime, DateTime.utc(2026, 7, 24, 0, 0, 1));
    expect(secondTime, DateTime.utc(2026, 7, 24, 0, 0, 2));
    expect((firstBand, secondBand), (1.7, 1.8));
  });
}

_Fixture _fixture() {
  final current = _currentEarthquake();
  final container = ProviderContainer.test();
  return _Fixture(container: container, current: current);
}

class _Fixture {
  const _Fixture({required this.container, required this.current});

  final ProviderContainer container;
  final Earthquake current;

  EarthquakeVxseDebugEditorController get notifier => container.read(
    earthquakeVxseDebugEditorControllerProvider(
      EarthquakeVxseDebugEditorSession(current: current),
    ).notifier,
  );

  EarthquakeVxseDebugEditorState get state => container.read(
    earthquakeVxseDebugEditorControllerProvider(
      EarthquakeVxseDebugEditorSession(current: current),
    ),
  );
}

const _eventId = '20260724010101';

Earthquake _currentEarthquake() => Earthquake(
  eventId: _eventId,
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026, 7, 24, 1),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: DateTime.utc(2026, 7, 24, 1, 1),
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  telegramTypes: const [
    EarthquakeTelegramType.vxse51,
    EarthquakeTelegramType.vxse53,
  ],
  hypocenter: earthquakeVxseDebugSampleHypocenter,
  intensity: null,
  earthquakeType: null,
  estimatedIntensityTileUrl: null,
);
