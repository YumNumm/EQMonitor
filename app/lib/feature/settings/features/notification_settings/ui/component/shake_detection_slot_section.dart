import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/shake_detection_settings_action.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/shake_detection_slot_entry_resolver.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_notification_access.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_notification_access_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_feature_widgets.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_upgrade_dialog.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class ShakeDetectionSlotSection extends ConsumerWidget {
  const new({required this.slot, super.key});

  final NotificationSlot slot;

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
        const SettingsSectionHeader(text: '揺れ検知'),
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
          child: access == ShakeDetectionNotificationAccess.locked
              ? LockedSettingTile(
                  title: '揺れ検知の通知',
                  subtitle: 'Proで利用できます',
                  locked: true,
                  onTap: () async =>
                      const ProUpgradeDialogAction().show(context),
                )
              : _ShakeDetectionCondition(slot: slot),
        ),
      ],
    );
  }
}

class _ShakeDetectionCondition extends ConsumerWidget {
  const new({required this.slot});

  final NotificationSlot slot;

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
                : (next) =>
                      action.setSlotEnabled(ref, slot: slot, enabled: next),
          ),
          onTap: () =>
              action.setSlotEnabled(ref, slot: slot, enabled: !enabled),
        ),
        const Divider(height: 1),
        ListTile(
          enabled: enabled && !busy,
          title: const Text('最小レベル'),
          trailing: SizedBox(
            width: 200,
            child: ControlledDropdown<ShakeDetectionLevel>(
              enabled: enabled && !busy,
              items: [
                for (final level in ShakeDetectionLevel.values)
                  M3EDropdownItem(
                    value: level,
                    label: level.minLevelThresholdLabel,
                    selected: level == minLevel,
                  ),
              ],
              onSelectionChanged: (selectedItems) async {
                final next = selectedItems.firstOrNull?.value;
                if (next == null || next == minLevel) return;
                await action.updateSlot(ref, slot: slot, minLevel: next);
              },
            ),
          ),
        ),
      ],
    );
  }
}
