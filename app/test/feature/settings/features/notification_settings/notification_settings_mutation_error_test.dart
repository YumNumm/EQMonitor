import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/earthquake_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/eew_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/shake_detection_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('general settings save error shows SnackBar', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: _TestApp(home: NotificationSettingsPage())),
    );

    final context = tester.element(find.byType(NotificationSettingsPage));
    final future = GeneralNotificationSettingsNotifier.saveMutation.run(
      ProviderScope.containerOf(context),
      (_) async {
        throw Exception('save failed');
      },
    );
    future.ignore();
    await tester.pump();

    expect(find.textContaining('設定の保存に失敗しました'), findsOneWidget);
  });

  testWidgets('EEW save error shows SnackBar', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: _TestApp(home: EewSettingsPage())),
    );

    final context = tester.element(find.byType(EewSettingsPage));
    final future = EewSettingsNotifier.saveSettingsMutation.run(
      ProviderScope.containerOf(context),
      (_) async {
        throw Exception('eew failed');
      },
    );
    future.ignore();
    await tester.pump();

    expect(find.textContaining('設定の保存に失敗しました'), findsOneWidget);
  });

  testWidgets('earthquake save error shows SnackBar', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: _TestApp(home: EarthquakeSettingsPage())),
    );

    final context = tester.element(find.byType(EarthquakeSettingsPage));
    final future = EarthquakeNotificationSettingsNotifier.saveSettingsMutation
        .run(ProviderScope.containerOf(context), (_) async {
          throw Exception('earthquake failed');
        });
    future.ignore();
    await tester.pump();

    expect(find.textContaining('設定の保存に失敗しました'), findsOneWidget);
  });

  testWidgets('shake detection level update error shows SnackBar', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: _TestApp(home: ShakeDetectionSettingsPage()),
      ),
    );

    final context = tester.element(find.byType(ShakeDetectionSettingsPage));
    final future = ShakeDetectionSettingsNotifier.updateLevelMutation.run(
      ProviderScope.containerOf(context),
      (_) async {
        throw Exception('shake failed');
      },
    );
    future.ignore();
    await tester.pump();

    expect(find.textContaining('震度レベルの更新に失敗しました'), findsOneWidget);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: [
        DesignSystemThemeExtension.light(),
      ],
    );
    return MaterialApp(
      theme: theme,
      home: home,
    );
  }
}
