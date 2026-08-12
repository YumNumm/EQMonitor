import 'package:eqmonitor/core/component/error/error_dialog.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/flow/slot_update_action.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_feature_widgets.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_upgrade_dialog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/override_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class SlotDetailPage extends HookConsumerWidget {
  const SlotDetailPage({
    required this.slotId,
    required this.isPro,
    super.key,
  });

  final String slotId;
  final bool isPro;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slot = ref.watch(
      notificationSlotsProvider.select(
        (v) => v.value?.where((s) => s.id == slotId).firstOrNull,
      ),
    );

    void listenMutationError(Mutation<void> mutation) {
      ref.listen(mutation, (_, next) async {
        if (next is MutationError && context.mounted) {
          await showErrorDialog(context, error: next.error);
        }
      });
    }

    listenMutationError(NotificationSlotsNotifier.putCurrentLocationMutation);
    listenMutationError(NotificationSlotsNotifier.putNationwideMutation);
    listenMutationError(NotificationSlotsNotifier.updateRegionMutation);
    listenMutationError(NotificationSlotsNotifier.removeRegionMutation);

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
                        overrideType: OverrideType.eew,
                        currentOverrides: slot.eewOverrides ?? [],
                      ),
                    ),
                  ),
                ),
                const SettingsSectionHeader(text: '地震情報'),
                _NotificationConditionCard(
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
                        overrideType: OverrideType.earthquake,
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
  const _NotificationConditionCard({
    required this.enabled,
    required this.minIntensity,
    required this.isPro,
    required this.overrides,
    required this.onEnabledChanged,
    required this.onMinIntensityChanged,
    required this.onOverrideTap,
  });

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
            trailing: _IntensityDropdown(
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
              onTap: () async => showProUpgradeDialog(context),
            ),
        ],
      ),
    );
  }
}

class _IntensityDropdown extends StatelessWidget {
  const _IntensityDropdown({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final JmaIntensity? value;
  final bool enabled;
  final ValueChanged<JmaIntensity> onChanged;

  @override
  Widget build(BuildContext context) {
    final resolved =
        value != null && JmaIntensity.selectableValues.contains(value)
        ? value
        : JmaIntensity.three;

    return DropdownMenu<JmaIntensity>(
      initialSelection: resolved,
      enabled: enabled,
      requestFocusOnTap: false,
      width: 160,
      onSelected: (next) {
        if (next != null) {
          onChanged(next);
        }
      },
      dropdownMenuEntries: [
        for (final intensity in JmaIntensity.selectableValues)
          DropdownMenuEntry(
            value: intensity,
            label: '震度${intensity.label}',
          ),
      ],
    );
  }
}

class _DeleteRegionTile extends StatelessWidget {
  const _DeleteRegionTile({required this.onTap});

  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;

    return ListTile(
      leading: Icon(Icons.delete_outline, color: colorTheme.error),
      title: Text(
        'この地域を削除',
        style: TextStyle(color: colorTheme.error),
      ),
      onTap: onTap,
    );
  }
}
