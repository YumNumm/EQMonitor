import 'package:app_settings/app_settings.dart';
import 'package:eqmonitor/core/component/error/error_dialog.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/info_link.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_warning_config_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/notification_preset_applier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/critical_alert_permission_card.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/info_notification_tile.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/interruption_level_selector.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_feature_widgets.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/dialog/notification_permission_dialog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/earthquake_info_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/eew_forecast_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/per_intensity_sound_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/region_picker_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/sound_interruption_settings_page.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('通知設定')),
      body: const _Body(),
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsEnabled = ref.watch(
      generalNotificationSettingsProvider.select(
        (s) => s.value?.notificationEnabled ?? true,
      ),
    );
    final selectedPreset =
        ref.watch(notificationPresetProvider).value ??
        NotificationPreset.recommended;

    final constraints = ref.watch(startProvider).value?.planConstraints.free;
    final isPro = constraints?.isPro ?? false;
    final maxRegions = constraints?.maxRegions.toInt() ?? 1;

    ref.listen(NotificationSlotsNotifier.putCurrentLocationMutation, (
      _,
      next,
    ) async {
      if (next is MutationError && context.mounted) {
        await showErrorDialog(context, error: next.error);
      }
    });

    ref.listen(GeneralNotificationSettingsNotifier.updateSettingsMutation, (
      _,
      next,
    ) async {
      if (next is MutationError && context.mounted) {
        await showErrorDialog(context, error: next.error);
      }
    });

    return ListView(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      children: [
        _MasterNotificationControl(
          value: notificationsEnabled,
          onChanged: (value) async {
            await GeneralNotificationSettingsNotifier.updateSettingsMutation
                .run(ref, (tsx) async {
                  await tsx
                      .get(generalNotificationSettingsProvider.notifier)
                      .updateSettings(notificationEnabled: value);
                });
          },
        ),
        if (notificationsEnabled) ...[
          const SettingsSectionHeader(text: '通知プリセット'),
          NotificationPresetSelector(
            selectedPreset: selectedPreset,
            onChanged: (preset) async {
              await ref.read(notificationPresetApplierProvider).apply(preset);
              if (preset == NotificationPreset.custom) {
                await ref
                    .read(notificationPresetProvider.notifier)
                    .select(NotificationPreset.custom);
              }
            },
            style: NotificationPresetSelectorStyle.settings,
            onCustomSettingsTap: () async {
              if (selectedPreset != NotificationPreset.custom) {
                return;
              }
              await Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (_) => _CustomNotificationSettingsPage(
                    isPro: isPro,
                    maxRegions: maxRegions,
                  ),
                ),
              );
            },
          ),
        ],
        const SettingsSectionHeader(text: 'ツール'),
        const _NotificationHistoryTile(),
        const _TestNotificationTile(),
        const _AndroidNotificationSettingsTile(),
      ],
    );
  }
}

