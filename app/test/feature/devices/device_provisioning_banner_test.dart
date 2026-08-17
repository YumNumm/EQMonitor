import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/ui/component/device_provisioning_banner.dart';
import 'package:material_ui/material_ui.dart';
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
            extensions: [DesignSystemThemeExtension.light()],
          ),
          home: const Scaffold(
            body: DeviceProvisioningBanner(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('通知の初期設定が完了していません'), findsOneWidget);
    expect(find.text('再試行'), findsOneWidget);
  });

  testWidgets(
    'required provisioning defers sync notifier until provisioning completes',
    (tester) async {
      final syncBuildTracker = _SyncBuildTracker();
      final container = ProviderContainer(
        overrides: [
          deviceProvisioningProvider.overrideWith(
            _ControllableDeviceProvisioningNotifier.new,
          ),
          pushTokenSyncProvider.overrideWith(
            () => _TrackedPushTokenSyncNotifier(syncBuildTracker),
          ),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: ThemeData.light().copyWith(
              extensions: [DesignSystemThemeExtension.light()],
            ),
            home: const Scaffold(
              body: DeviceProvisioningBanner(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('通知の初期設定が完了していません'), findsOneWidget);
      expect(find.text('再試行'), findsOneWidget);
      expect(syncBuildTracker.buildCount, 0);

      syncBuildTracker.allowBuild = true;
      final provisioningNotifier =
          container.read(deviceProvisioningProvider.notifier)
              as _ControllableDeviceProvisioningNotifier;
      provisioningNotifier.completeProvisioning();
      await tester.pumpAndSettle();

      expect(syncBuildTracker.buildCount, 1);
      expect(find.text('ネットワークに接続できません'), findsOneWidget);
      expect(find.text('再試行'), findsOneWidget);
    },
  );
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

final class _ControllableDeviceProvisioningNotifier
    extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.required;

  void completeProvisioning() {
    state = const AsyncData(DeviceProvisioningStatus.notRequired);
  }
}

final class _SyncBuildTracker {
  var allowBuild = false;
  var buildCount = 0;
}

final class _TrackedPushTokenSyncNotifier extends PushTokenSyncNotifier {
  _TrackedPushTokenSyncNotifier(this.tracker);

  final _SyncBuildTracker tracker;

  @override
  Future<PushTokenSyncSnapshot> build() async {
    tracker.buildCount++;
    if (!tracker.allowBuild) {
      throw StateError('sync notifier built before provisioning completed');
    }
    return const PushTokenSyncSnapshot(
      fcm: FailedTokenState(error: NetworkUnreachableException()),
      apnsNotification: NotApplicableTokenState(),
      apnsPushToStart: NotApplicableTokenState(),
    );
  }
}
