import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_error_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class _FakePrefectureHighest extends PrefectureHighest {
  _FakePrefectureHighest(this._build);

  final Future<List<HighestIntensityEntry>> Function() _build;

  @override
  Future<List<HighestIntensityEntry>> build() => _build();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('prefectureHighestProvider がエラーの場合はエラーオーバーレイを表示する', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          prefectureHighestProvider.overrideWith(
            () => _FakePrefectureHighest(
              () async => throw Exception('prefecture failed'),
            ),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
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
          prefectureHighestProvider.overrideWith(
            () => _FakePrefectureHighest(
              () async => throw Exception('prefecture failed'),
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
        child: const MaterialApp(
          home: Scaffold(
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

  testWidgets('prefectureHighestProvider が正常な場合はエラーオーバーレイを表示しない', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          prefectureHighestProvider.overrideWith(
            () => _FakePrefectureHighest(() async => []),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
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
