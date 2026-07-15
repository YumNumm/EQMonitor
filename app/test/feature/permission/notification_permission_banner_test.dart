import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/notification_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/notifier/notification_permission_banner_dismissed_notifier.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:eqmonitor/feature/permission/ui/component/notification_permission_banner.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Widget _app(Widget child) => MaterialApp(
  theme: ThemeData.light().copyWith(
    extensions: [DesignSystemThemeExtension.light()],
  ),
  home: Scaffold(body: child),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('未許可なら表示', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          isNotificationPermissionGrantedProvider.overrideWith(
            (ref) async => false,
          ),
        ],
        child: _app(const NotificationPermissionBanner(bottomSpacing: 0)),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('通知'), findsWidgets);
  });

  testWidgets('許可済みなら非表示', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          isNotificationPermissionGrantedProvider.overrideWith(
            (ref) async => true,
          ),
        ],
        child: _app(const NotificationPermissionBanner(bottomSpacing: 0)),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('通知'), findsNothing);
  });

  testWidgets('dismiss 済みなら非表示', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          isNotificationPermissionGrantedProvider.overrideWith(
            (ref) async => false,
          ),
          notificationPermissionBannerDismissedProvider.overrideWith(
            () => _AlwaysDismissed(),
          ),
        ],
        child: _app(const NotificationPermissionBanner(bottomSpacing: 0)),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('通知'), findsNothing);
  });

  testWidgets('権限要求成功後に OS 通知権限を再取得する', (tester) async {
    var buildCount = 0;
    final container = ProviderContainer(
      overrides: [
        permissionRepositoryProvider.overrideWithValue(
          _SuccessfulPermissionRepository(),
        ),
        osNotificationPermissionProvider.overrideWith((ref) async {
          buildCount++;
          return OsNotificationPermission.fromNotificationSettings(
            _notificationSettings(AuthorizationStatus.denied),
          );
        }),
      ],
    );
    addTearDown(container.dispose);
    container.listen(osNotificationPermissionProvider, (_, _) {});
    await container.read(osNotificationPermissionProvider.future);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _app(const NotificationPermissionBanner(bottomSpacing: 0)),
      ),
    );
    await tester.pumpAndSettle();
    expect(buildCount, 1);

    await tester.tap(find.text('通知が許可されていません'));
    await tester.pumpAndSettle();
    await container.read(osNotificationPermissionProvider.future);

    expect(buildCount, 2);
  });
}

class _AlwaysDismissed extends NotificationPermissionBannerDismissed {
  @override
  Future<bool> build() async => true;
}

class _FakeFirebaseMessaging extends Fake implements FirebaseMessaging {}

class _SuccessfulPermissionRepository extends PermissionRepository {
  _SuccessfulPermissionRepository()
    : super(readMessaging: _FakeFirebaseMessaging.new);

  @override
  Future<bool> requestNotificationPermission() async => true;
}

NotificationSettings _notificationSettings(AuthorizationStatus status) =>
    NotificationSettings(
      alert: AppleNotificationSetting.notSupported,
      announcement: AppleNotificationSetting.notSupported,
      authorizationStatus: status,
      badge: AppleNotificationSetting.notSupported,
      carPlay: AppleNotificationSetting.notSupported,
      lockScreen: AppleNotificationSetting.notSupported,
      notificationCenter: AppleNotificationSetting.notSupported,
      showPreviews: AppleShowPreviewSetting.notSupported,
      timeSensitive: AppleNotificationSetting.notSupported,
      criticalAlert: AppleNotificationSetting.notSupported,
      sound: AppleNotificationSetting.notSupported,
      providesAppNotificationSettings: AppleNotificationSetting.notSupported,
    );
