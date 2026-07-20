import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_force_resync_result.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_device_lifecycle_flow.g.dart';

@riverpod
DebugDeviceLifecycleFlow debugDeviceLifecycleFlow(Ref ref) =>
    DebugDeviceLifecycleFlow();

class DebugDeviceLifecycleFlow {
  DebugDeviceLifecycleFlow({
    DebugDeviceLifecycleMessages? messages,
    DebugDeviceLifecycleConfirmDialog? confirmDialog,
  }) : messages = messages ?? DebugDeviceLifecycleMessages(),
       confirmDialog = confirmDialog ?? DebugDeviceLifecycleConfirmDialog();

  final DebugDeviceLifecycleMessages messages;
  final DebugDeviceLifecycleConfirmDialog confirmDialog;

  Future<void> confirmAndDelete(WidgetRef ref, BuildContext context) async {
    final confirmed = await confirmDialog.show(
      context: context,
      title: 'デバイスを削除',
      content: 'サーバー上のデバイスとローカル認証情報を削除します。よろしいですか？',
      confirmLabel: '削除',
      isDestructive: true,
    );
    if (confirmed == false || context.mounted == false) {
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    try {
      await DeviceProvisioningNotifier.deleteMutation.run(
        ref,
        (tsx) async => tsx
            .get(deviceProvisioningProvider.notifier)
            .deleteDeviceAndClearLocal(),
      );
      if (context.mounted == false) {
        return;
      }
      messenger.showSnackBar(const SnackBar(content: Text('デバイスを削除しました')));
    } on Object catch (error) {
      if (context.mounted == false) {
        return;
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text(messages.errorMessage(error)),
          backgroundColor: context.designSystem.colorTheme.error,
        ),
      );
      rethrow;
    }
  }

  Future<void> confirmAndReprovision(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final confirmed = await confirmDialog.show(
      context: context,
      title: '再プロビジョニング',
      content: '削除してから再登録します。通知トークンも再同期されます。よろしいですか？',
      confirmLabel: '実行',
      isDestructive: true,
    );
    if (confirmed == false || context.mounted == false) {
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    try {
      await DeviceProvisioningNotifier.reprovisionMutation.run(
        ref,
        (tsx) async =>
            tsx.get(deviceProvisioningProvider.notifier).reprovision(),
      );
      if (context.mounted == false) {
        return;
      }
      messenger.showSnackBar(const SnackBar(content: Text('再プロビジョニングが完了しました')));
    } on Object catch (error) {
      if (context.mounted == false) {
        return;
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text(messages.errorMessage(error)),
          backgroundColor: context.designSystem.colorTheme.error,
        ),
      );
      rethrow;
    }
  }

  Future<void> forceResyncToken(
    WidgetRef ref,
    BuildContext context, {
    required PushTokenKind kind,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final result = await PushTokenSyncNotifier.forceResyncMutation.run(
        ref,
        (tsx) async =>
            tsx.get(pushTokenSyncProvider.notifier).forceResync(kind: kind),
      );
      if (context.mounted == false) {
        return;
      }
      final message = switch (result) {
        PushTokenForceResyncResult.started =>
          '${messages.kindLabel(kind)} の再送信を開始しました',
        PushTokenForceResyncResult.tokenAbsent => 'トークン未取得のため再送信できません',
        PushTokenForceResyncResult.notApplicable =>
          '${messages.kindLabel(kind)} はこの端末では非対応です',
      };
      messenger.showSnackBar(SnackBar(content: Text(message)));
    } on Object catch (error) {
      if (context.mounted == false) {
        return;
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text(messages.errorMessage(error)),
          backgroundColor: context.designSystem.colorTheme.error,
        ),
      );
      rethrow;
    }
  }
}

class DebugDeviceLifecycleMessages {
  String errorMessage(Object error) {
    if (error is DeviceProvisioningException) {
      return error.userMessage;
    }
    return error.toString();
  }

  String kindLabel(PushTokenKind kind) => switch (kind) {
    PushTokenKind.fcm => 'FCM',
    PushTokenKind.apnsNotification => 'APNs（通知）',
    PushTokenKind.apnsPushToStart => 'Push to Start',
  };
}

class DebugDeviceLifecycleConfirmDialog {
  Future<bool> show({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmLabel,
    required bool isDestructive,
  }) async {
    final confirmed = await showAdaptiveDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: isDestructive
                ? TextButton.styleFrom(
                    foregroundColor:
                        dialogContext.designSystem.colorTheme.error,
                  )
                : null,
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }
}
