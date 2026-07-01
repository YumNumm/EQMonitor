import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/flow/slot_update_action.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EarthquakeInfoSettingsPage extends HookConsumerWidget {
  const EarthquakeInfoSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalEnabled = ref.watch(
      earthquakeGlobalSettingsProvider.select((s) => s.value?.enabled ?? true),
    );
    final slotsAsync = ref.watch(notificationSlotsProvider);
    final slots = [...?slotsAsync.value]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    ref.listen(
      EarthquakeGlobalSettingsNotifier.updateSettingsMutation,
      (_, next) async {
        if (next is MutationError && context.mounted) {
          await showNotificationSettingsErrorDialog(
            context: context,
            error: next.error,
            errorMessageBuilder: ref.read(errorMessageBuilderProvider),
          );
        }
      },
    );
    ref.listen(NotificationSlotsNotifier.putCurrentLocationMutation, (_, next) async {
      if (next is MutationError && context.mounted) {
        await showNotificationSettingsErrorDialog(
          context: context,
          error: next.error,
          errorMessageBuilder: ref.read(errorMessageBuilderProvider),
        );
      }
    });
    ref.listen(NotificationSlotsNotifier.putNationwideMutation, (_, next) async {
      if (next is MutationError && context.mounted) {
        await showNotificationSettingsErrorDialog(
          context: context,
          error: next.error,
          errorMessageBuilder: ref.read(errorMessageBuilderProvider),
        );
      }
    });
    ref.listen(NotificationSlotsNotifier.updateRegionMutation, (_, next) async {
      if (next is MutationError && context.mounted) {
        await showNotificationSettingsErrorDialog(
          context: context,
          error: next.error,
          errorMessageBuilder: ref.read(errorMessageBuilderProvider),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('地震情報')),
      body: Skeletonizer(
        enabled: slotsAsync.isLoading,
        child: ListView(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          children: [
            _MasterEarthquakeControl(
              value: globalEnabled,
              onChanged: (value) async {
                await EarthquakeGlobalSettingsNotifier.updateSettingsMutation
                    .run(
                  ref,
                  (tsx) async {
                    await tsx
                        .get(earthquakeGlobalSettingsProvider.notifier)
                        .updateSettings(enabled: value);
                  },
                );
              },
            ),
            const SettingsSectionHeader(text: '地域ごとの最小震度'),
            for (final slot in slots)
              _SlotEarthquakeTile(
                slot: slot,
                enabled: globalEnabled,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                '各地域の詳細設定は、通知地域から変更できます',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MasterEarthquakeControl extends StatelessWidget {
  const _MasterEarthquakeControl({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final typography = designSystem.typography;

    return Padding(
      padding: EdgeInsets.fromLTRB(spacing.lg, 0, spacing.lg, spacing.lg),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(shape.pill),
          onTap: () => onChanged(!value),
          child: Ink(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.lg,
              vertical: spacing.md,
            ),
            decoration: BoxDecoration(
              color: value ? color.surfaceEmphasis : color.surfaceCard,
              borderRadius: BorderRadius.circular(shape.pill),
              border: Border.all(color: color.outlineSoft),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '通知を受け取る',
                    style: typography.titleMedium.copyWith(
                      color: designSystem.textColor.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                AppSwitch(value: value, onChanged: onChanged),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SlotEarthquakeTile extends ConsumerWidget {
  const _SlotEarthquakeTile({
    required this.slot,
    required this.enabled,
  });

  final NotificationSlot slot;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (icon, name) = switch (slot.slotType) {
      NotificationSlotType.currentLocation => ('📍', '現在地'),
      NotificationSlotType.nationwide => ('🌐', '全国'),
      NotificationSlotType.region => (
        '📍',
        slot.cityName != null
            ? '${slot.regionName ?? "地域"} ${slot.cityName}'
            : slot.regionName ?? '地域',
      ),
    };

    return ListTile(
      leading: Text(icon, style: const TextStyle(fontSize: 20)),
      title: Text(name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _IntensityDropdown(
            value: slot.earthquakeMinIntensity,
            enabled: enabled,
            onChanged: (intensity) async {
              await ref.read(slotUpdateActionProvider).execute(
                ref,
                slot,
                earthquakeMinIntensity: intensity,
              );
            },
          ),
          const SizedBox(width: 8),
          AppSwitch(
            value: slot.earthquakeEnabled,
            onChanged: enabled
                ? (value) async {
                    await ref.read(slotUpdateActionProvider).execute(
                      ref,
                      slot,
                      earthquakeEnabled: value,
                    );
                  }
                : null,
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
      width: 110,
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
