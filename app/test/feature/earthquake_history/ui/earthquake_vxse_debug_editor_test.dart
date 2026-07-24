import 'dart:convert';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_metadata.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_vxse_debug_editor_controller.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_vxse_debug_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('manual JSON更新はfocusに依存せず可視typed formへ同期する', (tester) async {
    await _pumpEditor(tester);
    final draft = const EarthquakeVxseDebugDraftFactory().create(
      current: _currentEarthquake(),
      type: EarthquakeTelegramType.vxse53,
    );
    final json = jsonEncode(
      draft.copyWith(reportedAt: DateTime.utc(2026, 7, 24, 8)).toJson(),
    );

    await _scrollTo(tester, const Key('vxse-json-field'));
    await tester.enterText(find.byKey(const Key('vxse-json-field')), json);
    await tester.pump();
    await _scrollToTop(tester);

    expect(
      tester
          .widget<TextFormField>(find.byKey(const Key('reported-at-field')))
          .controller
          ?.text,
      '2026-07-24T08:00:00.000Z',
    );
  });

  testWidgets('invalid typed datetimeはrawを保持してApplyを無効にする', (tester) async {
    await _pumpEditor(tester);

    await tester.enterText(
      find.byKey(const Key('reported-at-field')),
      'not-a-date',
    );
    await tester.pump();

    expect(find.text('not-a-date'), findsOneWidget);
    expect(find.text('日時を入力してください'), findsOneWidget);
    await _scrollTo(tester, const Key('vxse-apply-button'));
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('vxse-apply-button')))
          .onPressed,
      isNull,
    );
  });

  testWidgets('同一event rebuildは編集中rawを保ちtype切替は最新currentを使う', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await _pumpEditorWithContainer(
      tester,
      container: container,
      current: _currentEarthquake(),
    );
    await tester.enterText(
      find.byKey(const Key('reported-at-field')),
      'invalid-in-progress',
    );
    await _scrollFinderTo(
      tester,
      find.byKey(const Key('hypocenter-detailed-code')),
    );
    await tester.enterText(
      find.byKey(const Key('hypocenter-detailed-code')),
      'edited-detail',
    );
    await tester.pump();

    final refreshed = _currentEarthquake().copyWith(
      status: TelegramStatus.training,
      telegramMetadata: [
        EarthquakeTelegramMetadata(
          type: EarthquakeTelegramType.vxse52,
          reportedAt: DateTime.utc(2026, 7, 24, 12),
        ),
      ],
      telegramComments: [
        EarthquakeTelegramComment(
          type: EarthquakeTelegramType.vxse52,
          reportedAt: DateTime.utc(2026, 7, 24, 12),
          additional: 'latest-vxse52-comment',
          free: 'latest-vxse52-free',
        ),
      ],
    );
    await _pumpEditorWithContainer(
      tester,
      container: container,
      current: refreshed,
    );
    await _scrollToTop(tester);
    expect(find.text('invalid-in-progress'), findsOneWidget);
    await _scrollFinderTo(
      tester,
      find.byKey(const Key('hypocenter-detailed-code')),
    );
    expect(find.text('edited-detail'), findsOneWidget);

    await _selectType(tester, EarthquakeTelegramType.vxse52);
    expect(
      tester
          .widget<TextFormField>(find.byKey(const Key('reported-at-field')))
          .controller
          ?.text,
      '2026-07-24T12:00:00.000Z',
    );
    final draft = await _readDraft(tester) as EarthquakeVxse52DebugDraft;
    expect(draft.status, TelegramStatus.training);
    expect(draft.comments.single.additional, 'latest-vxse52-comment');
  });

  testWidgets('5型のowned control matrixを表示する', (tester) async {
    await _pumpEditor(
      tester,
      current: _currentEarthquake().copyWith(
        telegramTypes: const [
          EarthquakeTelegramType.vxse51,
          EarthquakeTelegramType.vxse52,
          EarthquakeTelegramType.vxse53,
          EarthquakeTelegramType.vxse61,
          EarthquakeTelegramType.vxse62,
        ],
        telegramMetadata: [
          for (final (index, type) in const [
            EarthquakeTelegramType.vxse51,
            EarthquakeTelegramType.vxse52,
            EarthquakeTelegramType.vxse53,
            EarthquakeTelegramType.vxse61,
            EarthquakeTelegramType.vxse62,
          ].indexed)
            EarthquakeTelegramMetadata(
              type: type,
              reportedAt: DateTime.utc(2026, 7, 24, index),
            ),
        ],
        telegramComments: [
          for (final type in const [
            EarthquakeTelegramType.vxse51,
            EarthquakeTelegramType.vxse52,
            EarthquakeTelegramType.vxse53,
            EarthquakeTelegramType.vxse61,
            EarthquakeTelegramType.vxse62,
          ])
            EarthquakeTelegramComment(
              type: type,
              reportedAt: DateTime.utc(2026, 7, 24),
              additional: '${type.name}-additional',
              free: '${type.name}-free',
            ),
        ],
      ),
    );

    for (final (typeIndex, type) in const [
      EarthquakeTelegramType.vxse51,
      EarthquakeTelegramType.vxse52,
      EarthquakeTelegramType.vxse53,
      EarthquakeTelegramType.vxse61,
      EarthquakeTelegramType.vxse62,
    ].indexed) {
      await _selectType(tester, type);
      await tester.enterText(
        find.byKey(const Key('reported-at-field')),
        '2026-07-24T${(10 + typeIndex).toString().padLeft(2, '0')}:00:00.000Z',
      );
      await tester.pump();
      if (type == EarthquakeTelegramType.vxse51) {
        final regionCode = find.byKey(const Key('ordinary-region-code'));
        await _scrollFinderTo(tester, regionCode);
        await tester.enterText(regionCode, 'edited-vxse51-region');
        await tester.pump();
      } else {
        await _scrollTo(tester, const Key('hypocenter-fields'));
        expect(
          find.byKey(const Key('hypocenter-detailed-code')),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('coordinate-type-dropdown')),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('magnitude-type-dropdown')),
          findsOneWidget,
        );
        expect(find.byKey(const Key('depth-type-dropdown')), findsOneWidget);
        await tester.enterText(
          find.byKey(const Key('hypocenter-detailed-code')),
          'edited-${type.name}-detail',
        );
        await tester.pump();
      }
      if (type == EarthquakeTelegramType.vxse62) {
        await _scrollTo(tester, const Key('lpgm-prefecture-row'));
        expect(find.byKey(const Key('lpgm-prefecture-max')), findsWidgets);
        await _scrollTo(tester, const Key('lpgm-station-row'));
        expect(find.byKey(const Key('station-sva')), findsWidgets);
        expect(find.byKey(const Key('pre-period-row')), findsWidgets);
        expect(find.byKey(const Key('pre-period-add')), findsWidgets);
      }
      await _scrollTo(tester, const Key('comments-fields'));
      final commentReportedAt = find.byKey(const Key('comment-reported-at'));
      expect(commentReportedAt, findsWidgets);
      await tester.enterText(
        commentReportedAt,
        '2026-07-24T${(15 + typeIndex).toString().padLeft(2, '0')}:00:00.000Z',
      );
      await tester.pump();

      final draft = await _readDraft(tester);
      expect(draft.reportedAt.hour, 10 + typeIndex);
      expect(draft.comments.single.reportedAt.hour, 15 + typeIndex);
      switch (draft) {
        case EarthquakeVxse51DebugDraft(:final regions):
          expect(
            regions.values.single.single.region.code,
            'edited-vxse51-region',
          );
        case EarthquakeVxse52DebugDraft(:final hypocenter) ||
            EarthquakeVxse53DebugDraft(:final hypocenter) ||
            EarthquakeVxse61DebugDraft(:final hypocenter) ||
            EarthquakeVxse62DebugDraft(:final hypocenter):
          expect(hypocenter.detailedCode, 'edited-${type.name}-detail');
      }
    }
  });

  testWidgets('VXSE62 owned fieldsを実入力しJSONへlossless反映する', (tester) async {
    final current = _currentEarthquake().copyWith(
      telegramTypes: const [EarthquakeTelegramType.vxse62],
      telegramComments: [
        EarthquakeTelegramComment(
          type: EarthquakeTelegramType.vxse62,
          reportedAt: DateTime.utc(2026, 7, 24),
          additional: 'before',
          free: 'before-free',
        ),
      ],
    );
    await _pumpEditor(tester, current: current);

    await _scrollTo(tester, const Key('hypocenter-detailed-code'));
    await tester.enterText(
      find.byKey(const Key('hypocenter-detailed-code')),
      'detail-999',
    );
    await tester.tap(find.byKey(const Key('magnitude-type-dropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('unknown').last);
    await tester.pumpAndSettle();

    final ordinaryDetails = find.byKey(const Key('ordinary-station-details'));
    final ordinarySva = find.descendant(
      of: ordinaryDetails,
      matching: find.byKey(const Key('station-sva')),
    );
    await _scrollFinderTo(tester, ordinarySva);
    await tester.enterText(ordinarySva, '91.2');
    await tester.pump();
    final ordinaryPrePeriodAdd = find.descendant(
      of: ordinaryDetails,
      matching: find.byKey(const Key('pre-period-add')),
    );
    await _scrollFinderTo(tester, ordinaryPrePeriodAdd);
    await tester.tap(ordinaryPrePeriodAdd.hitTestable());
    await tester.pump();
    final ordinaryPrePeriodBands = find.descendant(
      of: ordinaryDetails,
      matching: find.byKey(const Key('pre-period-band')),
    );
    await _scrollFinderTo(tester, ordinaryPrePeriodBands);
    await tester.enterText(ordinaryPrePeriodBands.last, '2.4');
    await tester.pump();

    await _scrollTo(tester, const Key('comment-reported-at'));
    await tester.enterText(
      find.byKey(const Key('comment-reported-at')),
      '2026-07-24T09:00:00.000Z',
    );
    await tester.pump();
    await _scrollTo(tester, const Key('vxse-json-field'));
    final json = tester
        .widget<TextField>(find.byKey(const Key('vxse-json-field')))
        .controller
        ?.text;
    final decoded = json == null ? null : jsonDecode(json);
    final draft =
        EarthquakeVxseDebugDraft.fromJson(decoded as Map<String, dynamic>)
            as EarthquakeVxse62DebugDraft;

    expect(draft.hypocenter.detailedCode, 'detail-999');
    expect(
      draft.hypocenter.magnitude.runtimeType.toString(),
      contains('Unknown'),
    );
    final ordinaryStation = draft
        .intensityTree
        .values
        .first
        .first
        .cities
        .first
        .stations
        .first
        .intensity;
    expect(ordinaryStation?.sva, 91.2);
    expect(ordinaryStation?.prePeriods, hasLength(2));
    expect(ordinaryStation?.prePeriods?.last.band, 2.4);
    expect(draft.comments.single.reportedAt, DateTime.utc(2026, 7, 24, 9));

    await _scrollToTop(tester);
    final ordinaryPrePeriodRemoves = find.descendant(
      of: ordinaryDetails,
      matching: find.byKey(const Key('pre-period-remove')),
    );
    await _scrollFinderTo(tester, ordinaryPrePeriodRemoves);
    await tester.tap(ordinaryPrePeriodRemoves.hitTestable().first);
    await tester.pump();
    final afterRemove = await _readDraft(tester) as EarthquakeVxse62DebugDraft;
    expect(
      afterRemove
          .intensityTree
          .values
          .first
          .first
          .cities
          .first
          .stations
          .first
          .intensity
          ?.prePeriods,
      hasLength(1),
    );
  });

  testWidgets('先頭rowを実ボタンで削除すると後続rowの表示identityを維持する', (tester) async {
    await _pumpEditor(tester);
    final initial =
        const EarthquakeVxseDebugDraftFactory().create(
              current: _currentEarthquake(),
              type: EarthquakeTelegramType.vxse53,
            )
            as EarthquakeVxse53DebugDraft;
    final first = earthquakeVxseDebugSampleIntensityRegion.copyWith(
      region: earthquakeVxseDebugSampleIntensityRegion.region.copyWith(
        code: 'first-code',
      ),
    );
    final second = earthquakeVxseDebugSampleIntensityRegion.copyWith(
      region: earthquakeVxseDebugSampleIntensityRegion.region.copyWith(
        code: 'second-code',
      ),
    );
    final json = jsonEncode(
      initial
          .copyWith(
            regions: {
              initial.maxIntensity: [first, second],
            },
          )
          .toJson(),
    );
    await _scrollTo(tester, const Key('vxse-json-field'));
    await tester.enterText(find.byKey(const Key('vxse-json-field')), json);
    await tester.pump();
    await _scrollToTop(tester);
    final regionCodes = find.byKey(const Key('ordinary-region-code'));
    await _scrollFinderTo(tester, regionCodes);
    await tester.enterText(regionCodes.first, 'first-edited');
    await tester.pump();
    await _scrollFinderTo(tester, regionCodes);
    await tester.enterText(regionCodes.last, 'second-edited');
    await tester.pump();
    final removes = find.byKey(const Key('ordinary-region-remove'));
    await _scrollFinderTo(tester, removes);
    await tester.tap(removes.first);
    await tester.pump();

    final remaining = tester
        .widget<TextFormField>(find.byKey(const Key('ordinary-region-code')))
        .controller
        ?.text;
    expect(remaining, 'second-edited');
  });

  for (final surface in _CollectionSurface.values) {
    testWidgets('${surface.name}は先頭削除後も後続rowのdraft/raw/error identityを保持する', (
      tester,
    ) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final current = _currentEarthquake().copyWith(
        telegramTypes: [surface.type],
      );
      final draft = _twoRowDraft(surface: surface, current: current);
      await _pumpEditorWithContainer(
        tester,
        container: container,
        current: current,
      );
      await _scrollTo(tester, const Key('vxse-json-field'));
      await tester.enterText(
        find.byKey(const Key('vxse-json-field')),
        jsonEncode(draft.toJson()),
      );
      await tester.pump();
      await _scrollToTop(tester);

      final valueFields = surface.valueFields;
      await _scrollFinderTo(tester, valueFields);
      await tester.enterText(valueFields.first, surface.firstValue);
      await tester.pump();
      await _scrollFinderTo(tester, valueFields);
      await tester.enterText(valueFields.last, surface.secondValue);
      await tester.pump();
      final invalidFields = surface.invalidIdentityFields;
      if (invalidFields != null) {
        await _scrollFinderTo(tester, invalidFields);
        await tester.enterText(invalidFields.first, 'invalid-first');
        await tester.pump();
        expect(find.text(surface.invalidError), findsOneWidget);
      }

      await _scrollToTop(tester);
      await _scrollFinderTo(tester, valueFields);
      final firstRow = find.ancestor(
        of: valueFields.first,
        matching: find.byWidgetPredicate(surface.isSemanticRow),
      );
      final firstRemove = find.descendant(
        of: firstRow,
        matching: surface.removeButtons,
      );
      expect(firstRemove, findsOneWidget, reason: surface.name);
      await _scrollFinderTo(tester, firstRemove);
      expect(firstRemove.hitTestable(), findsOneWidget, reason: surface.name);
      await tester.tap(firstRemove.hitTestable());
      await tester.pump();

      final remainingDraft = await _readDraft(tester);
      expect(
        _collectionValue(surface: surface, draft: remainingDraft),
        surface.secondValue,
        reason: surface.name,
      );
      final state = container.read(
        earthquakeVxseDebugEditorControllerProvider(
          EarthquakeVxseDebugEditorSession(current: current),
        ),
      );
      expect(
        state.typedInputValues.values,
        contains(surface.secondValue),
        reason: surface.name,
      );
      expect(
        state.typedInputValues.values,
        isNot(contains(surface.firstValue)),
        reason: surface.name,
      );
      expect(state.typedInputErrors, isEmpty, reason: surface.name);
      expect(state.canApply, isTrue, reason: surface.name);
    });
  }

  for (final surface in _CollectionSurface.values) {
    testWidgets('${surface.name}は連続追加してもidentityが一意で適用可能', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final current = _currentEarthquake().copyWith(
        telegramTypes: [surface.type],
      );
      await _pumpEditorWithContainer(
        tester,
        container: container,
        current: current,
      );

      for (var count = 0; count < 2; count++) {
        final addButton = surface.addButton;
        await _scrollToTop(tester);
        await _scrollFinderTo(tester, addButton);
        await tester.tap(addButton.hitTestable().first);
        await tester.pump();
      }

      final draft = await _readDraft(tester);
      final identities = _collectionIdentities(surface: surface, draft: draft);
      expect(identities.length, greaterThanOrEqualTo(2), reason: surface.name);
      expect(
        identities.toSet().length,
        identities.length,
        reason: surface.name,
      );
      final state = container.read(
        earthquakeVxseDebugEditorControllerProvider(
          EarthquakeVxseDebugEditorSession(current: current),
        ),
      );
      expect(state.canApply, isTrue, reason: surface.name);
      await _scrollTo(tester, const Key('vxse-apply-button'));
      expect(
        tester
            .widget<FilledButton>(find.byKey(const Key('vxse-apply-button')))
            .onPressed,
        isNotNull,
        reason: surface.name,
      );
    });
  }

  testWidgets('ordinary階級dropdownはnodeと外側map keyをatomicに移動する', (tester) async {
    await _pumpEditor(tester);
    final dropdown = find.byKey(const Key('ordinary-region-max'));
    await _scrollFinderTo(tester, dropdown);
    await tester.tap(dropdown.hitTestable());
    await tester.pumpAndSettle();
    await tester.tap(find.text('5-').last);
    await tester.pumpAndSettle();

    final draft = await _readDraft(tester) as EarthquakeVxse53DebugDraft;
    expect(draft.regions, isNot(contains(JmaIntensity.four)));
    expect(draft.regions[JmaIntensity.fiveLower], hasLength(1));
    expect(
      draft.regions[JmaIntensity.fiveLower]?.single.maxIntensity,
      JmaIntensity.fiveLower,
    );
  });

  testWidgets('LPGM階級dropdownはnodeと外側map keyをatomicに移動する', (tester) async {
    await _pumpEditor(tester);
    await _selectType(tester, EarthquakeTelegramType.vxse62);
    final dropdown = find.byKey(const Key('lpgm-region-max'));
    await _scrollFinderTo(tester, dropdown);
    await tester.tap(dropdown.hitTestable());
    await tester.pumpAndSettle();
    await tester.tap(find.text('3').last);
    await tester.pumpAndSettle();

    final draft = await _readDraft(tester) as EarthquakeVxse62DebugDraft;
    expect(draft.lpgmRegions, isNot(contains(JmaLpgmIntensity.two)));
    expect(draft.lpgmRegions[JmaLpgmIntensity.three], hasLength(1));
    expect(
      draft.lpgmRegions[JmaLpgmIntensity.three]?.single.maxLpgmIntensity,
      JmaLpgmIntensity.three,
    );
  });

  testWidgets('選択したVXSE型が所有するフォームだけを表示する', (tester) async {
    await _pumpEditor(tester);

    expect(find.byKey(const Key('shared-report-fields')), findsOneWidget);
    await _scrollTo(tester, const Key('hypocenter-fields'));
    expect(find.byKey(const Key('hypocenter-fields')), findsOneWidget);
    await _scrollTo(tester, const Key('seismic-intensity-fields'));
    expect(find.byKey(const Key('seismic-intensity-fields')), findsOneWidget);
    expect(find.byKey(const Key('lpgm-fields')), findsNothing);
    expect(find.byKey(const Key('ordinary-prefecture-add')), findsOneWidget);
    expect(find.byKey(const Key('ordinary-city-add')), findsOneWidget);
    expect(find.byKey(const Key('ordinary-station-add')), findsOneWidget);

    await _scrollToTop(tester);
    await tester.tap(find.byKey(const Key('vxse-type-dropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('VXSE62').last);
    await tester.pumpAndSettle();

    await _scrollTo(tester, const Key('hypocenter-fields'));
    expect(find.byKey(const Key('hypocenter-fields')), findsOneWidget);
    await _scrollTo(tester, const Key('seismic-intensity-fields'));
    expect(find.byKey(const Key('seismic-intensity-fields')), findsOneWidget);
    await _scrollTo(tester, const Key('lpgm-fields'));
    expect(find.byKey(const Key('lpgm-fields')), findsOneWidget);
    expect(find.byKey(const Key('lpgm-region-add')), findsOneWidget);
    expect(find.byKey(const Key('lpgm-prefecture-add')), findsOneWidget);
    expect(find.byKey(const Key('ordinary-city-add')), findsNothing);
    expect(find.byKey(const Key('lpgm-city-add')), findsNothing);
    expect(find.byKey(const Key('lpgm-station-add')), findsOneWidget);
    expect(
      find.byKey(const Key('station-parent-city-locator')),
      findsNWidgets(2),
    );
    final parentCityCode = find
        .byKey(const Key('station-parent-city-code'))
        .first;
    await _scrollFinderTo(tester, parentCityCode);
    await tester.enterText(parentCityCode, '999001');
    await tester.pump();
    await _scrollTo(tester, const Key('vxse-json-field'));
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('vxse-json-field')))
          .controller
          ?.text,
      contains('999001'),
    );
  });

  testWidgets('フォーム編集はJSONへ同期しtyped listを追加編集削除できる', (tester) async {
    await _pumpEditor(tester);
    final reportedAt = find.byKey(const Key('reported-at-field'));

    await tester.enterText(reportedAt, '2026-07-24T04:00:00.000Z');
    await tester.pump();

    final regionRows = find.byKey(const Key('ordinary-region-row'));
    await _scrollFinderTo(tester, regionRows);
    final before = regionRows.evaluate().length;
    final regionAdd = find.byKey(const Key('ordinary-region-add'));
    await _scrollFinderTo(tester, regionAdd);
    await tester.tap(regionAdd.hitTestable());
    await tester.pump();
    expect(
      find.byKey(const Key('ordinary-region-row')).evaluate().length,
      before + 1,
    );

    final regionCodes = find.byKey(const Key('ordinary-region-code'));
    await _scrollFinderTo(tester, regionCodes);
    await tester.enterText(regionCodes.last, '999');
    await tester.pump();
    await _scrollTo(tester, const Key('vxse-json-field'));
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('vxse-json-field')))
          .controller
          ?.text,
      contains('999'),
    );
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('vxse-json-field')))
          .controller
          ?.text,
      contains('2026-07-24T04:00:00.000Z'),
    );

    await _scrollToTop(tester);
    final regionRemoves = find.byKey(const Key('ordinary-region-remove'));
    await _scrollFinderTo(tester, regionRemoves);
    await tester.tap(regionRemoves.hitTestable().last);
    await tester.pump();
    await _scrollToTop(tester);
    await _scrollTo(tester, const Key('ordinary-region-row'));
    expect(
      find.byKey(const Key('ordinary-region-row')).evaluate().length,
      before,
    );
  });

  testWidgets('不正な手動JSONはraw textと簡潔なエラーを表示する', (tester) async {
    await _pumpEditor(tester);

    await _scrollTo(tester, const Key('vxse-json-field'));
    await tester.enterText(find.byKey(const Key('vxse-json-field')), '{broken');
    await tester.pump();

    expect(find.text('{broken'), findsOneWidget);
    expect(find.text('JSONの形式が正しくありません'), findsOneWidget);
    final button = tester.widget<FilledButton>(
      find.byKey(const Key('vxse-apply-button')),
    );
    expect(button.onPressed, isNull);
  });

  for (final type in [
    EarthquakeTelegramType.vxse53,
    EarthquakeTelegramType.vxse62,
  ]) {
    for (final scale in [1.0, 2.0]) {
      testWidgets('${type.name} textScale $scale の全sectionでoverflowしない', (
        tester,
      ) async {
        await _pumpEditor(tester, textScale: scale, width: 360);
        await _selectType(tester, type);

        final sectionKeys = [
          const Key('shared-report-fields'),
          const Key('hypocenter-fields'),
          const Key('seismic-intensity-fields'),
          const Key('ordinary-region-row'),
          const Key('ordinary-prefecture-row'),
          if (type == EarthquakeTelegramType.vxse53) ...[
            const Key('ordinary-city-row'),
            const Key('ordinary-station-row'),
          ],
          if (type == EarthquakeTelegramType.vxse62) ...[
            const Key('lpgm-fields'),
            const Key('lpgm-region-row'),
            const Key('lpgm-prefecture-row'),
            const Key('ordinary-station-row'),
            const Key('lpgm-station-row'),
          ],
          const Key('comments-fields'),
          const Key('vxse-json-field'),
          const Key('vxse-apply-button'),
        ];
        for (final key in sectionKeys) {
          await _scrollFinderTo(tester, find.byKey(key));
          expect(tester.takeException(), isNull, reason: key.toString());
        }
      });
    }
  }
}