class _MasterNotificationControl extends StatelessWidget {
  const _MasterNotificationControl({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
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
              color: value
                  ? colorTheme.surfaceContainerHighest
                  : colorTheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(shape.pill),
              border: Border.all(color: colorTheme.outlineVariant),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '通知を受け取る',
                    style: typography.titleMedium.copyWith(
                      color: designSystem.colorTheme.onSurface,
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

class _PresetSelectionMark extends StatelessWidget {
  const _PresetSelectionMark({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = context.designSystem.colorTheme;

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? colorTheme.primary
              : designSystem.colorTheme.outline,
          width: isSelected ? 6 : 3,
        ),
      ),
    );
  }
}

class _CustomNotificationSettingsPage extends ConsumerWidget {
  const _CustomNotificationSettingsPage({
    required this.isPro,
    required this.maxRegions,
  });

  final bool isPro;
  final int maxRegions;

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
        await showErrorDialog(context, error: next.error);
      }
    });
    ref.listen(EarthquakeGlobalSettingsNotifier.updateSettingsMutation, (
      _,
      next,
    ) async {
      if (next is MutationError && context.mounted) {
        await showErrorDialog(context, error: next.error);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('カスタム設定')),
      body: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        children: [
          if (!isPro) const _ProUpsellBanner(),
          const SettingsSectionHeader(text: '通知地域'),
          _SlotListSection(isPro: isPro, maxRegions: maxRegions),
          const SettingsSectionHeader(text: '通知の種類'),
          _CustomSettingsSection(
            isPro: isPro,
            eewForecastEnabled: eewSettings?.enabled ?? true,
            earthquakeEnabled: earthquakeSettings?.enabled ?? true,
            liveActivityEnabled: eewSettings?.startLiveActivity ?? true,
            estimatedIntensityEnabled:
                earthquakeSettings?.estimatedIntensityEnabled ?? true,
            onEewForecastChanged: ({required value}) async {
              await EewGlobalSettingsNotifier.updateSettingsMutation.run(ref, (
                tsx,
              ) async {
                await tsx
                    .get(eewGlobalSettingsProvider.notifier)
                    .updateSettings(enabled: value);
              });
            },
            onEarthquakeChanged: ({required value}) async {
              await EarthquakeGlobalSettingsNotifier.updateSettingsMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(earthquakeGlobalSettingsProvider.notifier)
                      .updateSettings(enabled: value);
                },
              );
            },
            onLiveActivityChanged: ({required value}) async {
              await EewGlobalSettingsNotifier.updateSettingsMutation.run(ref, (
                tsx,
              ) async {
                await tsx
                    .get(eewGlobalSettingsProvider.notifier)
                    .updateSettings(startLiveActivity: value);
              });
            },
            onEstimatedIntensityChanged: ({required value}) async {
              await EarthquakeGlobalSettingsNotifier.updateSettingsMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(earthquakeGlobalSettingsProvider.notifier)
                      .updateSettings(estimatedIntensityEnabled: value);
                },
              );
            },
          ),
          const SettingsSectionHeader(text: 'その他の通知'),
          const _GeneralNotificationSettingsSection(),
        ],
      ),
    );
  }
}

class _CustomSettingsSection extends StatelessWidget {
  const _CustomSettingsSection({
    required this.isPro,
    required this.eewForecastEnabled,
    required this.earthquakeEnabled,
    required this.liveActivityEnabled,
    required this.estimatedIntensityEnabled,
    required this.onEewForecastChanged,
    required this.onEarthquakeChanged,
    required this.onLiveActivityChanged,
    required this.onEstimatedIntensityChanged,
  });

  final bool isPro;
  final bool eewForecastEnabled;
  final bool earthquakeEnabled;
  final bool liveActivityEnabled;
  final bool estimatedIntensityEnabled;
  final Future<void> Function({required bool value}) onEewForecastChanged;
  final Future<void> Function({required bool value}) onEarthquakeChanged;
  final Future<void> Function({required bool value}) onLiveActivityChanged;
  final Future<void> Function({required bool value})
  onEstimatedIntensityChanged;

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
          _EewForecastDetailTile(
            enabled: eewForecastEnabled,
            onChanged: onEewForecastChanged,
          ),
          const Divider(height: 1),
          _EarthquakeInfoDetailTile(
            enabled: earthquakeEnabled,
            onChanged: onEarthquakeChanged,
          ),
          const Divider(height: 1),
          _EewWarningDetailTile(isPro: isPro),
          const Divider(height: 1),
          _InlineSwitchTile(
            title: 'Live Activity',
            subtitle: liveActivityEnabled ? '開始する' : '開始しない',
            value: liveActivityEnabled,
            onChanged: onLiveActivityChanged,
          ),
          const Divider(height: 1),
          _InlineSwitchTile(
            title: '推計震度分布図',
            subtitle: estimatedIntensityEnabled ? '通知する' : '通知しない',
            value: estimatedIntensityEnabled,
            onChanged: onEstimatedIntensityChanged,
          ),
          const Divider(height: 1),
          LockedSettingTile(
            title: '通知音・割り込みレベル',
            subtitle: isPro ? '種類ごとに変更できます' : '通知音・割り込みレベルの変更、続報通知の上書き設定ができます',
            locked: !isPro,
            onTap: isPro
                ? () => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (_) => const SoundInterruptionSettingsPage(),
                    ),
                  )
                : () => const PaywallRoute().push<void>(context),
          ),
          const Divider(height: 1),
          LockedSettingTile(
            title: '震度別の音設定',
            subtitle: isPro ? '震度ごとに音と割り込みを変更できます' : 'Proで利用できます',
            locked: !isPro,
            onTap: isPro
                ? () => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (_) => const PerIntensitySoundSettingsPage(),
                    ),
                  )
                : () => const PaywallRoute().push<void>(context),
          ),
          const Divider(height: 1),
          LockedSettingTile(
            title: '低精度の緊急地震速報',
            subtitle: '100gal超えのレベル法, 1点検知の低精度の緊急地震速報(予報)',
            locked: !isPro,
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('この機能は現在準備中です')));
            },
          ),
        ],
      ),
    );
  }
}

