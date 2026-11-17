import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_notification_availability_provider.dart';
import 'package:eqmonitor/feature/subscription/data/model/pro_benefit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pro_benefits_provider.g.dart';

/// この端末で案内できる EQMonitor Pro の機能。
///
/// 揺れ検知の通知は、設定画面を表示できる端末にだけ案内する。
@riverpod
List<ProBenefit> proBenefits(Ref ref) {
  final isShakeDetectionNotificationAvailable =
      ref.watch(isShakeDetectionNotificationAvailableProvider).value ?? false;
  return [
    for (final benefit in ProBenefit.values)
      if (benefit != .shakeDetectionNotification ||
          isShakeDetectionNotificationAvailable)
        benefit,
  ];
}
