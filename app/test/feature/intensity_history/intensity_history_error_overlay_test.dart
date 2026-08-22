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
    expect(find.text('詳細を見る'), findsOneWidget);
    expect(find.textContaining('地図は操作できます'), findsNothing);
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
    await tester.tap(find.text('詳細を見る'));
    await tester.pumpAndSettle();
    expect(find.textContaining('まとめてコピー'), findsOneWidget);
  });

  testWidgets('cityMaxIntensityProvider が正常な場合はエラーオーバーレイを表示しない', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
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
}
