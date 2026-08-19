import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery_result.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_notification_send_action.g.dart';

@riverpod
TestNotificationSendAction testNotificationSendAction(Ref ref) =>
    const TestNotificationSendAction();

class TestNotificationSendAction {
  const new();

  Future<bool> handle({
    required WidgetRef ref,
    required BuildContext context,
    required TestNotificationKind kind,
    VoidCallback? onConfirmed,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    if (kind == TestNotificationKind.critical) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('重大な通知を送信しますか？'),
          content: const Text(
            '重大な通知は、端末のマナーモードの設定に関わらず音が鳴ります。'
            '周囲の状況を確認してから送信してください。',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('キャンセル'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('送信する'),
            ),
          ],
        ),
      );
      if (confirmed != true) {
        return false;
      }
      onConfirmed?.call();
    }

    try {
      final deviceId = await ref.read(deviceIdProvider.future);
      final repository = await ref.read(
        pushNotificationRepositoryProvider.future,
      );
      final result = await repository.sendTestNotification(
        deviceId: deviceId,
        kind: kind,
      );
      if (!context.mounted) {
        return true;
      }
      switch (result) {
        case Success(:final value):
          messenger.showSnackBar(
            SnackBar(
              content: Text(
                '送信しました（${value.framework.displayLabel}）: ${value.message}',
              ),
            ),
          );
        case Failure(:final exception):
          messenger.showSnackBar(
            SnackBar(
              content: Text('送信に失敗しました: $exception'),
              backgroundColor: context.designSystem.colorTheme.error,
            ),
          );
      }
    } catch (exception) {
      if (context.mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text('送信に失敗しました: $exception'),
            backgroundColor: context.designSystem.colorTheme.error,
          ),
        );
      }
    }
    return true;
  }
}
