// 回帰テスト: updateSettings が state.requireValue を使っていたため、
// build 完了前に呼ぶと StateError になっていた（await future で解消）
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _initialSettings = GeneralNotificationSettings(
  notificationEnabled: false,
  tsunamiEnabled: false,
  trainingEnabled: false,
  nankaiExtraordinaryEnabled: false,
  nankaiRegularEnabled: false,
  hokkaido3renOffshoreEnabled: false,
);

class _FakePushNotificationRepository extends PushNotificationRepository {
  _FakePushNotificationRepository() : super(api.ApiClient(Dio()));

  final patchedNotificationEnabled = <bool>[];

  @override
  Future<Result<GeneralNotificationSettings, Exception>>
  getNotificationSettings(String deviceId) async {
    // 実際の API 呼び出しのようにイベントループを跨ぐ
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return const Success(_initialSettings);
  }

  @override
  Future<Result<GeneralNotificationSettings, Exception>>
  patchNotificationSettings({
    required String deviceId,
    required GeneralNotificationSettings settings,
  }) async {
    patchedNotificationEnabled.add(settings.notificationEnabled);
    return Success(settings);
  }
}

class _FakeDeviceProvisioningNotifier extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.notRequired;
}

void main() {
  test('updateSettings can be called before build completes', () async {
    final repository = _FakePushNotificationRepository();
    final container = ProviderContainer(
      overrides: [
        deviceProvisioningProvider.overrideWith(
          _FakeDeviceProvisioningNotifier.new,
        ),
        pushNotificationRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
        deviceIdProvider.overrideWith((ref) async => 'test-device'),
      ],
    );
    addTearDown(container.dispose);

    // build 完了を待たずに即座に updateSettings を呼ぶ
    await container
        .read(generalNotificationSettingsProvider.notifier)
        .updateSettings(notificationEnabled: true);

    expect(repository.patchedNotificationEnabled, [true]);
    expect(
      container.read(generalNotificationSettingsProvider).value,
      _initialSettings.copyWith(notificationEnabled: true),
    );
  });
}
