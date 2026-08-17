import 'package:eqmonitor/core/component/error/error_dialog.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/flow/eew_warning_settings_action.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/flow/slot_update_action.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_kind.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_warning_config_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_min_intensity_field.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_feature_widgets.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_upgrade_dialog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/override_edit_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class SlotDetailPage extends HookConsumerWidget {
  const new({required this.slotId, required this.isPro, super.key});

  final String slotId;
  final bool isPro;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slot = ref.watch(
      notificationSlotsProvider.select(
        (v) => v.value?.where((s) => s.id == slotId).firstOrNull,
      ),
    );
    final warningEnabled = ref.watch(
      eewGlobalSettingsProvider.select((s) => s.value?.warningEnabled ?? true),
    );
    final warningTarget = ref.watch(eewWarningConfigProvider).value?.target;

    void listenMutationError(Mutation<void> mutation) {
      ref.listen(mutation, (_, next) async {
        if (next is MutationError && context.mounted) {
          await ref
              .read(errorDialogActionProvider)
              .show(context, error: next.error);
        }
      });
    }

    listenMutationError(NotificationSlotsNotifier.putCurrentLocationMutation);
    listenMutationError(NotificationSlotsNotifier.putNationwideMutation);
    listenMutationError(NotificationSlotsNotifier.updateRegionMutation);
    listenMutationError(NotificationSlotsNotifier.removeRegionMutation);
    listenMutationError(EewGlobalSettingsNotifier.updateSettingsMutation);
    listenMutationError(EewWarningConfigNotifier.updateConfigMutation);

    final String title;
    if (slot == null) {
      title = '通知設定';
    } else {
      final slotName = switch (slot.slotType) {
        NotificationSlotType.region => slot.regionName ?? slot.slotType.label,
        _ => slot.slotType.label,
      };
      title = '$slotNameの通知設定';
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: slot == null
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ListView(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
              children: [
                const SettingsSectionHeader(text: '緊急地震速報（予報）'),
                _NotificationConditionCard(
                  slotType: slot.slotType,
                  kind: NotificationKind.eew,
                  enabled: slot.eewEnabled,
                  minIntensity: slot.eewMinIntensity,
                  isPro: isPro,
                  overrides: slot.eewOverrides ?? [],
                  onEnabledChanged: (next) => ref
                      .read(slotUpdateActionProvider)
                      .execute(ref, slot, eewEnabled: next),
                  onMinIntensityChanged: (next) => ref
                      .read(slotUpdateActionProvider)
                      .execute(ref, slot, eewMinIntensity: next),
                  onOverrideTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => OverrideEditPage(
                        slotId: slot.id,
                        slotType: slot.slotType,
                        overrideType: NotificationKind.eew,
                        currentOverrides: slot.eewOverrides ?? [],
                      ),
                    ),
                  ),
                ),
                if (slot.slotType != NotificationSlotType.region) ...[
                  const SettingsSectionHeader(text: '緊急地震速報（警報）'),
                  _WarningSettingsCard(
                    enabled:
                        slot.slotType == NotificationSlotType.currentLocation
                        ? warningEnabled
                        : warningTarget ==
                              EewWarningTarget.currentLocationAndNationwide,
                    onChanged: (next) async {
                      switch (slot.slotType) {
                        case NotificationSlotType.currentLocation:
                          await ref
                              .read(eewWarningSettingsActionProvider)
                              .updateCurrentLocation(ref, enabled: next);
                        case NotificationSlotType.nationwide:
                          await ref
                              .read(eewWarningSettingsActionProvider)
                              .updateNationwide(ref, enabled: next);
                        case NotificationSlotType.region:
                          return;
                      }
                    },
                  ),
                ],
                const SettingsSectionHeader(text: '地震情報'),
                _NotificationConditionCard(
                  slotType: slot.slotType,
                  kind: NotificationKind.earthquake,
                  enabled: slot.earthquakeEnabled,
                  minIntensity: slot.earthquakeMinIntensity,
                  isPro: isPro,
                  overrides: slot.earthquakeOverrides ?? [],
                  onEnabledChanged: (next) => ref
                      .read(slotUpdateActionProvider)
                      .execute(ref, slot, earthquakeEnabled: next),
                  onMinIntensityChanged: (next) => ref
                      .read(slotUpdateActionProvider)
                      .execute(ref, slot, earthquakeMinIntensity: next),
                  onOverrideTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => OverrideEditPage(
                        slotId: slot.id,
                        slotType: slot.slotType,
                        overrideType: NotificationKind.earthquake,
                        currentOverrides: slot.earthquakeOverrides ?? [],
                      ),
                    ),
                  ),
                ),
                if (slot.slotType == NotificationSlotType.region) ...[
                  const SettingsSectionHeader(text: '削除'),
                  _DeleteRegionTile(
                    onTap: () async {
                      final navigator = Navigator.of(context);
                      try {
                        await NotificationSlotsNotifier.removeRegionMutation
                            .run(ref, (tsx) async {
                              await tsx
                                  .get(notificationSlotsProvider.notifier)
                                  .removeRegion(slotId: slot.id);
                            });
                      } on Object {
                        return;
                      }
                      navigator.pop();
                    },
                  ),
                ],
              ],
            ),
    );
  }
}

