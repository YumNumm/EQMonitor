import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:eqmonitor/feature/devices/data/provider/device_role_provider.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_notification_availability_provider.g.dart';

@riverpod
Future<bool> isShakeDetectionNotificationAvailable(Ref ref) async {
  if (ref.watch(buildConfigProvider).isShakeDetectionAvailable) {
    return true;
  }
  if (!await ref.watch(debugProvider.future)) {
    return false;
  }
  final role = await ref.watch(deviceRoleProvider.future);
  // 権限取得失敗を無効とみなして、保存済みの通知条件を停止しない。
  if (role == null) {
    throw StateError('Device role is unavailable');
  }
  return role == DeviceRole.admin;
}
