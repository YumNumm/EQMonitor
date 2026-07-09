import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/permission/data/notification_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/notifier/notification_permission_banner_dismissed_notifier.dart';
import 'package:eqmonitor/feature/permission/ui/component/notification_permission_banner.dart';
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
}

class _AlwaysDismissed extends NotificationPermissionBannerDismissed {
  @override
  Future<bool> build() async => true;
}
