import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/model/push_notification_log.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_notification_repository.g.dart';

@Riverpod(keepAlive: true)
PushNotificationRepository pushNotificationRepository(Ref ref) =>
    PushNotificationRepository(ref.watch(apiClientProvider));

class PushNotificationRepository {
  PushNotificationRepository(this._api);

  final api.ApiClient _api;

  Future<Result<GeneralNotificationSettings, Exception>>
  getNotificationSettings(String deviceId) => Result.capture(() async {
    final response = await _api.device.getV2DeviceDeviceIdSettingsNotification(
      deviceId: deviceId,
    );
    return response.data.toGeneralNotificationSettings;
  });

  Future<Result<GeneralNotificationSettings, Exception>>
  patchNotificationSettings({
    required String deviceId,
    required GeneralNotificationSettings settings,
  }) => Result.capture(() async {
    final response = await _api.device
        .patchV2DeviceDeviceIdSettingsNotification(
          deviceId: deviceId,
          body: api.NotificationSettingsRequest(
            tsunamiEnabled: settings.tsunamiEnabled,
            trainingEnabled: settings.trainingEnabled,
          ),
        );
    return response.data.toGeneralNotificationSettings;
  });

  Future<Result<PushNotificationHistory, Exception>> getNotificationHistory({
    required String deviceId,
    int? limit,
  }) => Result.capture(() async {
    final response = await _api.notification
        .getV2DeviceDeviceIdNotificationHistory(
          deviceId: deviceId,
          limit: limit,
        );
    return response.data.toPushNotificationHistory;
  });

  Future<Result<TestNotificationDeliveryResult, Exception>>
  sendTestNotification({
    required String deviceId,
    required TestNotificationKind kind,
  }) => Result.capture(() async {
    final response = await _api.notification
        .postV2DeviceDeviceIdNotificationTest(
          deviceId: deviceId,
          body: kind.toApiRequest,
        );
    return response.data.toTestNotificationDeliveryResult;
  });
}