Future<void> _scrollTo(WidgetTester tester, Key key) => tester.dragUntilVisible(
  find.byKey(key),
  find
      .descendant(
        of: find.byKey(const Key('vxse-editor-scroll')),
        matching: find.byType(Scrollable),
      )
      .first,
  const Offset(0, -200),
);

Future<void> _scrollFinderTo(WidgetTester tester, Finder finder) async {
  final scrollView = find.byKey(const Key('vxse-editor-scroll'));
  for (var attempt = 0; attempt < 30 && finder.evaluate().isEmpty; attempt++) {
    await tester.drag(scrollView, const Offset(0, -240));
    await tester.pump();
  }
  for (
    var attempt = 0;
    attempt < 30 && finder.hitTestable().evaluate().isEmpty;
    attempt++
  ) {
    await tester.drag(scrollView, const Offset(0, -300));
    await tester.pump();
  }
}

Future<void> _scrollToTop(WidgetTester tester) async {
  await tester.fling(
    find.byKey(const Key('vxse-editor-scroll')),
    const Offset(0, 5000),
    10000,
  );
  await tester.pumpAndSettle();
}

Future<void> _selectType(
  WidgetTester tester,
  EarthquakeTelegramType type,
) async {
  await _scrollToTop(tester);
  await tester.tap(find.byKey(const Key('vxse-type-dropdown')));
  await tester.pumpAndSettle();
  await tester.tap(find.text(type.name.toUpperCase()).last);
  await tester.pumpAndSettle();
}

