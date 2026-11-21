import 'package:eqmonitor/core/component/chip/beta_chip.dart';
import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/shake_detection_settings_action.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/flow/shake_detection_enable_flow.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/shake_detection_slot_entry_resolver.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_notification_access_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/shake_detection_notification_detail_sheet.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/shake_detection_notification_min_level_dropdown.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class const ShakeDetectionSlotSection({
  required final NotificationSlot slot,
  super.key,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final access = ref.watch(shakeDetectionNotificationAccessProvider);
    if (access == .hidden ||
        !const ShakeDetectionSlotEntryResolver().isConfigurable(slot)) {
      return const SizedBox.shrink();
    }

    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;

    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        const SettingsSectionHeader(text: '揺れ検知', trailing: BetaChip()),
        Card.outlined(
          margin: EdgeInsets.fromLTRB(
            spacing.lg,
            spacing.sm,
            spacing.lg,
            spacing.md,
          ),
          color: colorTheme.surfaceContainerHigh,
          clipBehavior: .antiAlias,
          elevation: 0,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(designSystem.shape.card),
            side: BorderSide(color: colorTheme.outlineVariant),
          ),
          child: Column(
            mainAxisSize: .min,
            children: [
              _ShakeDetectionCondition(slot: slot),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('注意事項'),
                subtitle: const Text('揺れ検知の通知を利用する前にご確認ください'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async =>
                    const ShakeDetectionNotificationDetailSheetAction().show(
                      context,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class const _ShakeDetectionCondition({required final NotificationSlot slot})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final settings = ref.watch(shakeDetectionSettingsProvider);
    final isSaving = ref.watch(
      ShakeDetectionSettingsNotifier.saveMutation,
    ) is MutationPending;
    final state = settings.hasError ? null : settings.value;

    if (state == null) {
      return settings.hasError && !settings.isLoading
          ? ListTile(
              title: const Text('揺れ検知の設定を読み込めませんでした'),
              trailing: M3ETextButton(
                onPressed: () => ref.invalidate(shakeDetectionSettingsProvider),
                child: const Text('再試行'),
              ),
            )
          : Padding(
              padding: EdgeInsets.all(designSystem.spacing.lg),
              child: const Center(child: AccessibleCircularProgressIndicator()),
            );
    }

    const resolver = ShakeDetectionSlotEntryResolver();
    const action = ShakeDetectionSettingsAction();
    const enableFlow = ShakeDetectionEnableFlow();
    final entry = resolver.find(entries: state.entries, slot: slot);
    final enabled = entry?.enabled ?? false;
    final minLevel =
        entry?.minLevel ?? ShakeDetectionSlotEntryResolver.defaultMinLevel;
    final busy = settings.isLoading || isSaving;
    final isLocationPermissionMissing =
        slot.slotType == .currentLocation &&
        ref.watch(backgroundLocationPermissionProvider).value !=
            LocationPermission.always;
    final isSelectable = enabled || !isLocationPermissionMissing;

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        if (busy) const AccessibleLinearProgressIndicator(),
        ListTile(
          enabled: !busy,
          title: const Text('有効'),
          subtitle: isSelectable ? null : const Text('位置情報を「常に許可」にすると選択できます'),
          trailing: AppSwitch(
            value: enabled,
            onChanged: busy || !isSelectable
                ? null
                : (next) => enableFlow.setSlotEnabled(
                    ref: ref,
                    context: context,
                    slot: slot,
                    enabled: next,
                  ),
          ),
          onTap: () => enableFlow.setSlotEnabled(
            ref: ref,
            context: context,
            slot: slot,
            enabled: !enabled,
          ),
        ),
        const Divider(height: 1),
        ListTile(
          enabled: enabled && !busy,
          title: const Text('最小レベル'),
          subtitle: Padding(
            padding: EdgeInsets.only(top: designSystem.spacing.sm),
            child: ShakeDetectionNotificationMinLevelDropdown(
              minLevel: minLevel,
              enabled: enabled && !busy,
              onChanged: (next) =>
                  action.updateSlot(ref, slot: slot, minLevel: next),
            ),
          ),
        ),
      ],
    );
  }
}
