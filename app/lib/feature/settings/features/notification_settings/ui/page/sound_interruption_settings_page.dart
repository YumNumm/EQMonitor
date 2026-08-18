import 'package:eqmonitor/core/component/error/error_dialog.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class SoundInterruptionSettingsPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eewSettings = ref.watch(eewGlobalSettingsProvider).value;
    final earthquakeSettings = ref
        .watch(earthquakeGlobalSettingsProvider)
        .value;

    ref.listen(EewGlobalSettingsNotifier.updateSettingsMutation, (
      _,
      next,
    ) async {
      if (next is MutationError && context.mounted) {
        await ref
            .read(errorDialogActionProvider)
            .show(context, error: next.error);
      }
    });
    ref.listen(EarthquakeGlobalSettingsNotifier.updateSettingsMutation, (
      _,
      next,
    ) async {
      if (next is MutationError && context.mounted) {
        await ref
            .read(errorDialogActionProvider)
            .show(context, error: next.error);
      }
    });

    final eewSound = NotificationSound.fromApiValue(
      eewSettings?.defaultSound ?? NotificationSound.defaultSound.apiValue,
    );
    final eewLevel =
        eewSettings?.defaultInterruptionLevel ?? InterruptionLevel.active;
    final eewCollapse = eewSettings?.collapseNotification ?? false;

    final earthquakeSound = NotificationSound.fromApiValue(
      earthquakeSettings?.defaultSound ??
          NotificationSound.defaultSound.apiValue,
    );
    final earthquakeLevel =
        earthquakeSettings?.defaultInterruptionLevel ??
        InterruptionLevel.active;
    final earthquakeCollapse =
        earthquakeSettings?.collapseNotification ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('通知音と通知の優先度')),
      body: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        children: [
          const SettingsSectionHeader(text: '緊急地震速報(予報)'),
          _SoundInterruptionCard(
            sound: eewSound,
            interruptionLevel: eewLevel,
            collapseNotification: eewCollapse,
            onSoundChanged: (sound) async {
              await EewGlobalSettingsNotifier.updateSettingsMutation.run(ref, (
                tsx,
              ) async {
                await tsx
                    .get(eewGlobalSettingsProvider.notifier)
                    .updateSettings(defaultSound: sound.apiValue);
              });
            },
            onInterruptionLevelChanged: (level) async {
              await EewGlobalSettingsNotifier.updateSettingsMutation.run(ref, (
                tsx,
              ) async {
                await tsx
                    .get(eewGlobalSettingsProvider.notifier)
                    .updateSettings(defaultInterruptionLevel: level);
              });
            },
            onCollapseChanged: ({required value}) async {
              await EewGlobalSettingsNotifier.updateSettingsMutation.run(ref, (
                tsx,
              ) async {
                await tsx
                    .get(eewGlobalSettingsProvider.notifier)
                    .updateSettings(collapseNotification: value);
              });
            },
          ),
          const SettingsSectionHeader(text: '地震情報'),
          _SoundInterruptionCard(
            sound: earthquakeSound,
            interruptionLevel: earthquakeLevel,
            collapseNotification: earthquakeCollapse,
            onSoundChanged: (sound) async {
              await EarthquakeGlobalSettingsNotifier.updateSettingsMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(earthquakeGlobalSettingsProvider.notifier)
                      .updateSettings(defaultSound: sound.apiValue);
                },
              );
            },
            onInterruptionLevelChanged: (level) async {
              await EarthquakeGlobalSettingsNotifier.updateSettingsMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(earthquakeGlobalSettingsProvider.notifier)
                      .updateSettings(defaultInterruptionLevel: level);
                },
              );
            },
            onCollapseChanged: ({required value}) async {
              await EarthquakeGlobalSettingsNotifier.updateSettingsMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(earthquakeGlobalSettingsProvider.notifier)
                      .updateSettings(collapseNotification: value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SoundInterruptionCard extends StatelessWidget {
  const new({
    required this.sound,
    required this.interruptionLevel,
    required this.collapseNotification,
    required this.onSoundChanged,
    required this.onInterruptionLevelChanged,
    required this.onCollapseChanged,
  });

  final NotificationSound sound;
  final InterruptionLevel interruptionLevel;
  final bool collapseNotification;
  final Future<void> Function(NotificationSound) onSoundChanged;
  final Future<void> Function(InterruptionLevel) onInterruptionLevelChanged;
  final Future<void> Function({required bool value}) onCollapseChanged;

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
      clipBehavior: .antiAlias,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: .circular(shape.card),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          ListTile(
            title: const Text('通知音'),
            trailing: DropdownMenu<NotificationSound>(
              key: ValueKey(sound),
              initialSelection: sound,
              requestFocusOnTap: false,
              onSelected: (selected) async {
                if (selected != null) {
                  await onSoundChanged(selected);
                }
              },
              dropdownMenuEntries:
NotificationSound.values.map((sound) => DropdownMenuEntry(value: sound, label: sound.displayName)).toList(),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('通知の優先度'),
            trailing: DropdownMenu<InterruptionLevel>(
              key: ValueKey(interruptionLevel),
              initialSelection: interruptionLevel,
              requestFocusOnTap: false,
              onSelected: (selected) async {
                if (selected != null) {
                  await onInterruptionLevelChanged(selected);
                }
              },
              dropdownMenuEntries: [
                for (final level in InterruptionLevel.values)
                  DropdownMenuEntry(
                    value: level,
                    label: switch (level) {
                      .passive => 'サイレント',
                      .active => 'デフォルト',
                      .timeSensitive => '即時通知',
                      .critical => '重大な通知',
                    },
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('通知の上書き'),
            subtitle: const Text('緊急地震速報の続報が発表された時に、前の通知を上書きします'),
            trailing: AppSwitch(
              value: collapseNotification,
              onChanged: (value) async => onCollapseChanged(value: value),
            ),
            onTap: () async => onCollapseChanged(value: !collapseNotification),
          ),
        ],
      ),
    );
  }
}
