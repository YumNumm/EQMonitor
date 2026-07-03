import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_error_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('prefectureHighestProvider がエラーの場合はエラーオーバーレイを表示する', (
    tester,
  ) async {
    String? copiedText;
    final messenger = TestDefaultBinaryMessengerBinding.instance;
    messenger.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          final data = call.arguments as Map<Object?, Object?>;
          copiedText = data['text'] as String?;
        }
        return null;
      },
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
            (_) async => throw Exception('prefecture failed'),
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

    await tester.tap(find.text('詳細を見る'));
    await tester.pumpAndSettle();

    expect(find.text('エラー詳細'), findsOneWidget);
    expect(find.textContaining('prefecture failed'), findsOneWidget);
    expect(find.text('コピー'), findsOneWidget);

    await tester.tap(find.text('コピー'));
    await tester.pump();

    expect(copiedText, contains('prefecture failed'));
    expect(find.text('エラー詳細をコピーしました'), findsOneWidget);
  });

  testWidgets('prefectureHighestProvider が正常な場合はエラーオーバーレイを表示しない', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          prefectureHighestProvider.overrideWith((_) async => []),
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
