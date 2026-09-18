import 'dart:async';

import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_error_overlay.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class _FakeCityMaxIntensity extends CityMaxIntensityNotifier {
  new(this._build);

  final Future<CityMaxIntensity> Function() _build;

  @override
  Future<CityMaxIntensity> build() => _build();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('cityMaxIntensityProvider がエラーの場合はエラーオーバーレイを表示する', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          cityMaxIntensityProvider.overrideWith(
            () => _FakeCityMaxIntensity(
              () async => throw Exception('city max intensity failed'),
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: const Scaffold(
            body: Stack(
              children: [
                SizedBox.expand(),
                IntensityHistoryErrorOverlay(),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('震度情報を取得できません'), findsOneWidget);
    expect(find.text('再試行'), findsOneWidget);
    expect(find.text('詳細'), findsOneWidget);
  });

  testWidgets('詳細を見るで詳細シートを開く', (tester) async {
    final messenger = TestDefaultBinaryMessengerBinding.instance;
    messenger.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async => null,
    );
    addTearDown(() {
      messenger.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
    });

    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          cityMaxIntensityProvider.overrideWith(
            () => _FakeCityMaxIntensity(
              () async => throw Exception('city max intensity failed'),
            ),
          ),
          packageInfoProvider.overrideWithValue(
            PackageInfo(
              appName: 'EQMonitor',
              packageName: 'com.yumnumm.eqmonitor',
              version: '0.0.0',
              buildNumber: '0',
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: const Scaffold(
            body: Stack(
              children: [SizedBox.expand(), IntensityHistoryErrorOverlay()],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('詳細'));
    await tester.pumpAndSettle();
    expect(find.textContaining('まとめてコピー'), findsOneWidget);
  });

  testWidgets('cityMaxIntensityProvider が正常な場合はエラーオーバーレイを表示しない', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          cityMaxIntensityProvider.overrideWith(
            () => _FakeCityMaxIntensity(
              () async => const CityMaxIntensity(aggregatedAt: null, items: []),
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: const Scaffold(
            body: Stack(
              children: [
                SizedBox.expand(),
                IntensityHistoryErrorOverlay(),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('震度情報を取得できません'), findsNothing);
    expect(find.text('詳細を見る'), findsNothing);
  });

  testWidgets('再取得失敗時は取得済みデータを覆わずエラーを表示する', (tester) async {
    const cached = CityMaxIntensity(aggregatedAt: null, items: []);
    final refresh = Completer<CityMaxIntensity>();
    var buildCount = 0;
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        cityMaxIntensityProvider.overrideWith(
          () => _FakeCityMaxIntensity(() {
            buildCount++;
            return buildCount == 1 ? Future.value(cached) : refresh.future;
          }),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: const Scaffold(
            body: Stack(
              children: [SizedBox.expand(), IntensityHistoryErrorOverlay()],
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    container.invalidate(cityMaxIntensityProvider);
    await tester.pump();
    refresh.completeError(
      Exception('refresh failed'),
      StackTrace.current,
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('震度情報を更新できません'), findsOneWidget);
    expect(find.text('再試行'), findsOneWidget);
    expect(find.text('詳細を見る'), findsOneWidget);
  });

  testWidgets('再試行が再度失敗しても未処理例外にせずエラー表示を維持する', (
    tester,
  ) async {
    const cached = CityMaxIntensity(aggregatedAt: null, items: []);
    var buildCount = 0;
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        cityMaxIntensityProvider.overrideWith(
          () => _FakeCityMaxIntensity(() {
            buildCount++;
            if (buildCount == 1) {
              return Future.value(cached);
            }
            return Future.error(Exception('refresh failed'));
          }),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: const Scaffold(
            body: Stack(
              children: [SizedBox.expand(), IntensityHistoryErrorOverlay()],
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    container.invalidate(cityMaxIntensityProvider);
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('再試行'));
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('震度情報を更新できません'), findsOneWidget);
  });
}