Future<EarthquakeVxseDebugDraft> _readDraft(WidgetTester tester) async {
  await _scrollFinderTo(tester, find.byKey(const Key('vxse-json-field')));
  final json = tester
      .widget<TextField>(find.byKey(const Key('vxse-json-field')))
      .controller
      ?.text;
  return EarthquakeVxseDebugDraft.fromJson(
    jsonDecode(json ?? '') as Map<String, dynamic>,
  );
}

Future<void> _pumpEditor(
  WidgetTester tester, {
  double textScale = 1,
  double width = 500,
  Earthquake? current,
}) => tester.pumpWidget(
  ProviderScope(
    child: MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
        child: Scaffold(
          body: SizedBox(
            width: width,
            height: 560,
            child: EarthquakeVxseDebugEditor(
              current: current ?? _currentEarthquake(),
            ),
          ),
        ),
      ),
    ),
  ),
);

Future<void> _pumpEditorWithContainer(
  WidgetTester tester, {
  required ProviderContainer container,
  required Earthquake current,
}) => tester.pumpWidget(
  UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 500,
          height: 560,
          child: EarthquakeVxseDebugEditor(current: current),
        ),
      ),
    ),
  ),
);

enum _CollectionSurface {
  ordinaryRegion,
  vxse51Prefecture,
  ordinaryPrefecture,
  ordinaryCity,
  ordinaryStation,
  lpgmRegion,
  lpgmPrefecture,
  lpgmStation,
  comment,
  prePeriod;

