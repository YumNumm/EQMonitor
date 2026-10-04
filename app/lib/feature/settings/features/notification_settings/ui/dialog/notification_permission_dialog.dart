import 'package:eqmonitor/core/component/error/error_dialog.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/model/notification_permission_kind.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_permission_dialog.g.dart';

@riverpod
NotificationPermissionDialogAction notificationPermissionDialogAction(
  Ref ref,
) => const NotificationPermissionDialogAction();

class const NotificationPermissionDialogAction() {
  Future<void> showOsPermission(BuildContext context, WidgetRef ref) =>
      showMissingPermissions(
        context: context,
        ref: ref,
        requiresCriticalAlert: false,
      );

  Future<void> showCriticalAlertPermission(
    BuildContext context,
    WidgetRef ref,
  ) => showMissingPermissions(
    context: context,
    ref: ref,
    requiresCriticalAlert: true,
  );

  Future<void> showMissingPermissions({
    required BuildContext context,
    required WidgetRef ref,
    required bool requiresCriticalAlert,
  }) async {
    try {
      final permission = await ref.read(
        osNotificationPermissionProvider.future,
      );
      if (!context.mounted || ModalRoute.of(context)?.isCurrent != true) {
        return;
      }
      final missing = const NotificationPermissionPolicy().missing(
        permission: permission,
        requiresCriticalAlert: requiresCriticalAlert,
      );
      if (missing.isEmpty) {
        return;
      }
      final openSettings =
          permission.authorizationStatus == .deniedPermanently ||
          (permission.authorizationStatus == .denied &&
              (defaultTargetPlatform == .iOS ||
                  defaultTargetPlatform == .macOS));
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => _NotificationPermissionDialog(
          missing: missing,
          primaryActionLabel: openSettings ? '設定を開く' : '許可する',
        ),
      );
      if (confirmed != true || !context.mounted) {
        return;
      }
      await request(
        context: context,
        ref: ref,
        missing: missing,
        openSettings: openSettings,
      );
    } on Object catch (error) {
      if (context.mounted) {
        await ref.read(errorDialogActionProvider).show(context, error: error);
      }
    }
  }

  static final requestMutation = Mutation<void>();

  Future<void> request({
    required BuildContext context,
    required WidgetRef ref,
    required List<NotificationPermissionKind> missing,
    bool openSettings = false,
  }) async {
    if (ref.read(requestMutation).isPending) {
      return;
    }
    await requestMutation.run(ref, (transaction) async {
      final repository = transaction.get(permissionRepositoryProvider);
      if (openSettings) {
        await repository.openNotificationSettings();
        return;
      }
      if (missing.contains(NotificationPermissionKind.notification)) {
        final granted = await repository.requestNotificationPermission();
        if (!granted) {
          return;
        }
      }
      if (missing.contains(NotificationPermissionKind.criticalAlert)) {
        final granted = await repository.requestCriticalAlertPermission();
        if (!granted) {
          await repository.openNotificationSettings();
        }
      }
    });
    if (!context.mounted) {
      return;
    }
    ref.invalidate(osNotificationPermissionProvider);
    final result = ref.read(requestMutation);
    if (result is MutationError) {
      await ref
          .read(errorDialogActionProvider)
          .show(context, error: result.error);
    }
  }

  Future<void> openSettings({
    required BuildContext context,
    required WidgetRef ref,
  }) => request(
    context: context,
    ref: ref,
    missing: const [],
    openSettings: true,
  );
}

class _NotificationPermissionDialog extends StatelessWidget {
  const new({required this.missing, required this.primaryActionLabel});

  final List<NotificationPermissionKind> missing;
  final String primaryActionLabel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
        missing.length == 1
            ? '${missing.single.label}の許可が不足しています'
            : '通知に必要な権限が不足しています',
      ),
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          for (var index = 0; index < missing.length; index++) ...[
            if (index > 0) const SizedBox(height: 16),
            if (missing.length > 1)
              Text(
                missing[index].label,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            Text(missing[index].explanation),
          ],
        ],
      ),
      actions: [
        M3ETextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('あとで'),
        ),
        M3EFilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(primaryActionLabel),
        ),
      ],
    );
  }
}
