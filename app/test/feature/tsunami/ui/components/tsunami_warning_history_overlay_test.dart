import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/telegram/telegram_type.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_state.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_warning_history_overlay.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

/// `TsunamiWarningHistoryButton`(StatefulWidget)の
/// オーバーレイ開閉振る舞いを、HookWidget化前に固定するテスト。
void main() {
  testWidgets('アイコンをタップすると履歴オーバーレイが開閉する', (tester) async {
    final tsunami = TsunamiState(
      id: 'test-tsunami',
      eventIds: const [],
      isActive: true,
      isCanceled: false,
      updatedAt: DateTime.utc(2024),
      earthquakes: const [],
      latestTelegrams: [
        TsunamiTelegramMeta(
          telegramId: 'tg-1',
          type: TelegramType.vtse41,
          serialNo: 1,
          title: '津波警報・注意報',
          headline: '津波警報を発表しました',
          publishedAt: DateTime.utc(2024, 1, 1, 12),
          reportedAt: DateTime.utc(2024, 1, 1, 12),
          targetedAt: null,
          revokedAt: null,
          infoKind: 'Warning',
        ),
      ],
      regions: const [],
      offshoreStations: const [],
    );

    await tester.pumpWidget(
      _TestApp(home: TsunamiWarningHistoryButton(tsunami: tsunami)),
    );
    await tester.pumpAndSettle();

    expect(find.text('津波警報を発表しました'), findsNothing);

    await tester.tap(find.byIcon(Icons.history));
    await tester.pumpAndSettle();

    expect(find.text('津波警報を発表しました'), findsOneWidget);

    // オーバーレイ表示中はバリアが最前面にあるため、バリア領域をタップして閉じる。
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.text('津波警報を発表しました'), findsNothing);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    );
    return MaterialApp(
      theme: theme,
      home: Scaffold(body: home),
    );
  }
}
