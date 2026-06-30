import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/model/push_notification_log.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_notification_repository.g.dart';

@Riverpod(keepAlive: true)
Future<PushNotificationRepository> pushNotificationRepository(Ref ref) async =>
    PushNotificationRepository(await ref.watch(apiClientProvider.future));

class PushNotificationRepository {
  PushNotificationRepository(this._api);

  final api.ApiClient _api;

  Future<Result<GeneralNotificationSettings, Exception>>
  getNotificationSettings(String deviceId) => Result.capture(() async {
    final response = await _api.device.getV2DeviceMeSettingsNotification();
    return response.data.toGeneralNotificationSettings;
  });

  Future<Result<GeneralNotificationSettings, Exception>>
  patchNotificationSettings({
    required String deviceId,
    required GeneralNotificationSettings settings,
  }) => Result.capture(() async {
    final response = await _api.device.patchV2DeviceMeSettingsNotification(
      body: api.NotificationSettingsRequest(
        notificationEnabled: settings.notificationEnabled,
        tsunamiEnabled: settings.tsunamiEnabled,
        trainingEnabled: settings.trainingEnabled,
        nankaiExtraordinaryEnabled: settings.nankaiExtraordinaryEnabled,
        nankaiRegularEnabled: settings.nankaiRegularEnabled,
        hokkaido3renOffshoreEnabled: settings.hokkaido3renOffshoreEnabled,
      ),
    );
    return response.data.toGeneralNotificationSettings;
  });

  Future<Result<PushNotificationHistory, Exception>> getNotificationHistory({
    required String deviceId,
    int? limit,
    String? cursor,
  }) => Result.capture(() async {
    final response = await _api.notification.getV2DeviceMeNotificationHistory(
      limit: limit,
      cursor: cursor,
    );
    return response.data.toPushNotificationHistory;
  });

  Future<Result<TestNotificationDeliveryResult, Exception>>
  sendTestNotification({
    required String deviceId,
    required TestNotificationKind kind,
  }) => Result.capture(() async {
    final response = await _api.notification.postV2DeviceMeNotificationTest(
      body: kind.toApiRequest,
    );
    return response.data.toTestNotificationDeliveryResult;
  });

  /// 指定したイベントIDの実データをDBから取得し、実際の通知パイプラインを
  /// 通してこのデバイスにのみ通知を配信する（EEW + VXSE51/52/53）
  Future<Result<TestScenarioDeliveryResult, Exception>> sendTestScenario({
    required String deviceId,
    required String eventId,
  }) => Result.capture(() async {
    final response = await _api.notification
        .postV2DeviceMeNotificationTestScenario(
          body: api.TestScenarioRequest(eventId: eventId),
        );
    return response.data.toTestScenarioDeliveryResult;
  });
}
