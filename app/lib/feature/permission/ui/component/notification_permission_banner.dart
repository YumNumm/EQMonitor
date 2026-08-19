import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:eqmonitor/core/component/banner/app_banner.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/permission/data/notification_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/notifier/notification_permission_banner_dismissed_notifier.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 通知権限が未許可の場合にホームシートへ表示するバナー。
/// タップで許可要求 → まだ未許可なら OS 設定を開く。閉じるボタンで dismiss。
class NotificationPermissionBanner extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final granted =
        ref.watch(isNotificationPermissionGrantedProvider).value ?? true;
    final dismissed =
        ref.watch(notificationPermissionBannerDismissedProvider).value ?? false;
    if (granted || dismissed) {
      return const SizedBox.shrink();
    }

    final colorTheme = context.designSystem.colorTheme;

    return AppBanner(
      icon: Icons.notifications_off_rounded,
      title: '通知が許可されていません',
      description: '緊急地震速報などの通知を受け取るには通知を許可してください',
      backgroundColor: colorTheme.primaryContainer,
      foregroundColor: colorTheme.onPrimaryContainer,
      onTap: () async {
        final ok = await ref
            .read(permissionRepositoryProvider)
            .requestNotificationPermission();
        ref.invalidate(isNotificationPermissionGrantedProvider);
        if (!ok) {
          await AppSettings.openAppSettings(type: AppSettingsType.notification);
        }
      },
      onDismiss: () => unawaited(
        ref
            .read(notificationPermissionBannerDismissedProvider.notifier)
            .dismiss(),
      ),
    );
  }
}
