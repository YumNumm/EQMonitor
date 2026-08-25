import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_gpu_probe_panel.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('fixtureとfaultを選択しrenderer generationを無効化できる', (
    tester,
  ) async {
    var atlasFixture = MapSpriteAtlasProbeFixture.production;
    MapGpuFaultPoint? faultPoint;
    var invalidationCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => EqmonitorMapGpuProbePanel(
              atlasFixture: atlasFixture,
              faultPoint: faultPoint,
              counterSnapshot: null,
              onAtlasFixtureChanged: (value) => setState(
                () => atlasFixture = value,
              ),
              onFaultPointChanged: (value) => setState(
                () => faultPoint = value,
              ),
              onInvalidateRendererContextGeneration: () {
                invalidationCount += 1;
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('GPU Probe'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(eqmonitorMapGpuProbeAtlasFixtureKey));
    await tester.pumpAndSettle();
    await tester.tap(find.text('2x2 向き確認').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(eqmonitorMapGpuProbeFaultPointKey));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Atlas upload').last);
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(eqmonitorMapGpuProbeInvalidateGenerationKey),
    );

    expect(atlasFixture, MapSpriteAtlasProbeFixture.orientation2x2);
    expect(faultPoint, MapGpuFaultPoint.atlasUpload);
    expect(invalidationCount, 1);
  });

  testWidgets('resource counterの全状態とrenderer generationを表示する', (
    tester,
  ) async {
    const snapshot = MapGpuResourceCounterSnapshot(
      texture: MapGpuResourceKindCounter(
        active: 1,
        candidate: 2,
        pendingRetire: 3,
        uploads: 4,
        retires: 5,
      ),
      topology: MapGpuResourceKindCounter(
        active: 6,
        candidate: 7,
        pendingRetire: 8,
        uploads: 9,
        retires: 10,
      ),
      instance: MapGpuResourceKindCounter(
        active: 11,
        candidate: 12,
        pendingRetire: 13,
        uploads: 14,
        retires: 15,
      ),
      node: MapGpuResourceKindCounter(
        active: 16,
        candidate: 17,
        pendingRetire: 18,
        uploads: 19,
        retires: 20,
      ),
      rendererContextGeneration: 21,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EqmonitorMapGpuProbePanel(
            atlasFixture: MapSpriteAtlasProbeFixture.alphaHalf,
            faultPoint: MapGpuFaultPoint.frameSubmit,
            counterSnapshot: snapshot,
            onAtlasFixtureChanged: (_) {},
            onFaultPointChanged: (_) {},
            onInvalidateRendererContextGeneration: () {},
          ),
        ),
      ),
    );

    await tester.tap(find.text('GPU Probe'));
    await tester.pumpAndSettle();

    expect(find.text('Renderer generation: 21'), findsOneWidget);
    expect(find.text('Texture'), findsOneWidget);
    expect(find.text('A 1 / C 2 / P 3 / U 4 / R 5'), findsOneWidget);
    expect(find.text('Topology'), findsOneWidget);
    expect(find.text('A 6 / C 7 / P 8 / U 9 / R 10'), findsOneWidget);
    expect(find.text('Instance'), findsOneWidget);
    expect(find.text('A 11 / C 12 / P 13 / U 14 / R 15'), findsOneWidget);
    expect(find.text('Node'), findsOneWidget);
    expect(find.text('A 16 / C 17 / P 18 / U 19 / R 20'), findsOneWidget);
  });
}