class _EewForecastDetailTile extends ConsumerWidget {
  const _EewForecastDetailTile({
    required this.enabled,
    required this.onChanged,
  });

  final bool enabled;
  final Future<void> Function({required bool value}) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slots = ref.watch(notificationSlotsProvider).value ?? [];
    final activeCount = slots.where((s) => s.eewEnabled).length;

    return ListTile(
      title: const Text('緊急地震速報(予報)'),
      subtitle: Text(enabled ? '有効: $activeCount地域で通知' : '無効'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        await Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => const EewForecastSettingsPage(),
          ),
        );
      },
    );
  }
}

class _EarthquakeInfoDetailTile extends ConsumerWidget {
  const _EarthquakeInfoDetailTile({
    required this.enabled,
    required this.onChanged,
  });

  final bool enabled;
  final Future<void> Function({required bool value}) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slots = ref.watch(notificationSlotsProvider).value ?? [];
    final activeCount = slots.where((s) => s.earthquakeEnabled).length;

    return ListTile(
      title: const Text('地震情報'),
      subtitle: Text(enabled ? '有効: $activeCount地域で通知' : '無効'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        await Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => const EarthquakeInfoSettingsPage(),
          ),
        );
      },
    );
  }
}

class _EewWarningDetailTile extends ConsumerWidget {
  const _EewWarningDetailTile({required this.isPro});

  final bool isPro;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final warningEnabled =
        ref.watch(eewGlobalSettingsProvider).value?.warningEnabled ?? true;
    final target = ref.watch(eewWarningConfigProvider).value?.target;
    return ListTile(
      title: const Text('緊急地震速報(警報)'),
      subtitle: Text(warningEnabled ? target?.label ?? '読み込み中…' : '無効'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async => Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => _EewWarningSettingsPage(isPro: isPro),
        ),
      ),
    );
  }
}

class _EewWarningSettingsPage extends ConsumerWidget {
  const _EewWarningSettingsPage({required this.isPro});

  final bool isPro;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final warningEnabled = ref.watch(
      eewGlobalSettingsProvider.select((s) => s.value?.warningEnabled ?? true),
    );

    ref.listen(EewWarningConfigNotifier.updateConfigMutation, (_, next) async {
      if (next is MutationError && context.mounted) {
        await showErrorDialog(context, error: next.error);
      }
    });

    ref.listen(EewGlobalSettingsNotifier.updateSettingsMutation, (
      _,
      next,
    ) async {
      if (next is MutationError && context.mounted) {
        await showErrorDialog(context, error: next.error);
      }
    });

    final config = ref.watch(eewWarningConfigProvider).value;
    final target = config?.target;
    final currentLocationLevel = config?.currentLocationInterruptionLevel;
    final nationwideLevel = config?.nationwideInterruptionLevel;
    final permission = ref.watch(osNotificationPermissionProvider).value;
    final platform = Theme.of(context).platform;
    final showCriticalAlertPermissionCard =
        platform == TargetPlatform.iOS &&
        warningEnabled &&
        currentLocationLevel == InterruptionLevel.critical &&
        permission?.isCriticalAlertSupported == true &&
        permission?.isCriticalAlertGranted == false;

    Future<void> select(EewWarningTarget value) async {
      await EewWarningConfigNotifier.updateConfigMutation.run(ref, (tsx) async {
        await tsx
            .get(eewWarningConfigProvider.notifier)
            .updateConfig(
              target: value,
              nationwideInterruptionLevel:
                  value == EewWarningTarget.currentLocationAndNationwide
                  ? InterruptionLevel.active
                  : null,
            );
      });
    }

