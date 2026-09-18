import 'dart:async';

import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_loading_overlay.dart';
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
  testWidgets('初回取得中だけ adaptive の進捗表示を出す', (tester) async {
    final container = ProviderContainer(
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
        child: const MaterialApp(
          home: Scaffold(
            body: Stack(children: [IntensityHistoryLoadingOverlay()]),
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    final notifier = container.read(
      cityMaxIntensityProvider.notifier,
    ) as _ControllableCityMaxIntensityNotifier;
    notifier.requests.last.complete(
      const CityMaxIntensity(aggregatedAt: null, items: []),
    );
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('取得済みデータの再読み込み中は進捗表示でマップを覆わない', (
    tester,
  ) async {
    const value = CityMaxIntensity(aggregatedAt: null, items: []);
    final container = ProviderContainer(
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
        child: const MaterialApp(
          home: Scaffold(
            body: Stack(children: [IntensityHistoryLoadingOverlay()]),
          ),
        ),
      ),
    );
    final notifier = container.read(
      cityMaxIntensityProvider.notifier,
    ) as _ControllableCityMaxIntensityNotifier;
    notifier.requests.last.complete(value);
    await tester.pump();
    container.invalidate(cityMaxIntensityProvider);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