  EarthquakeTelegramType get type => switch (this) {
    .vxse51Prefecture => .vxse51,
    .ordinaryStation ||
    .lpgmRegion ||
    .lpgmPrefecture ||
    .lpgmStation ||
    .prePeriod => .vxse62,
    _ => .vxse53,
  };

  Finder get valueFields => switch (this) {
    .ordinaryRegion => find.byKey(const Key('ordinary-region-name')),
    .vxse51Prefecture ||
    .ordinaryPrefecture => find.byKey(const Key('ordinary-prefecture-name')),
    .ordinaryCity => find.byKey(const Key('ordinary-city-name')),
    .ordinaryStation => find.byKey(const Key('ordinary-station-name')),
    .lpgmRegion => find.byKey(const Key('lpgm-region-name')),
    .lpgmPrefecture => find.byKey(const Key('lpgm-prefecture-name')),
    .lpgmStation => find.byKey(const Key('lpgm-station-name')),
    .comment => find.byKey(const Key('comment-additional')),
    .prePeriod => find.descendant(
      of: find.byKey(const Key('ordinary-station-details')),
      matching: find.byKey(const Key('pre-period-sva')),
    ),
  };

  Finder get removeButtons => switch (this) {
    .ordinaryRegion => find.byKey(const Key('ordinary-region-remove')),
    .vxse51Prefecture ||
    .ordinaryPrefecture => find.byKey(const Key('ordinary-prefecture-remove')),
    .ordinaryCity => find.byKey(const Key('ordinary-city-remove')),
    .ordinaryStation => find.byKey(const Key('ordinary-station-remove')),
    .lpgmRegion => find.byKey(const Key('lpgm-region-remove')),
    .lpgmPrefecture => find.byKey(const Key('lpgm-prefecture-remove')),
    .lpgmStation => find.byKey(const Key('lpgm-station-remove')),
    .comment => find.byKey(const Key('comment-remove')),
    .prePeriod => find.descendant(
      of: find.byKey(const Key('ordinary-station-details')),
      matching: find.byKey(const Key('pre-period-remove')),
    ),
  };

