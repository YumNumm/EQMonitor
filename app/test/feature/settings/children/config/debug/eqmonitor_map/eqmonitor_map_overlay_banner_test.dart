import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_banner.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

EqmonitorMapOverlayPresentation presentation({required bool canMove}) =>
    EqmonitorMapOverlayPresentation(
      eventIdLabel: '20260823020050',
      originTimeLabel: '2026/08/23 02:00:50',
      statusLabel: '通常',
      message: '表示範囲の震度情報は不完全です',
      overlay: null,
      isError: false,
      dataSequence: 7,
      renderGeneration: 9,
      inputCounts: const (
        regions: 1,
        cities: 2,
        stations: 3,
        sprites: 1,
      ),
      coverageState: .incomplete,
      coverageDiagnostic: EarthquakeOverlayCoverageDiagnostic(
        visibleCanonicalTileCount: 5,
        pendingTileCount: 0,
        authoritativeEmptyTileCount: 1,
        sourceLayerAbsentTileCount: 1,
        missingOrInvalidPropertyFeatureCount: 2,
        decodeOrSchemaFailureTileCount: 1,
        requiredCodeUnresolvedCount: 3,
        stationCount: 2,
        spriteCount: 1,
      ),
      currentZoom: 6.75,
      hypocenter: const (longitude: 140.1, latitude: 36.2),
      canMoveToHypocenter: canMove,
    );

void main() {
  testWidgets('version・入力数・描画診断・zoomを可変高で表示する', (tester) async {
    tester.view.physicalSize = const Size(320, 760);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(1.6)),
          child: Scaffold(
            body: EqmonitorMapOverlayBanner(
              presentation: presentation(canMove: false),
              onMoveToHypocenter: null,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Data sequence: 7'), findsOneWidget);
    expect(find.text('Render generation: 9'), findsOneWidget);
    expect(find.text('現在 zoom: 6.75'), findsOneWidget);
    expect(
      find.text('入力数 Region 1 / City 2 / Station 3 / Sprite 1'),
      findsOneWidget,
    );
    expect(find.text('Coverage: 不完全'), findsOneWidget);
    expect(find.textContaining('描画済み Station 2 / Sprite 1'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('rebuildでは移動せず有効なbutton tap一回でcallback一回', (tester) async {
    var invocationCount = 0;
    final banner = EqmonitorMapOverlayBanner(
      presentation: presentation(canMove: true),
      onMoveToHypocenter: () => invocationCount += 1,
    );

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: banner)));
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: banner)));

    expect(invocationCount, 0);
    await tester.tap(find.byKey(eqmonitorMapMoveToHypocenterKey));
    await tester.pump();
    expect(invocationCount, 1);
  });

  testWidgets('committed cameraまたは震源がない場合はbuttonを無効化する', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EqmonitorMapOverlayBanner(
            presentation: presentation(canMove: false),
            onMoveToHypocenter: () {},
          ),
        ),
      ),
    );

    final button = tester.widget<OutlinedButton>(
      find.byKey(eqmonitorMapMoveToHypocenterKey),
    );
    expect(button.onPressed, isNull);
  });
}
