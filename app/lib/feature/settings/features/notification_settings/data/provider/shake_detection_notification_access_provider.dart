import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_notification_access.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/notification_plan_constraints_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_notification_availability_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_notification_access_provider.g.dart';

@riverpod
ShakeDetectionNotificationAccess shakeDetectionNotificationAccess(Ref ref) {
  final isAvailable =
      ref.watch(isShakeDetectionNotificationAvailableProvider).value ?? false;
  if (!isAvailable) {
    return .hidden;
  }
  final plan = ref.watch(notificationPlanConstraintsProvider).value;
  if (plan == null) {
    return .hidden;
  }
  return plan.shakeDetection ? .editable : .locked;
}