  Finder get addButton => switch (this) {
    .ordinaryRegion => find.byKey(const Key('ordinary-region-add')),
    .vxse51Prefecture ||
    .ordinaryPrefecture => find.byKey(const Key('ordinary-prefecture-add')),
    .ordinaryCity => find.byKey(const Key('ordinary-city-add')),
    .ordinaryStation => find.byKey(const Key('ordinary-station-add')),
    .lpgmRegion => find.byKey(const Key('lpgm-region-add')),
    .lpgmPrefecture => find.byKey(const Key('lpgm-prefecture-add')),
    .lpgmStation => find.byKey(const Key('lpgm-station-add')),
    .comment => find.byKey(const Key('comment-add')),
    .prePeriod => find.descendant(
      of: find.byKey(const Key('ordinary-station-details')),
      matching: find.byKey(const Key('pre-period-add')),
    ),
  };

  bool isSemanticRow(Widget widget) {
    final key = widget.key;
    if (key is! ValueKey<String>) {
      return false;
    }
    return switch (this) {
      .ordinaryRegion => key.value.startsWith('ordinary-region-row.'),
      .vxse51Prefecture ||
      .ordinaryPrefecture => key.value.startsWith('ordinary-prefecture-row.'),
      .ordinaryCity => key.value.startsWith('ordinary-city-row.'),
      .ordinaryStation => key.value.startsWith('ordinary-station-row.'),
      .lpgmRegion => key.value.startsWith('lpgm-region-row.'),
      .lpgmPrefecture => key.value.startsWith('lpgm-prefecture-row.'),
      .lpgmStation => key.value.startsWith('lpgm-station-row.'),
      .comment => key.value.startsWith('comment-row.'),
      .prePeriod => key.value.contains('.prePeriod.'),
    };
  }

