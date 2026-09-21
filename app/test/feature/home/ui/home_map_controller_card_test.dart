import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_controller_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('無効なホームボタンはタップを受け付けない', (tester) async {
    var tapCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [DesignSystemThemeExtension.light()],
        ),
        home: Scaffold(
          body: HomeMapControllerCard(
            isLocationButtonEnabled: false,
            onLocationButtonTap: () => tapCount += 1,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.home_rounded));
    await tester.pump();

    expect(tapCount, 0);
  });
  testWidgets('native toolbar preserves actions and light haptic feedback', (
    tester,
  ) async {
    final actions = <String>[];
    final haptics = <String>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
          if (call.method == 'HapticFeedback.vibrate') {
            haptics.add(call.arguments as String);
          }
          return null;
        });
    addTearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, null);
    });
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: [DesignSystemThemeExtension.light()]),
        home: Scaffold(
          body: HomeMapControllerCard(
            onLayerButtonTap: () => actions.add('layers'),
            onLocationButtonTap: () => actions.add('home'),
            onLabelDebugButtonTap: () => actions.add('labels'),
            onDebugButtonTap: () => actions.add('debug'),
          ),
        ),
      ),
    );
    expect(find.byType(M3EVerticalFloatingToolbar), findsOneWidget);
    for (final label in [
      '地図レイヤー設定',
      'ホームの表示範囲に戻す',
      '地図ラベルをデバッグ',
      '地図をデバッグ',
    ]) {
      await tester.tap(find.byTooltip(label));
      await tester.pump();
    }
    expect(actions, ['layers', 'home', 'labels', 'debug']);
    expect(haptics, List.filled(4, 'HapticFeedbackType.lightImpact'));
    expect(tester.takeException(), isNull);
  });

  testWidgets('unavailable debug actions are absent', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          extensions: [DesignSystemThemeExtension.dark()],
        ),
        home: const Scaffold(body: HomeMapControllerCard()),
      ),
    );
    expect(find.byIcon(Icons.label_rounded), findsNothing);
    expect(find.byIcon(Icons.bug_report_rounded), findsNothing);
    expect(find.byTooltip('地図レイヤー設定'), findsOneWidget);
    expect(find.byTooltip('ホームの表示範囲に戻す'), findsOneWidget);
  });
}