extension NotificationSlotTypeLabel on NotificationSlotType {
  String get label => switch (this) {
    .currentLocation => '現在地',
    .nationwide => '全国',
    .region => '地域',
  };
}

class _NotificationConditionCard extends StatelessWidget {
  const new({
    required this.slotType,
    required this.kind,
    required this.enabled,
    required this.minIntensity,
    required this.isPro,
    required this.overrides,
    required this.onEnabledChanged,
    required this.onMinIntensityChanged,
    required this.onOverrideTap,
  });

  final NotificationSlotType slotType;
  final NotificationKind kind;
  final bool enabled;
  final JmaIntensity? minIntensity;
  final bool isPro;
  final List<NotificationOverride> overrides;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<JmaIntensity> onMinIntensityChanged;
  final VoidCallback onOverrideTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    return Card.outlined(
      margin: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.sm,
        spacing.lg,
        spacing.md,
      ),
      color: colorTheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('有効'),
            trailing: AppSwitch(value: enabled, onChanged: onEnabledChanged),
            onTap: () => onEnabledChanged(!enabled),
          ),
          const Divider(height: 1),
          ListTile(
            enabled: enabled,
            title: const Text('最小震度'),
            trailing: NotificationMinIntensityField(
              slotType: slotType,
              kind: kind,
              value: minIntensity,
              enabled: enabled,
              onChanged: onMinIntensityChanged,
            ),
          ),
          const Divider(height: 1),
          if (isPro)
            ListTile(
              title: const Text('震度別設定'),
              subtitle: overrides.isEmpty
                  ? const Text('震度ごとに通知をオーバーライドできます')
                  : Text('${overrides.length}件の設定'),
              trailing: const Icon(Icons.chevron_right),
              onTap: onOverrideTap,
            )
          else
            LockedSettingTile(
              title: '震度別設定',
              subtitle: 'Proで利用できます',
              locked: true,
              onTap: () async => const ProUpgradeDialogAction().show(context),
            ),
        ],
      ),
    );
  }
}

class _WarningSettingsCard extends StatelessWidget {
  const new({required this.enabled, required this.onChanged});

  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    return Card.outlined(
      margin: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.sm,
        spacing.lg,
        spacing.md,
      ),
      color: colorTheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('有効'),
            trailing: AppSwitch(value: enabled, onChanged: onChanged),
            onTap: () => onChanged(!enabled),
          ),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(spacing.md),
            child: Text(
              '緊急地震速報（警報）は、現在地や全国を対象に重大な通知として配信されます。',
              style: designSystem.typography.bodySmall.copyWith(
                color: colorTheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeleteRegionTile extends StatelessWidget {
  const new({required this.onTap});

  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;

    return ListTile(
      leading: Icon(Icons.delete_outline, color: colorTheme.error),
      title: Text('この地域を削除', style: TextStyle(color: colorTheme.error)),
      onTap: onTap,
    );
  }
}