  Finder? get invalidIdentityFields => switch (this) {
    .comment => find.byKey(const Key('comment-reported-at')),
    .prePeriod => find.descendant(
      of: find.byKey(const Key('ordinary-station-details')),
      matching: find.byKey(const Key('pre-period-band')),
    ),
    _ => null,
  };

  String get invalidError => switch (this) {
    .comment => '日時を入力してください',
    .prePeriod => '数値を入力してください',
    _ => '',
  };

  String get firstValue => switch (this) {
    .prePeriod => '21.1',
    _ => 'first-$name',
  };

  String get secondValue => switch (this) {
    .prePeriod => '22.2',
    _ => 'second-$name',
  };
}

EarthquakeVxseDebugDraft _twoRowDraft({
  required _CollectionSurface surface,
  required Earthquake current,
}) {
  final draft = const EarthquakeVxseDebugDraftFactory().create(
    current: current,
    type: surface.type,
  );
  return switch (surface) {
    .ordinaryRegion => () {
      final value = draft as EarthquakeVxse53DebugDraft;
      final level = value.regions.keys.single;
      final first =
          value.regions[level]?.single ??
          earthquakeVxseDebugSampleIntensityRegion;
      return value.copyWith(
        regions: {
          level: [
            first,
            first.copyWith(
              region: first.region.copyWith(code: 'second-region'),
            ),
          ],
        },
      );
    }(),
    .vxse51Prefecture => () {
      final value = draft as EarthquakeVxse51DebugDraft;
      final level = value.prefectures.keys.single;
      final first =
          value.prefectures[level]?.single ??
          earthquakeVxseDebugSampleIntensityPrefecture;
      return value.copyWith(
        prefectures: {
          level: [
            first,
            first.copyWith(
              prefecture: first.prefecture.copyWith(code: 'second-prefecture'),
            ),
          ],
        },
      );
    }(),
    .ordinaryPrefecture => () {
      final value = draft as EarthquakeVxse53DebugDraft;
      final level = value.intensityTree.keys.single;
      final first =
          value.intensityTree[level]?.single ??
          intensityTreeOrSample(tree: null).values.single.single;
      return value.copyWith(
        intensityTree: {
          level: [
            first,
            first.copyWith(
              prefecture: first.prefecture.copyWith(
                prefecture: first.prefecture.prefecture.copyWith(
                  code: 'second-prefecture',
                ),
              ),
              cities: [
                for (final city in first.cities)
                  city.copyWith(
                    city: city.city.copyWith(code: 'second-${city.city.code}'),
                    stations: [
                      for (final station in city.stations)
                        station.copyWith(
                          station: station.station.copyWith(
                            code: 'second-${station.station.code}',
                          ),
                          intensity: station.intensity?.copyWith(
                            code: 'second-${station.station.code}',
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ],
        },
      );
    }(),
    .ordinaryCity => () {
      final value = draft as EarthquakeVxse53DebugDraft;
      final level = value.intensityTree.keys.single;
      final prefecture =
          value.intensityTree[level]?.single ??
          intensityTreeOrSample(tree: null).values.single.single;
      final first = prefecture.cities.single;
      return value.copyWith(
        intensityTree: {
          level: [
            prefecture.copyWith(
              cities: [
                first,
                first.copyWith(
                  city: first.city.copyWith(code: 'second-city'),
                  stations: [
                    for (final station in first.stations)
                      station.copyWith(
                        station: station.station.copyWith(
                          code: 'second-${station.station.code}',
                        ),
                        intensity: station.intensity?.copyWith(
                          code: 'second-${station.station.code}',
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        },
      );
    }(),
    .ordinaryStation => () {
      final value = draft as EarthquakeVxse62DebugDraft;
      final level = value.intensityTree.keys.single;
      final prefecture =
          value.intensityTree[level]?.single ??
          intensityTreeOrSample(tree: null).values.single.single;
      final city = prefecture.cities.single;
      final first = city.stations.single;
      return value.copyWith(
        intensityTree: {
          level: [
            prefecture.copyWith(
              cities: [
                city.copyWith(
                  stations: [
                    first,
                    first.copyWith(
                      station: first.station.copyWith(code: 'second-station'),
                      intensity: first.intensity?.copyWith(
                        code: 'second-station',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        },
      );
    }(),
    .lpgmRegion => () {
      final value = draft as EarthquakeVxse62DebugDraft;
      final level = value.lpgmRegions.keys.single;
      final first =
          value.lpgmRegions[level]?.single ??
          earthquakeVxseDebugSampleLpgmRegion;
      return value.copyWith(
        lpgmRegions: {
          level: [
            first,
            first.copyWith(
              region: first.region.copyWith(code: 'second-lpgm-region'),
            ),
          ],
        },
      );
    }(),
    .lpgmPrefecture => () {
      final value = draft as EarthquakeVxse62DebugDraft;
      final level = value.lpgmIntensityTree.keys.single;
      final first =
          value.lpgmIntensityTree[level]?.single ??
          lpgmTreeOrSample(tree: null).values.single.single;
      return value.copyWith(
        lpgmIntensityTree: {
          level: [
            first,
            first.copyWith(
              region: first.region.copyWith(code: 'second-lpgm-prefecture'),
              cities: [
                for (final city in first.cities)
                  city.copyWith(
                    city: city.city.copyWith(code: 'second-${city.city.code}'),
                    stations: [
                      for (final station in city.stations)
                        station.copyWith(
                          station: station.station.copyWith(
                            code: 'second-${station.station.code}',
                          ),
                          intensity: station.intensity?.copyWith(
                            code: 'second-${station.station.code}',
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ],
        },
      );
    }(),
    .lpgmStation => () {
      final value = draft as EarthquakeVxse62DebugDraft;
      final level = value.lpgmIntensityTree.keys.single;
      final prefecture =
          value.lpgmIntensityTree[level]?.single ??
          lpgmTreeOrSample(tree: null).values.single.single;
      final city = prefecture.cities.single;
      final first = city.stations.single;
      return value.copyWith(
        lpgmIntensityTree: {
          level: [
            prefecture.copyWith(
              cities: [
                city.copyWith(
                  stations: [
                    first,
                    first.copyWith(
                      station: first.station.copyWith(code: 'second-station'),
                      intensity: first.intensity?.copyWith(
                        code: 'second-station',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        },
      );
    }(),
    .comment => draft.copyWith(
      comments: [
        EarthquakeTelegramComment(
          type: surface.type,
          reportedAt: DateTime.utc(2026, 7, 24, 1),
          additional: 'first',
          free: 'first',
        ),
        EarthquakeTelegramComment(
          type: surface.type,
          reportedAt: DateTime.utc(2026, 7, 24, 2),
          additional: 'second',
          free: 'second',
        ),
      ],
    ),
    .prePeriod => () {
      final value = draft as EarthquakeVxse62DebugDraft;
      final level = value.intensityTree.keys.single;
      final prefecture =
          value.intensityTree[level]?.single ??
          intensityTreeOrSample(tree: null).values.single.single;
      final city = prefecture.cities.single;
      final station = city.stations.single;
      final intensity =
          station.intensity ?? earthquakeVxseDebugSampleStationIntensity;
      final first =
          intensity.prePeriods?.single ??
          earthquakeVxseDebugSampleStationIntensity.prePeriods?.single;
      return value.copyWith(
        intensityTree: {
          level: [
            prefecture.copyWith(
              cities: [
                city.copyWith(
                  stations: [
                    station.copyWith(
                      intensity: intensity.copyWith(
                        prePeriods: first == null
                            ? const []
                            : [first, first.copyWith(band: 2)],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        },
      );
    }(),
  };
}

String? _collectionValue({
  required _CollectionSurface surface,
  required EarthquakeVxseDebugDraft draft,
}) => switch (surface) {
  .ordinaryRegion =>
    (draft as EarthquakeVxse53DebugDraft)
        .regions
        .values
        .single
        .single
        .region
        .name
        .ja,
  .vxse51Prefecture =>
    (draft as EarthquakeVxse51DebugDraft)
        .prefectures
        .values
        .single
        .single
        .prefecture
        .name
        .ja,
  .ordinaryPrefecture =>
    (draft as EarthquakeVxse53DebugDraft)
        .intensityTree
        .values
        .single
        .single
        .prefecture
        .prefecture
        .name
        .ja,
  .ordinaryCity =>
    (draft as EarthquakeVxse53DebugDraft)
        .intensityTree
        .values
        .single
        .single
        .cities
        .single
        .city
        .name
        .ja,
  .ordinaryStation =>
    (draft as EarthquakeVxse62DebugDraft)
        .intensityTree
        .values
        .single
        .single
        .cities
        .single
        .stations
        .single
        .station
        .name
        .ja,
  .lpgmRegion =>
    (draft as EarthquakeVxse62DebugDraft)
        .lpgmRegions
        .values
        .single
        .single
        .region
        .name
        .ja,
  .lpgmPrefecture =>
    (draft as EarthquakeVxse62DebugDraft)
        .lpgmIntensityTree
        .values
        .single
        .single
        .region
        .name
        .ja,
  .lpgmStation =>
    (draft as EarthquakeVxse62DebugDraft)
        .lpgmIntensityTree
        .values
        .single
        .single
        .cities
        .single
        .stations
        .single
        .station
        .name
        .ja,
  .comment => draft.comments.single.additional,
  .prePeriod =>
    (draft as EarthquakeVxse62DebugDraft)
        .intensityTree
        .values
        .single
        .single
        .cities
        .single
        .stations
        .single
        .intensity
        ?.prePeriods
        ?.single
        .sva
        .toString(),
};

List<String> _collectionIdentities({
  required _CollectionSurface surface,
  required EarthquakeVxseDebugDraft draft,
}) => switch (surface) {
  .ordinaryRegion => [
    for (final region
        in (draft as EarthquakeVxse53DebugDraft).regions.values.expand(
          (values) => values,
        ))
      region.region.code,
  ],
  .vxse51Prefecture => [
    for (final prefecture
        in (draft as EarthquakeVxse51DebugDraft).prefectures.values.expand(
          (values) => values,
        ))
      prefecture.prefecture.code,
  ],
  .ordinaryPrefecture => [
    for (final prefecture
        in (draft as EarthquakeVxse53DebugDraft).intensityTree.values.expand(
          (values) => values,
        ))
      prefecture.prefecture.prefecture.code,
  ],
  .ordinaryCity => [
    for (final city
        in (draft as EarthquakeVxse53DebugDraft).intensityTree.values
            .expand((values) => values)
            .expand((prefecture) => prefecture.cities))
      city.city.code,
  ],
  .ordinaryStation => [
    for (final station
        in (draft as EarthquakeVxse62DebugDraft).intensityTree.values
            .expand((values) => values)
            .expand((prefecture) => prefecture.cities)
            .expand((city) => city.stations))
      station.station.code,
  ],
  .lpgmRegion => [
    for (final region
        in (draft as EarthquakeVxse62DebugDraft).lpgmRegions.values.expand(
          (values) => values,
        ))
      region.region.code,
  ],
  .lpgmPrefecture => [
    for (final prefecture
        in (draft as EarthquakeVxse62DebugDraft).lpgmIntensityTree.values
            .expand((values) => values))
      prefecture.region.code,
  ],
  .lpgmStation => [
    for (final station
        in (draft as EarthquakeVxse62DebugDraft).lpgmIntensityTree.values
            .expand((values) => values)
            .expand((prefecture) => prefecture.cities)
            .expand((city) => city.stations))
      station.station.code,
  ],
  .comment => [
    for (final comment in draft.comments)
      '${comment.type.name}.${comment.reportedAt.toIso8601String()}',
  ],
  .prePeriod => [
    for (final period
        in (draft as EarthquakeVxse62DebugDraft).intensityTree.values
            .expand((values) => values)
            .expand((prefecture) => prefecture.cities)
            .expand((city) => city.stations)
            .expand((station) => station.intensity?.prePeriods ?? const []))
      period.band.toString(),
  ],
};

Earthquake _currentEarthquake() => Earthquake(
  eventId: '20260724010101',
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026, 7, 24, 1),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: DateTime.utc(2026, 7, 24, 1, 1),
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  telegramTypes: const [EarthquakeTelegramType.vxse53],
  hypocenter: earthquakeVxseDebugSampleHypocenter,
  intensity: null,
  earthquakeType: null,
  estimatedIntensityTileUrl: null,
);
