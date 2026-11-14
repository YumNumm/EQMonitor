import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/current_location_permission_action.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/current_location_permission_missing_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class CurrentLocationPermissionWarningCard extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(isCurrentLocationPermissionMissingProvider)) {
      return const SizedBox.shrink();
    }
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final isForegroundOnly =
        ref.watch(backgroundLocationPermissionProvider).value ==
        LocationPermission.whileInUse;
    final pending = ref
        .watch(CurrentLocationPermissionAction.requestMutation)
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
                  Icons.location_off_outlined,
                  color: designSystem.colorTheme.error,
                ),
                SizedBox(width: spacing.sm),
                Expanded(
                  child: Text(
                    '現在地の通知に必要な権限が不足しています',
                    style: designSystem.typography.titleMedium,
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing.sm),
            Text(
              isForegroundOnly
                  ? '現在地の通知が設定されていますが、位置情報が「常に許可」になっていません。'
                        'アプリを開いていない間は現在地を更新できません。'
                  : '現在地の通知が設定されていますが、位置情報が許可されていません。'
                        '現在地に基づく通知は届きません。',
            ),
            SizedBox(height: spacing.md),
            M3EFilledButton(
              onPressed: pending
                  ? null
                  : () async =>
                        const CurrentLocationPermissionAction().request(ref),
              child: const Text('位置情報を許可する'),
            ),
          ],
        ),
      ),
    );
  }
}
