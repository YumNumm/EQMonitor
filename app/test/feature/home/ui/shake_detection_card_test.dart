import 'dart:async';

import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/home/ui/component/shake_detection/shake_detection_card.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_region_catalog.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_region_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

const _catalog = ShakeDetectionRegionCatalog(
  stations: [],
  prefectureNames: {'13': '東京都'},
  regionNames: {'350': '東京都23区'},
);

/// 検知が続いている間の 1 フレーム分のイベント。更新のたびに時刻と震度が変わる。
ShakeDetectionEvent _event({required int second}) => ShakeDetectionEvent(
  eventId: 'event-1',
  createdAt: DateTime.utc(2026, 11, 18, 12),
  updatedAt: DateTime.utc(2026, 11, 18, 12, 0, second),
  expiresAt: DateTime.utc(2026, 11, 18, 12, 1, second),
  level: ShakeDetectionLevel.weak,
  pointCount: 1,
  minLat: 35.6,
  maxLat: 35.7,
  minLng: 139.7,
  maxLng: 139.8,
  points: [
    ShakeDetectionPoint(
      code: 'TKY007',
      name: '新宿',
      latitude: 35.69,
      longitude: 139.7,
      intensity: 1 + second / 10,
      intensityDiff: 1,
      prefectureCode: '13',
      regionCode: '350',
    ),
  ],
);

Future<ValueNotifier<ShakeDetectionEvent>> _pumpCard(
  WidgetTester tester, {
  required Future<ShakeDetectionRegionCatalog> catalog,
}) async {
  final event = ValueNotifier(_event(second: 0));
  addTearDown(event.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        shakeDetectionRegionCatalogProvider.overrideWith((ref) => catalog),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [DesignSystemThemeExtension.light()],
        ),
        home: Scaffold(
          body: ValueListenableBuilder(
            valueListenable: event,
            builder: (context, value, _) => ShakeDetectionCard(event: value),
          ),
        ),
      ),
    ),
  );
  return event;
}

final _region = find.textContaining('東京都', findRichText: true);

void main() {
  testWidgets('イベントが更新された直後のフレームでも、揺れた範囲の行が消えない', (tester) async {
    final event = await _pumpCard(tester, catalog: Future.value(_catalog));
    await tester.pumpAndSettle();
    expect(_region, findsOneWidget);

    for (var second = 1; second <= 5; second++) {
      event.value = _event(second: second);
      // 更新を反映する最初のフレームだけを進める。
      await tester.pump();

      expect(_region, findsOneWidget, reason: '$second 回目の更新');
    }
  });

  testWidgets('対応表の読み込み前は見出しだけを出し、読み込み後に揺れた範囲を出す', (tester) async {
    final catalog = Completer<ShakeDetectionRegionCatalog>();
    await _pumpCard(tester, catalog: catalog.future);
    await tester.pump();

    expect(find.text('弱い揺れを検知'), findsOneWidget);
    expect(_region, findsNothing);

    catalog.complete(_catalog);
    await tester.pump();
    await tester.pump();

    expect(_region, findsOneWidget);
  });
}
