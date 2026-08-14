import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notificationPermissionDialogActionProvider = Provider(
  (ref) => const NotificationPermissionDialogAction(),
);

/// OS 通知権限・重大な通知権限が無効なときの案内ダイアログ表示を担う。
class NotificationPermissionDialogAction {
  const NotificationPermissionDialogAction();

  Future<void> showOsPermission(BuildContext context, WidgetRef ref) async {
    final permission = await ref.read(osNotificationPermissionProvider.future);
    if (!context.mounted) {
      return;
    }

    final openSettings =
        _NotificationPermissionDialogPolicy.shouldOpenSettingsForOs(
          permission: permission,
        );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => _NotificationPermissionDialog(
        title: '通知権限が無効です',
        body: '通知を受け取るには、通知の許可が必要です。許可しますか？',
        primaryActionLabel: openSettings ? '設定を開く' : '許可する',
        onPrimaryAction: () async {
          Navigator.of(dialogContext).pop();
          if (openSettings) {
            await Geolocator.openAppSettings();
            return;
          }
          await _NotificationPermissionRequester.requestAndRefresh(ref: ref);
        },
      ),
    );
  }

  Future<void> showCriticalAlertPermission(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final permission = await ref.read(osNotificationPermissionProvider.future);
    if (!context.mounted) {
      return;
    }

    final openSettings =
        _NotificationPermissionDialogPolicy.shouldOpenSettingsForCriticalAlert(
          permission: permission,
        );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => _NotificationPermissionDialog(
        title: '重大な通知が許可されていません',
        body: '緊急地震速報(警報)を確実に受け取るには、重大な通知の許可が必要です。許可しますか？',
        primaryActionLabel: openSettings ? '設定を開く' : '許可する',
        onPrimaryAction: () async {
          Navigator.of(dialogContext).pop();
          if (openSettings) {
            await Geolocator.openAppSettings();
            return;
          }
          await _NotificationPermissionRequester.requestAndRefresh(ref: ref);
        },
      ),
    );
  }
}

class _NotificationPermissionDialogPolicy {
  static bool shouldOpenSettingsForOs({
    required OsNotificationPermission permission,
  }) {
    return permission.authorizationStatus == AuthorizationStatus.denied &&
        _isApplePlatform;
  }

  static bool shouldOpenSettingsForCriticalAlert({
    required OsNotificationPermission permission,
  }) {
    if (!permission.isCriticalAlertSupported ||
        permission.isCriticalAlertGranted) {
      return false;
    }

    return permission.isOsNotificationGranted && _isApplePlatform;
  }

  static bool get _isApplePlatform =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS;
}

class _NotificationPermissionRequester {
  static Future<void> requestAndRefresh({required WidgetRef ref}) async {
    final messaging = ref.read(firebaseMessagingProvider);
    await messaging.requestPermission(criticalAlert: true);
    ref.invalidate(osNotificationPermissionProvider);
  }
}

class _NotificationPermissionDialog extends StatelessWidget {
  const _NotificationPermissionDialog({
    required this.title,
    required this.body,
    required this.primaryActionLabel,
    required this.onPrimaryAction,
  });

  final String title;
  final String body;
  final String primaryActionLabel;
  final Future<void> Function() onPrimaryAction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
        FilledButton(
          onPressed: () async => onPrimaryAction(),
          child: Text(primaryActionLabel),
        ),
      ],
    );
  }
}
