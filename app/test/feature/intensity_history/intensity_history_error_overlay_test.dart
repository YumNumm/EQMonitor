import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_error_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('prefectureHighestProvider がエラーの場合はエラーオーバーレイを表示する', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          prefectureHighestProvider.overrideWith(
            (_) async => throw Exception('prefecture failed'),
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

    await tester.tap(find.text('詳細を見る'));
    await tester.pumpAndSettle();

    expect(find.text('エラー詳細'), findsOneWidget);
    expect(find.textContaining('prefecture failed'), findsOneWidget);
  });

  testWidgets('prefectureHighestProvider が正常な場合はエラーオーバーレイを表示しない', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          prefectureHighestProvider.overrideWith((_) async => []),
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
