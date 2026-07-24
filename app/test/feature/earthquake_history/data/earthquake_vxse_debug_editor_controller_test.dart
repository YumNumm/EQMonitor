import 'dart:convert';

import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
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

  test('同じeventIdの新しいcurrentは別family keyとして再初期化する', () {
    final container = ProviderContainer.test();
    final first = _currentEarthquake();
    final refreshed = first.copyWith(
      status: TelegramStatus.training,
      telegramTypes: const [EarthquakeTelegramType.vxse52],
    );

    final firstState = container.read(
      earthquakeVxseDebugEditorControllerProvider(first),
    );
    final refreshedState = container.read(
      earthquakeVxseDebugEditorControllerProvider(refreshed),
    );

    expect(firstState.selectedType, EarthquakeTelegramType.vxse53);
    expect(refreshedState.selectedType, EarthquakeTelegramType.vxse52);
    expect(refreshedState.draft.status, TelegramStatus.training);
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
    earthquakeVxseDebugEditorControllerProvider(current).notifier,
  );

  EarthquakeVxseDebugEditorState get state =>
      container.read(earthquakeVxseDebugEditorControllerProvider(current));
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
