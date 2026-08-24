import 'dart:async';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_layer.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_history_map_layers.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _ControllableCityMaxIntensityNotifier extends CityMaxIntensityNotifier {
  final requests = <Completer<CityMaxIntensity>>[];

  @override
  Future<CityMaxIntensity> build() {
    final request = Completer<CityMaxIntensity>();
    requests.add(request);
    return request.future;
  }
}

void main() {
  testWidgets('初回データ取得後に塗りレイヤーをマウントする', (tester) async {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        cityMaxIntensityProvider.overrideWith(
          _ControllableCityMaxIntensityNotifier.new,
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: IntensityHistoryMapLayers()),
      ),
    );

    expect(find.byType(IntensityFillLayer), findsNothing);

    final notifier = container.read(
      cityMaxIntensityProvider.notifier,
    ) as _ControllableCityMaxIntensityNotifier;
    notifier.requests.last.complete(
      const CityMaxIntensity(
        aggregatedAt: null,
        items: [
          CityMaxIntensityEntry(
            cityCode: '0110110',
            intensity: JmaIntensity.fiveLower,
          ),
        ],
      ),
    );
    await tester.pump();

    expect(find.byType(IntensityFillLayer), findsOneWidget);
  });

  testWidgets('取得済みデータは再読み込み中と再読み込み失敗時にも保持する', (
    tester,
  ) async {
    const initial = CityMaxIntensity(
      aggregatedAt: null,
      items: [
        CityMaxIntensityEntry(
          cityCode: '0110110',
          intensity: JmaIntensity.fiveLower,
        ),
      ],
    );
    const refreshed = CityMaxIntensity(
      aggregatedAt: null,
      items: [
        CityMaxIntensityEntry(
          cityCode: '0110110',
          intensity: JmaIntensity.sixLower,
        ),
      ],
    );
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        cityMaxIntensityProvider.overrideWith(
          _ControllableCityMaxIntensityNotifier.new,
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: IntensityHistoryMapLayers()),
      ),
    );
    final notifier = container.read(
      cityMaxIntensityProvider.notifier,
    ) as _ControllableCityMaxIntensityNotifier;
    notifier.requests.last.complete(initial);
    await tester.pump();

    container.invalidate(cityMaxIntensityProvider);
    await tester.pump();
    expect(
      tester.widget<IntensityFillLayer>(find.byType(IntensityFillLayer)).items,
      initial.items,
    );

    notifier.requests.last.complete(refreshed);
    await tester.pump();
    await tester.pump();
    expect(
      tester.widget<IntensityFillLayer>(find.byType(IntensityFillLayer)).items,
      refreshed.items,
    );

    container.invalidate(cityMaxIntensityProvider);
    await tester.pump();
    notifier.requests.last.completeError(
      Exception('refresh failed'),
      StackTrace.current,
    );
    await tester.pump();
    await tester.pump();
    expect(
      tester.widget<IntensityFillLayer>(find.byType(IntensityFillLayer)).items,
      refreshed.items,
    );
  });
}
