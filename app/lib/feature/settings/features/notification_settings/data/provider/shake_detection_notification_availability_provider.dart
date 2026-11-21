import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_role_notifier.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_notification_availability_provider.g.dart';

@riverpod
Future<bool> isShakeDetectionNotificationAvailable(Ref ref) async {
  if (ref.watch(buildConfigProvider).isShakeDetectionEnabled) {
    return true;
  }
  if (!await ref.watch(debugProvider.future)) {
    return false;
  }
  final role = await ref.watch(deviceRoleProvider.future);
  // 権限の未取得・取得失敗を無効とみなして、保存済みの通知条件を停止しない。
  // ロールは自動では取得しないため、一度も取得していない端末もここへ来る。
  if (role == null) {
    throw StateError('Device role is unavailable');
  }
  return role == DeviceRole.admin;
}
