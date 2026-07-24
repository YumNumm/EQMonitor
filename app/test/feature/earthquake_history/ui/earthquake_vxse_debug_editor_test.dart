import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_vxse_debug_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
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
    tester
        .widget<TextFormField>(
          find.byKey(const Key('station-parent-city-code')).first,
        )
        .onChanged
        ?.call('999001');
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

    await _scrollTo(tester, const Key('ordinary-region-add'));
    final before = find
        .byKey(const Key('ordinary-region-row'))
        .evaluate()
        .length;
    tester
        .widget<TextButton>(find.byKey(const Key('ordinary-region-add')))
        .onPressed
        ?.call();
    await tester.pump();
    expect(
      find.byKey(const Key('ordinary-region-row')).evaluate().length,
      before + 1,
    );

    tester
        .widget<TextFormField>(
          find.byKey(const Key('ordinary-region-code')).last,
        )
        .onChanged
        ?.call('999');
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

    tester
        .widget<IconButton>(
          find.byKey(const Key('ordinary-region-remove')).last,
        )
        .onPressed
        ?.call();
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

  for (final scale in [1.0, 2.0]) {
    testWidgets('textScale $scale でoverflowしない', (tester) async {
      await _pumpEditor(tester, textScale: scale);

      await tester.drag(
        find.byKey(const Key('vxse-editor-scroll')),
        const Offset(0, -1200),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
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

Future<void> _scrollToTop(WidgetTester tester) async {
  await tester.fling(
    find.byKey(const Key('vxse-editor-scroll')),
    const Offset(0, 5000),
    10000,
  );
  await tester.pumpAndSettle();
}

Future<void> _pumpEditor(WidgetTester tester, {double textScale = 1}) =>
    tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
            child: Scaffold(
              body: SizedBox(
                width: 500,
                height: 560,
                child: EarthquakeVxseDebugEditor(current: _currentEarthquake()),
              ),
            ),
          ),
        ),
      ),
    );

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
