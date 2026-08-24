import 'dart:async';

import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/intensity_history/ui/intensity_history_page.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _FakeMapConfigurationNotifier extends MapConfigurationNotifier {
  new(this._build);

  final Future<MapConfiguration> Function() _build;

  @override
  Future<MapConfiguration> build() => _build();
}

void main() {
  testWidgets('地図設定の初回読み込み中も戻ることができる', (tester) async {
    final pending = Completer<MapConfiguration>();
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          mapConfigurationProvider.overrideWith(
            () => _FakeMapConfigurationNotifier(() => pending.future),
          ),
        ],
        child: _TestApp(page: const IntensityHistoryPage()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byTooltip('戻る'), findsOneWidget);

    await tester.tap(find.byTooltip('戻る'));
    await tester.pumpAndSettle();

    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('地図設定エラーを表示して再試行できる', (
    tester,
  ) async {
    final retryPending = Completer<MapConfiguration>();
    var buildCount = 0;
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          mapConfigurationProvider.overrideWith(
            () => _FakeMapConfigurationNotifier(() {
              buildCount++;
              if (buildCount == 1) {
                throw Exception('map configuration failed');
              }
              return retryPending.future;
            }),
          ),
        ],
        child: _TestApp(page: const IntensityHistoryPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('再試行'), findsOneWidget);
    expect(find.byType(BackButton), findsOneWidget);

    await tester.tap(find.text('再試行'));
    await tester.pump();
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('再試行'), findsNothing);

    await tester.tap(find.byTooltip('戻る'));
    await tester.pumpAndSettle();
    expect(find.text('home'), findsOneWidget);

    retryPending.complete(
      const MapConfiguration(theme: MapTheme.light),
    );
    await tester.pump(const Duration(milliseconds: 300));
  });
}

class _TestApp extends StatelessWidget {
  const new({required this.page});

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          DesignSystemThemeExtension.light(),
        ],
      ),
      initialRoute: '/detail',
      routes: {
        '/': (_) => const Scaffold(body: Text('home')),
        '/detail': (_) => page,
      },
    );
  }
}
