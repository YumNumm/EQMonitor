import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/notification_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/notifier/notification_permission_banner_dismissed_notifier.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 通知権限が未許可の場合にホームシートへ表示するバナー。
/// タップで許可要求 → まだ未許可なら OS 設定を開く。閉じるボタンで dismiss。
class NotificationPermissionBanner extends ConsumerWidget {
  const NotificationPermissionBanner({required this.bottomSpacing, super.key});

  final double bottomSpacing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permission = ref.watch(isNotificationPermissionGrantedProvider);
    final granted = permission.when(
      data: (value) => value,
      error: (_, _) => false,
      loading: () => true,
    );
    final dismissed =
        ref.watch(notificationPermissionBannerDismissedProvider).value ?? false;
    if (granted || dismissed) {
      return const SizedBox.shrink();
    }

    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final title = permission.hasError ? '通知権限の状態を確認できません' : '通知が許可されていません';
    final message = permission.hasError
        ? '通知設定を確認してから、もう一度お試しください'
        : '緊急地震速報などの通知を受け取るには通知を許可してください';

    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Material(
        color: colorTheme.primaryContainer,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(designSystem.shape.card),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.md,
            vertical: spacing.sm,
          ),
          child: Row(
            spacing: spacing.md,
            children: [
              Icon(
                Icons.notifications_off_rounded,
                color: colorTheme.onPrimaryContainer,
                size: 24,
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final ok = await ref
                        .read(permissionRepositoryProvider)
                        .requestNotificationPermission();
                    ref.invalidate(osNotificationPermissionProvider);
                    if (!ok) {
                      await AppSettings.openAppSettings(
                        type: AppSettingsType.notification,
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: colorTheme.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        message,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorTheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: colorTheme.onPrimaryContainer,
                  size: 20,
                ),
                tooltip: '閉じる',
                onPressed: () => unawaited(
                  ref
                      .read(
                        notificationPermissionBannerDismissedProvider.notifier,
                      )
                      .dismiss(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
