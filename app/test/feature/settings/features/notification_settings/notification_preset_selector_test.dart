import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_permission_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Widget _buildTestWidget({
  required Widget child,
  required FirebaseMessaging messaging,
  required OsNotificationPermission permission,
}) {
  final theme = ThemeData.light().copyWith(
    extensions: [
      DesignSystemThemeExtension.light(),
    ],
  );

  return ProviderScope(
    overrides: [
      firebaseMessagingProvider.overrideWithValue(messaging),
      osNotificationPermissionProvider.overrideWith(
        (ref) async => permission,
      ),
    ],
    child: MaterialApp(
      theme: theme,
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('NotificationPresetSelector', () {
    testWidgets('設定画面では通知しないプリセットを表示しない', (tester) async {
      final settings = _notificationSettings(
        authorizationStatus: AuthorizationStatus.authorized,
      );
      final permission = OsNotificationPermission.fromNotificationSettings(
        settings,
      );

      await tester.pumpWidget(
        _buildTestWidget(
          messaging: _FakeFirebaseMessaging(settings),
          permission: permission,
          child: NotificationPresetSelector(
            selectedPreset: NotificationPreset.recommended,
            onChanged: (_) {},
            style: NotificationPresetSelectorStyle.settings,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('推奨設定'), findsOneWidget);
      expect(find.text('すべて'), findsOneWidget);
      expect(find.text('カスタム'), findsOneWidget);
      expect(find.text('通知しない'), findsNothing);
    });

    testWidgets('オンボーディングでは通知しないプリセットを表示する', (tester) async {
      final settings = _notificationSettings(
        authorizationStatus: AuthorizationStatus.authorized,
      );
      final permission = OsNotificationPermission.fromNotificationSettings(
        settings,
      );

      await tester.pumpWidget(
        _buildTestWidget(
          messaging: _FakeFirebaseMessaging(settings),
          permission: permission,
          child: NotificationPresetSelector(
            selectedPreset: NotificationPreset.recommended,
            onChanged: (_) {},
            style: NotificationPresetSelectorStyle.onboarding,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('通知しない'), findsOneWidget);
    });

    testWidgets('OS権限オフで無効プリセットをタップすると通知権限ダイアログを表示する', (
      tester,
    ) async {
      final messaging = _FakeFirebaseMessaging(
        _notificationSettings(
          authorizationStatus: AuthorizationStatus.denied,
        ),
      );
      final permission = OsNotificationPermission.fromNotificationSettings(
        _notificationSettings(
          authorizationStatus: AuthorizationStatus.denied,
        ),
      );

      await tester.pumpWidget(
        _buildTestWidget(
          messaging: messaging,
          permission: permission,
          child: NotificationPresetSelector(
            selectedPreset: NotificationPreset.none,
            onChanged: (_) {},
            style: NotificationPresetSelectorStyle.onboarding,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('推奨設定'));
      await tester.pumpAndSettle();

      expect(find.text('通知の許可が不足しています'), findsOneWidget);
      expect(
        find.text('緊急地震速報や地震情報の通知を受け取るには、通知の許可が必要です。'),
        findsOneWidget,
      );
    });

    testWidgets('設定画面では重大通知未許可を独立したカードに表示する', (
      tester,
    ) async {
      final messaging = _FakeFirebaseMessaging(
        _notificationSettings(
          authorizationStatus: AuthorizationStatus.authorized,
          criticalAlert: AppleNotificationSetting.disabled,
        ),
      );
      final permission = OsNotificationPermission.fromNotificationSettings(
        _notificationSettings(
          authorizationStatus: AuthorizationStatus.authorized,
          criticalAlert: AppleNotificationSetting.disabled,
        ),
      );

      await tester.pumpWidget(
        _buildTestWidget(
          messaging: messaging,
          permission: permission,
          child: Column(
            children: [
              const NotificationPermissionWarningCard(
                requiresCriticalAlert: true,
              ),
              NotificationPresetSelector(
                selectedPreset: NotificationPreset.recommended,
                onChanged: (_) {},
                style: NotificationPresetSelectorStyle.settings,
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('通知に必要な権限が不足しています'), findsOneWidget);
      expect(find.text('重大な通知が許可されていません'), findsNothing);
    });

    testWidgets('重大通知非対応端末では警告リンクを表示しない', (tester) async {
      final messaging = _FakeFirebaseMessaging(
        _notificationSettings(
          authorizationStatus: AuthorizationStatus.authorized,
          criticalAlert: AppleNotificationSetting.notSupported,
        ),
      );
      final permission = OsNotificationPermission.fromNotificationSettings(
        _notificationSettings(
          authorizationStatus: AuthorizationStatus.authorized,
          criticalAlert: AppleNotificationSetting.notSupported,
        ),
      );

      await tester.pumpWidget(
        _buildTestWidget(
          messaging: messaging,
          permission: permission,
          child: NotificationPresetSelector(
            selectedPreset: NotificationPreset.recommended,
            onChanged: (_) {},
            style: NotificationPresetSelectorStyle.onboarding,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('重大な通知が許可されていません'), findsNothing);
    });

    testWidgets('設定画面ではOS権限オフでもプリセットの選択を維持する', (
      tester,
    ) async {
      NotificationPreset? changedPreset;
      final permission = OsNotificationPermission.fromNotificationSettings(
        _notificationSettings(
          authorizationStatus: AuthorizationStatus.denied,
        ),
      );

      await tester.pumpWidget(
        _buildTestWidget(
          messaging: _FakeFirebaseMessaging(
            _notificationSettings(
              authorizationStatus: AuthorizationStatus.denied,
            ),
          ),
          permission: permission,
          child: NotificationPresetSelector(
            selectedPreset: NotificationPreset.recommended,
            onChanged: (preset) => changedPreset = preset,
            style: NotificationPresetSelectorStyle.settings,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(changedPreset, isNull);
      await tester.tap(find.text('すべて'));
      await tester.pumpAndSettle();
      expect(changedPreset, NotificationPreset.all);
    });
  });
}

class _FakeFirebaseMessaging extends Fake implements FirebaseMessaging {
  new(this._settings);

  final NotificationSettings _settings;

  @override
  Future<NotificationSettings> getNotificationSettings() async => _settings;
}

NotificationSettings _notificationSettings({
  AuthorizationStatus authorizationStatus = AuthorizationStatus.notDetermined,
  AppleNotificationSetting criticalAlert =
      AppleNotificationSetting.notSupported,
}) {
  return NotificationSettings(
    alert: AppleNotificationSetting.notSupported,
    announcement: AppleNotificationSetting.notSupported,
    authorizationStatus: authorizationStatus,
    badge: AppleNotificationSetting.notSupported,
    carPlay: AppleNotificationSetting.notSupported,
    lockScreen: AppleNotificationSetting.notSupported,
    notificationCenter: AppleNotificationSetting.notSupported,
    showPreviews: AppleShowPreviewSetting.notSupported,
    timeSensitive: AppleNotificationSetting.notSupported,
    criticalAlert: criticalAlert,
    sound: AppleNotificationSetting.notSupported,
    providesAppNotificationSettings: AppleNotificationSetting.notSupported,
  );
}
