import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/model/notification_permission_kind.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/dialog/notification_permission_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class NotificationPermissionWarningCard extends ConsumerWidget {
  const new({required this.requiresCriticalAlert, super.key});

  final bool requiresCriticalAlert;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionAsync = ref.watch(osNotificationPermissionProvider);
    if (permissionAsync case AsyncData(:final value)) {
      final missing = const NotificationPermissionPolicy().missing(
        permission: value,
        requiresCriticalAlert: requiresCriticalAlert,
      );
      if (missing.isEmpty) {
        return const SizedBox.shrink();
      }
      final designSystem = context.designSystem;
      final spacing = designSystem.spacing;
      final pending = ref
          .watch(NotificationPermissionDialogAction.requestMutation)
          .isPending;
      return Card.outlined(
        margin: EdgeInsets.fromLTRB(spacing.lg, 0, spacing.lg, spacing.md),
        color: designSystem.colorTheme.surfaceContainerHigh,
        child: Padding(
          padding: EdgeInsets.all(spacing.lg),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    color: designSystem.colorTheme.error,
                  ),
                  SizedBox(width: spacing.sm),
                  Expanded(
                    child: Text(
                      '通知に必要な権限が不足しています',
                      style: designSystem.typography.titleMedium,
                    ),
                  ),
                ],
              ),
              for (final kind in missing) ...[
                SizedBox(height: spacing.sm),
                Text(kind.explanation),
              ],
              SizedBox(height: spacing.md),
              M3EFilledButton(
                onPressed: pending
                    ? null
                    : () async => ref
                          .read(notificationPermissionDialogActionProvider)
                          .showMissingPermissions(
                            context: context,
                            ref: ref,
                            requiresCriticalAlert: requiresCriticalAlert,
                          ),
                child: const Text('権限を確認する'),
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class NotificationPermissionSettings extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permission = ref.watch(osNotificationPermissionProvider);
    final pending = ref
        .watch(NotificationPermissionDialogAction.requestMutation)
        .isPending;
    final action = ref.read(notificationPermissionDialogActionProvider);
    return Column(
      mainAxisSize: .min,
      children: [
        permission.when(
          data: (value) => Column(
            mainAxisSize: .min,
            children: [
              _PermissionTile(
                kind: .notification,
                permission: value,
                enabled: !pending,
              ),
              if (value.isCriticalAlertSupported)
                _PermissionTile(
                  kind: .criticalAlert,
                  permission: value,
                  enabled: !pending,
                ),
            ],
          ),
          loading: () => const ListTile(
            title: Text('通知の許可'),
            subtitle: Text('権限を確認しています…'),
          ),
          error: (error, stackTrace) => ErrorCard(
            error: error,
            stackTrace: stackTrace,
            title: '通知の権限を確認できませんでした',
            showContact: false,
            showLoadingOverlayOnReload: false,
            onReload: () async {
              ref.invalidate(osNotificationPermissionProvider);
            },
          ),
        ),
        ListTile(
          title: const Text('端末の通知設定を開く'),
          subtitle: Text(
            Theme.of(context).platform == .android
                ? '通知の許可やチャンネルごとの音・バイブを変更できます'
                : '通知の許可や表示方法・サウンドを変更できます',
          ),
          leading: const Icon(Icons.settings_outlined),
          trailing: const Icon(Icons.open_in_new),
          enabled: !pending,
          onTap: () async => action.openSettings(context: context, ref: ref),
        ),
      ],
    );
  }
}

class _PermissionTile extends ConsumerWidget {
  const new({
    required this.kind,
    required this.permission,
    required this.enabled,
  });

  final NotificationPermissionKind kind;
  final OsNotificationPermission permission;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final granted = kind.isGranted(permission);
    final statusLabel =
        kind == .notification && permission.authorizationStatus == .provisional
        ? '仮許可（通知センターのみ）'
        : granted
        ? '許可済み'
        : '未許可';
    final action = ref.read(notificationPermissionDialogActionProvider);
    return ListTile(
      title: Text('${kind.label}の許可'),
      subtitle: Text(statusLabel),
      leading: Icon(
        granted ? Icons.check_circle_outline : Icons.notifications_off_outlined,
      ),
      trailing: const Icon(Icons.chevron_right),
      enabled: enabled,
      onTap: () async {
        if (granted) {
          await action.openSettings(context: context, ref: ref);
          return;
        }
        await action.showMissingPermissions(
          context: context,
          ref: ref,
          requiresCriticalAlert: kind == .criticalAlert,
        );
      },
    );
  }
}
