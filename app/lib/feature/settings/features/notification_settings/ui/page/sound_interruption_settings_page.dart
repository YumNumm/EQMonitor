import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class SoundInterruptionSettingsPage extends HookConsumerWidget {
  const SoundInterruptionSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eewSettings = ref.watch(eewGlobalSettingsProvider).value;
    final earthquakeSettings =
        ref.watch(earthquakeGlobalSettingsProvider).value;

    ref.listen(EewGlobalSettingsNotifier.updateSettingsMutation, (_, next) async {
      if (next is MutationError && context.mounted) {
        await showNotificationSettingsErrorDialog(
          context: context,
          error: next.error,
          errorMessageBuilder: ref.read(errorMessageBuilderProvider),
        );
      }
    });
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
        earthquakeSettings?.defaultInterruptionLevel ?? InterruptionLevel.active;
    final earthquakeCollapse = earthquakeSettings?.collapseNotification ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('通知音・割り込みレベル')),
      body: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        children: [
          const SettingsSectionHeader(text: '緊急地震速報(予報)'),
          _SoundInterruptionCard(
            sound: eewSound,
            interruptionLevel: eewLevel,
            collapseNotification: eewCollapse,
            onSoundChanged: (sound) async {
              await EewGlobalSettingsNotifier.updateSettingsMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(eewGlobalSettingsProvider.notifier)
                      .updateSettings(defaultSound: sound.apiValue);
                },
              );
            },
            onInterruptionLevelChanged: (level) async {
              await EewGlobalSettingsNotifier.updateSettingsMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(eewGlobalSettingsProvider.notifier)
                      .updateSettings(defaultInterruptionLevel: level);
                },
              );
            },
            onCollapseChanged: ({required value}) async {
              await EewGlobalSettingsNotifier.updateSettingsMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(eewGlobalSettingsProvider.notifier)
                      .updateSettings(collapseNotification: value);
                },
              );
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              '震度別の音設定で個別にオーバーライドすることもできます',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: context.designSystem.colorTheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SoundInterruptionCard extends StatelessWidget {
  const _SoundInterruptionCard({
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
            title: const Text('通知音'),
            trailing: DropdownMenu<NotificationSound>(
              key: ValueKey(sound),
              initialSelection: sound,
              requestFocusOnTap: false,
              width: 148,
              onSelected: (selected) async {
                if (selected != null) {
                  await onSoundChanged(selected);
                }
              },
              dropdownMenuEntries: [
                for (final s in NotificationSound.values)
                  DropdownMenuEntry(value: s, label: s.displayName),
              ],
            ),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('割り込みレベル'),
            trailing: DropdownMenu<InterruptionLevel>(
              key: ValueKey(interruptionLevel),
              initialSelection: interruptionLevel,
              requestFocusOnTap: false,
              width: 192,
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
                      InterruptionLevel.passive => 'パッシブ',
                      InterruptionLevel.active => 'アクティブ',
                      InterruptionLevel.timeSensitive => 'タイムセンシティブ',
                      InterruptionLevel.critical => 'クリティカル',
                    },
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('続報をまとめて表示'),
            subtitle: const Text('ONにすると、続報で前の通知を上書きします'),
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
