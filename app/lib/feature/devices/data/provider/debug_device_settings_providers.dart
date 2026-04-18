import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_notifier.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/model/push_notification_log.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification/data/model/notification_token.dart';
import 'package:eqmonitor/feature/settings/features/notification/data/provider/notification_token_stream.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_device_settings_providers.g.dart';

typedef DebugDeviceSessionSnapshot = ({
  String deviceId,
  RegisteredDevice device,
  GeneralNotificationSettings notificationSettings,
});

@riverpod
Future<DebugDeviceSessionSnapshot?> debugDeviceSession(Ref ref) async {
  final authToken = ref.watch(authProvider).value;
  if (authToken == null) {
    return null;
  }

  ref.watch(notificationTokenStreamProvider);
  final deviceId = await ref.watch(deviceIdProvider.future);
  final deviceRepository = await ref.watch(deviceRepositoryProvider.future);
  final notificationRepository = await ref.watch(
    pushNotificationRepositoryProvider.future,
  );

  final deviceResult = await deviceRepository.fetchOrRegister(deviceId);
  final device = switch (deviceResult) {
    Success(:final value) => value,
    Failure(:final exception) => throw exception,
  };

  final tokenAsync = ref.watch(notificationTokenStreamProvider);
  final notificationToken =
      tokenAsync.value ?? const NotificationToken();

  final syncResult = await deviceRepository.syncPushTokens(
    deviceId: deviceId,
    token: notificationToken,
  );
  switch (syncResult) {
    case Failure(:final exception):
      throw exception;
    case Success():
      break;
  }

  final settingsResult = await notificationRepository.getNotificationSettings(deviceId);
  final notificationSettings = switch (settingsResult) {
    Success(:final value) => value,
    Failure(:final exception) => throw exception,
  };

  return (
    deviceId: deviceId,
    device: device,
    notificationSettings: notificationSettings,
  );
}

@riverpod
Future<List<PushNotificationLogEntry>> debugNotificationHistory(
  Ref ref,
) async {
  final session = await ref.watch(debugDeviceSessionProvider.future);
  if (session == null) {
    return [];
  }
  final notificationRepository = await ref.watch(pushNotificationRepositoryProvider.future);
  final result = await notificationRepository.getNotificationHistory(
    deviceId: session.deviceId,
    limit: 50,
  );
  return switch (result) {
    Success(:final value) => value.items,
    Failure(:final exception) => throw exception,
  };
}
