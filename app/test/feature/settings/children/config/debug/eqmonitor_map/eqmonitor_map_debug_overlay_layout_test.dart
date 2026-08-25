import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_overlay_layout.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_gpu_probe_panel.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_banner.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'short large-text expanded diagnostics keep both controls and map usable',
    (tester) async {
      tester.view.physicalSize = const Size(320, 480);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      var mapPanCount = 0;
      var moveCount = 0;
      var invalidateCount = 0;
      const bannerSurfaceKey = ValueKey('test-debug-banner-surface');
      const panelSurfaceKey = ValueKey('test-debug-panel-surface');

      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1.8)),
            child: child ?? const SizedBox.shrink(),
          ),
          home: Scaffold(
            body: EqmonitorMapDebugOverlayLayout(
              map: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanUpdate: (_) => mapPanCount += 1,
              ),
              banner: KeyedSubtree(
                key: bannerSurfaceKey,
                child: EqmonitorMapOverlayBanner(
                  presentation: _diagnosticPresentation(),
                  onMoveToHypocenter: () => moveCount += 1,
                ),
              ),
              probePanel: KeyedSubtree(
                key: panelSurfaceKey,
                child: EqmonitorMapGpuProbePanel(
                  atlasFixture: MapSpriteAtlasProbeFixture.production,
                  faultPoint: null,
                  counterSnapshot: null,
                  onAtlasFixtureChanged: (_) {},
                  onFaultPointChanged: (_) {},
                  onInvalidateRendererContextGeneration: () =>
                      invalidateCount += 1,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('GPU Probe'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      final bannerRect = tester.getRect(find.byKey(bannerSurfaceKey));
      final panelRect = tester.getRect(find.byKey(panelSurfaceKey));
      expect(bannerRect.bottom, lessThan(panelRect.top));

      final mapGestureStart = Offset(
        16,
        (bannerRect.bottom + panelRect.top) / 2,
      );
      await tester.dragFrom(mapGestureStart, const Offset(40, 20));
      expect(mapPanCount, greaterThan(0));

      await tester.drag(
        find.descendant(
          of: find.byKey(bannerSurfaceKey),
          matching: find.byType(Scrollable),
        ),
        const Offset(0, -1000),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(eqmonitorMapMoveToHypocenterKey),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(eqmonitorMapMoveToHypocenterKey));
      await tester.drag(
        find.descendant(
          of: find.byKey(panelSurfaceKey),
          matching: find.byType(Scrollable),
        ),
        const Offset(0, -1000),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(eqmonitorMapGpuProbeInvalidateGenerationKey),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(eqmonitorMapGpuProbeInvalidateGenerationKey),
      );

      expect(moveCount, 1);
      expect(invalidateCount, 1);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('bannerとpanel外のtap/dragだけをmapへ渡す', (tester) async {
    var mapTapCount = 0;
    var mapPanCount = 0;
    var bannerTapCount = 0;
    var panelTapCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EqmonitorMapDebugOverlayLayout(
            map: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => mapTapCount += 1,
              onPanUpdate: (_) => mapPanCount += 1,
            ),
            banner: SizedBox(
              height: 96,
              child: Material(
                child: TextButton(
                  onPressed: () => bannerTapCount += 1,
                  child: const Text('Banner action'),
                ),
              ),
            ),
            probePanel: Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 140,
                height: 80,
                child: Material(
                  child: TextButton(
                    onPressed: () => panelTapCount += 1,
                    child: const Text('Probe action'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tapAt(const Offset(100, 300));
    await tester.dragFrom(const Offset(100, 300), const Offset(40, 20));
    await tester.tap(find.text('Banner action'));
    await tester.tap(find.text('Probe action'));

    expect(mapTapCount, 1);
    expect(mapPanCount, greaterThan(0));
    expect(bannerTapCount, 1);
    expect(panelTapCount, 1);
  });
}

EqmonitorMapOverlayPresentation _diagnosticPresentation() =>
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
        regions: 47,
        cities: 1896,
        stations: 4376,
        sprites: 1,
      ),
      coverageState: .incomplete,
      coverageDiagnostic: EarthquakeOverlayCoverageDiagnostic(
        visibleCanonicalTileCount: 8,
        pendingTileCount: 2,
        authoritativeEmptyTileCount: 1,
        sourceLayerAbsentTileCount: 1,
        missingOrInvalidPropertyFeatureCount: 2,
        decodeOrSchemaFailureTileCount: 1,
        requiredCodeUnresolvedCount: 3,
        stationCount: 4376,
        spriteCount: 1,
      ),
      currentZoom: 6.75,
      hypocenter: const (longitude: 140.1, latitude: 36.2),
      canMoveToHypocenter: true,
    );
