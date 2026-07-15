import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/ui/component/device_provisioning_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('required idle state exposes a manual provisioning action', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deviceProvisioningProvider.overrideWith(
            _RequiredDeviceProvisioningNotifier.new,
          ),
          pushTokenSyncProvider.overrideWith(_IdlePushTokenSyncNotifier.new),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: const Scaffold(
            body: DeviceProvisioningBanner(bottomSpacing: 0),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('通知の初期設定が完了していません'), findsOneWidget);
    expect(find.text('再試行'), findsOneWidget);
  });
}

final class _RequiredDeviceProvisioningNotifier
    extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.required;
}

final class _IdlePushTokenSyncNotifier extends PushTokenSyncNotifier {
  @override
  Future<PushTokenSyncSnapshot> build() async => const PushTokenSyncSnapshot(
    fcm: NotApplicableTokenState(),
    apnsNotification: NotApplicableTokenState(),
    apnsPushToStart: NotApplicableTokenState(),
  );
}