    Future<void> updateNationwideLevel(InterruptionLevel value) async {
      await EewWarningConfigNotifier.updateConfigMutation.run(ref, (tsx) async {
        await tsx
            .get(eewWarningConfigProvider.notifier)
            .updateConfig(nationwideInterruptionLevel: value);
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('緊急地震速報(警報)')),
      body: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        children: [
          _MasterNotificationControl(
            value: warningEnabled,
            onChanged: (value) async {
              await EewGlobalSettingsNotifier.updateSettingsMutation.run(ref, (
                tsx,
              ) async {
                await tsx
                    .get(eewGlobalSettingsProvider.notifier)
                    .updateSettings(warningEnabled: value);
              });
            },
          ),
          const SettingsSectionHeader(text: '通知対象'),
          _TargetOptionTile(
            title: '現在地のみ',
            subtitle: '現在地が警報対象になったときに通知します',
            selected: target == EewWarningTarget.currentLocationOnly,
            locked: !warningEnabled,
            onTap: () async => select(EewWarningTarget.currentLocationOnly),
          ),
          _TargetOptionTile(
            title: '現在地 + 全国',
            subtitle: isPro ? '全国の警報も通知します' : 'Proで利用できます',
            selected: target == EewWarningTarget.currentLocationAndNationwide,
            locked: !isPro || !warningEnabled,
            onTap: () async =>
                select(EewWarningTarget.currentLocationAndNationwide),
          ),
          if (platform == TargetPlatform.iOS) ...[
            if (currentLocationLevel != null)
              InterruptionLevelSelector(
                title: '現在地の割り込みレベル',
                value: currentLocationLevel,
                levels: currentLocationLevels,
                enabled: warningEnabled,
                onChanged: (value) async {
                  await EewWarningConfigNotifier.updateConfigMutation.run(ref, (
                    tsx,
                  ) async {
                    await tsx
                        .get(eewWarningConfigProvider.notifier)
                        .updateConfig(currentLocationInterruptionLevel: value);
                  });
                },
              ),
            if (target == EewWarningTarget.currentLocationAndNationwide &&
                nationwideLevel != null)
              InterruptionLevelSelector(
                title: '全国の割り込みレベル',
                value: nationwideLevel,
                levels: nationwideLevels,
                enabled: warningEnabled,
                onChanged: updateNationwideLevel,
              ),
            if (showCriticalAlertPermissionCard)
              CriticalAlertPermissionCard(
                onPressed: () =>
                    showCriticalAlertPermissionDialog(context, ref),
              ),
          ] else if (platform == TargetPlatform.android)
            ListTile(
              title: const Text('Androidの通知設定'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () async => AppSettings.openAppSettings(
                type: AppSettingsType.notification,
              ),
            ),
        ],
      ),
    );
  }
}

class _InlineSwitchTile extends StatelessWidget {
  const _InlineSwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final Future<void> Function({required bool value}) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: AppSwitch(
        value: value,
        onChanged: (value) async => onChanged(value: value),
      ),
      onTap: () async => onChanged(value: !value),
    );
  }
}

class _TargetOptionTile extends StatelessWidget {
  const _TargetOptionTile({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.locked,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final bool locked;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = locked
        ? Theme.of(context).disabledColor
        : context.designSystem.colorTheme.onSurface;

    return ListTile(
      enabled: !locked,
      leading: _PresetSelectionMark(isSelected: selected),
      title: Text(title, style: TextStyle(color: textColor)),
      subtitle: Text(subtitle),
      trailing: locked ? const ProBadge() : null,
      onTap: locked ? null : onTap,
    );
  }
}

class _SlotListSection extends ConsumerWidget {
  const _SlotListSection({required this.isPro, required this.maxRegions});

  final bool isPro;
  final int maxRegions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;

    final slotsAsync = ref.watch(notificationSlotsProvider);

    ref.listen(NotificationSlotsNotifier.putNationwideMutation, (
      _,
      next,
    ) async {
      if (next is MutationError && context.mounted) {
        await showErrorDialog(context, error: next.error);
      }
    });

    final slots = [...?slotsAsync.value]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    final hasNationwide = slots.any(
      (s) => s.slotType == NotificationSlotType.nationwide,
    );
    final regionSlotCount = slots
        .where((s) => s.slotType == NotificationSlotType.region)
        .length;
    final canAddRegion = isPro || regionSlotCount < maxRegions;

    final tiles = <Widget>[];
    var regionIndex = 0;
    for (final slot in slots) {
      final bool isActive;
      if (slot.slotType == NotificationSlotType.region) {
        regionIndex++;
        isActive = isPro || regionIndex <= maxRegions;
      } else {
        isActive = true;
      }
      tiles.add(
        _SlotListTile(
          slot: slot,
          isActive: isActive,
          onTap: isActive
              ? () async => Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        SlotDetailPage(slotId: slot.id, isPro: isPro),
                  ),
                )
              : null,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (slotsAsync.isLoading && slots.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator.adaptive()),
          ),
        if (slotsAsync.hasError && !slotsAsync.isLoading)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.lg,
              vertical: spacing.md,
            ),
            child: Text(
              'スロットの読み込みに失敗しました',
              style: designSystem.typography.bodySmall.copyWith(
                color: context.designSystem.colorTheme.error,
              ),
            ),
          ),
        ...tiles,
        if (!hasNationwide)
          Padding(
            padding: EdgeInsets.fromLTRB(spacing.lg, spacing.sm, spacing.lg, 0),
            child: FilledButton.tonalIcon(
              onPressed: () async {
                await NotificationSlotsNotifier.putNationwideMutation.run(ref, (
                  tsx,
                ) async {
                  await tsx
                      .get(notificationSlotsProvider.notifier)
                      .putNationwide(
                        eewEnabled: true,
                        eewMinIntensity: defaultNotificationSlotMinIntensity,
                        earthquakeEnabled: true,
                        earthquakeMinIntensity:
                            defaultNotificationSlotMinIntensity,
                      );
                });
              },
              icon: const Icon(Icons.public),
              label: const Text('全国を追加'),
            ),
          ),
        Padding(
          padding: EdgeInsets.fromLTRB(spacing.lg, spacing.sm, spacing.lg, 0),
          child: FilledButton.tonalIcon(
            onPressed: canAddRegion
                ? () async {
                    await Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (_) => const RegionPickerPage(),
                      ),
                    );
                  }
                : null,
            icon: const Icon(Icons.add),
            label: Text(
              isPro ? '地域を追加' : '地域を追加（$regionSlotCount/$maxRegions）',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(spacing.lg, spacing.sm, spacing.lg, 0),
          child: Text(
            'ダウングレード時も設定は保持され、Freeの上限を超える項目は配信時に無効扱いになります。',
            style: designSystem.typography.bodySmall.copyWith(
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

class _SlotListTile extends StatelessWidget {
  const _SlotListTile({
    required this.slot,
    required this.isActive,
    required this.onTap,
  });

  final NotificationSlot slot;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final (icon, title) = switch (slot.slotType) {
      NotificationSlotType.currentLocation => ('📍', '現在地'),
      NotificationSlotType.nationwide => ('🌐', '全国'),
      NotificationSlotType.region => (
        '📍',
        slot.cityName != null
            ? '${slot.regionName ?? '地域'} ${slot.cityName}'
            : slot.regionName ?? '地域',
      ),
    };

    final eewText = slot.eewEnabled
        ? 'EEW: 震度${slot.eewMinIntensity?.label ?? '-'}以上'
        : 'EEW: 無効';
    final earthquakeText = slot.earthquakeEnabled
        ? '地震情報: 震度${slot.earthquakeMinIntensity?.label ?? '-'}以上'
        : '地震情報: 無効';

    final textColor = isActive ? null : Theme.of(context).disabledColor;

    return ListTile(
      enabled: isActive,
      leading: Text(icon, style: const TextStyle(fontSize: 20)),
      title: Text(title, style: TextStyle(color: textColor)),
      subtitle: Text('$eewText・$earthquakeText'),
      trailing: isActive ? const Icon(Icons.chevron_right) : const ProBadge(),
      onTap: onTap,
    );
  }
}

class _ProUpsellBanner extends StatelessWidget {
  const _ProUpsellBanner();

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;

    return Padding(
      padding: EdgeInsets.fromLTRB(spacing.lg, 0, spacing.lg, spacing.md),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorTheme.primaryContainer,
          borderRadius: BorderRadius.circular(designSystem.shape.card),
        ),
        child: Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Text(
            'EQMonitor Proにすると、地域枠の追加、震度別の音、割り込みレベル、1点検知、EEW警報の全国通知を設定できます。',
            style: designSystem.typography.bodyMedium.copyWith(
              color: colorTheme.onPrimaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _GeneralNotificationSettingsSection extends ConsumerWidget {
  const _GeneralNotificationSettingsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(generalNotificationSettingsProvider);
    final settings = settingsAsync.value;
    if (settings == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

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
          InfoNotificationTile(
            title: '北海道・三陸沖後発地震注意情報',
            subtitleText:
                '北海道の根室沖から東北地方の三陸沖の巨大地震の想定震源域やその周辺でMw7.0以上の地震が発生し、大規模地震の発生可能性が平常時より相対的に高まっている際に「北海道・三陸沖後発地震注意情報」を発表 ',
            value: settings.vyse60Enabled,
            onChanged: ({required value}) async {
              await GeneralNotificationSettingsNotifier.updateSettingsMutation
                  .run(ref, (tsx) async {
                    await tsx
                        .get(generalNotificationSettingsProvider.notifier)
                        .updateSettings(vyse60Enabled: value);
                  });
            },
            bottomSheetTitle: '北海道・三陸沖後発地震注意情報',
            bottomSheetLinks: const [
              InfoLink(
                title: '「北海道・三陸沖後発地震注意情報」について',
                url:
                    'https://www.jma.go.jp/jma/kishou/know/jishin/nceq/info_guide.html',
              ),
              InfoLink(
                title: '配信資料に関する仕様 No.40701 ～北海道・三陸沖後発地震注意情報～',
                url: 'https://www.data.jma.go.jp/suishin/shiyou/pdf/no40701',
              ),
            ],
          ),
          InfoNotificationTile(
            title: '南海トラフ地震関連解説情報(定例外)',
            subtitleText:
                '南海トラフ沿いで異常な現象が観測され、その現象が南海トラフ沿いの大規模な地震と関連するかどうか調査を開始・解説・終了した場合等に発表 ',
            value: settings.nankaiExtraordinaryEnabled,
            onChanged: ({required value}) async {
              await GeneralNotificationSettingsNotifier.updateSettingsMutation
                  .run(ref, (tsx) async {
                    await tsx
                        .get(generalNotificationSettingsProvider.notifier)
                        .updateSettings(nankaiExtraordinaryEnabled: value);
                  });
            },
            bottomSheetTitle: '南海トラフ地震関連解説情報(定例外)',
            bottomSheetLinks: const [
              InfoLink(
                title: '「南海トラフ地震に関連する情報」について',
                url:
                    'https://www.jma.go.jp/jma/kishou/know/jishin/nteq/info_criterion.html',
              ),
              InfoLink(
                title: '「南海トラフ地震臨時情報」が発表されたときの防災対応',
                url:
                    'https://www.jma.go.jp/jma/kishou/know/jishin/nteq/bosai.html',
              ),
            ],
          ),
          InfoNotificationTile(
            title: '南海トラフ地震関連解説情報(定例)',
            subtitleText: '「南海トラフ沿いの地震に関する評価検討会」の定例会合における調査結果を発表 ',
            value: settings.nankaiRegularEnabled,
            onChanged: ({required value}) async {
              await GeneralNotificationSettingsNotifier.updateSettingsMutation
                  .run(ref, (tsx) async {
                    await tsx
                        .get(generalNotificationSettingsProvider.notifier)
                        .updateSettings(nankaiRegularEnabled: value);
                  });
            },
            bottomSheetTitle: '南海トラフ地震関連解説情報(定例)',
            bottomSheetLinks: const [
              InfoLink(
                title: '「南海トラフ地震に関連する情報」について',
                url:
                    'https://www.jma.go.jp/jma/kishou/know/jishin/nteq/info_criterion.html',
              ),
              InfoLink(
                title: '南海トラフ沿いの地震に関する評価検討会とは',
                url:
                    'https://www.jma.go.jp/jma/kishou/know/jishin/nteq/assessment.html',
              ),
            ],
          ),
          InfoNotificationTile(
            title: '地震・津波に関するお知らせ',
            subtitleText:
                '気象庁が発表する「地震・津波に関するお知らせ」(VZSE40)を通知します。試験・訓練配信のお知らせや、市町村の震度データの入電停止などの情報が含まれます。',
            value: settings.earthquakeNoticeEnabled,
            onChanged: ({required value}) async {
              await GeneralNotificationSettingsNotifier.updateSettingsMutation
                  .run(ref, (tsx) async {
                    await tsx
                        .get(generalNotificationSettingsProvider.notifier)
                        .updateSettings(earthquakeNoticeEnabled: value);
                  });
            },
            bottomSheetTitle: '地震・津波に関するお知らせ',
            bottomSheetLinks: const [
              InfoLink(
                title: '「地震・津波に関するお知らせ」について',
                url: 'https://www.data.jma.go.jp/suishin/shiyou/',
              ),
            ],
          ),
          ListTile(
            enabled: false,
            title: const Text('津波通知'),
            subtitle: const Text('現在実装中です。今後のアップデートで利用可能になります。'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ComingSoonBadge(),
                SizedBox(width: spacing.sm),
                AppSwitch(value: settings.tsunamiEnabled, onChanged: null),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationHistoryTile extends StatelessWidget {
  const _NotificationHistoryTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('通知履歴'),
      subtitle: const Text('最近受信した通知の一覧を確認できます'),
      leading: const Icon(Icons.history),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async => const NotificationHistoryRoute().push<void>(context),
    );
  }
}

class _TestNotificationTile extends HookConsumerWidget {
  const _TestNotificationTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingKind = useState<TestNotificationKind?>(null);

    Future<void> send(TestNotificationKind kind) async {
      pendingKind.value = kind;
      final messenger = ScaffoldMessenger.of(context);
      final deviceId = await ref.read(deviceIdProvider.future);
      final repo = await ref.read(pushNotificationRepositoryProvider.future);
      final result = await repo.sendTestNotification(
        deviceId: deviceId,
        kind: kind,
      );
      if (!context.mounted) {
        return;
      }
      pendingKind.value = null;
      switch (result) {
        case Success(:final value):
          messenger.showSnackBar(
            SnackBar(
              content: Text(
                '送信しました（${value.framework.displayLabel}）: ${value.message}',
              ),
            ),
          );
        case Failure(:final exception):
          messenger.showSnackBar(
            SnackBar(
              content: Text('送信に失敗しました: $exception'),
              backgroundColor: context.designSystem.colorTheme.error,
            ),
          );
      }
    }

    return ListTile(
      title: const Text('テスト通知を送信'),
      subtitle: const Text('通知が正しく届くか確認できます'),
      leading: const Icon(Icons.send_outlined),
      onTap: pendingKind.value != null
          ? null
          : () async {
              await showModalBottomSheet<void>(
                context: context,
                builder: (context) => SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'テスト通知',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '送信する通知の種類を選んでください',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: TestNotificationKind.values.map((kind) {
                            return FilledButton.tonal(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await send(kind);
                              },
                              child: Text(kind.displayLabel),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
      trailing: pendingKind.value != null
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
            )
          : const Icon(Icons.chevron_right),
    );
  }
}

class _AndroidNotificationSettingsTile extends StatelessWidget {
  const _AndroidNotificationSettingsTile();

  @override
  Widget build(BuildContext context) {
    // iOS では Android のチャンネル設定は不要
    if (Theme.of(context).platform != TargetPlatform.android) {
      return const SizedBox.shrink();
    }
    return ListTile(
      title: const Text('Android 通知チャンネル設定'),
      subtitle: const Text('チャンネルごとに音・バイブなどをカスタマイズできます'),
      leading: const Icon(Icons.tune_outlined),
      trailing: const Icon(Icons.open_in_new),
      onTap: () async =>
          AppSettings.openAppSettings(type: AppSettingsType.notification),
    );
  }
}

extension on EewWarningTarget {
  String get label => switch (this) {
    .currentLocationOnly => '現在地のみ',
    .currentLocationAndNationwide => '現在地＋全国',
  };
}
