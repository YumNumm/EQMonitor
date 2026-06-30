import 'package:app_settings/app_settings.dart';
import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_error_dialog.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_warning_config_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/region_picker_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart';
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
    final notificationsEnabled = useState(true);
    final selectedPreset = ref.watch(notificationPresetProvider);

    final constraints = ref.watch(startProvider).value?.planConstraints.free;
    final isPro = constraints?.isPro ?? false;
    final maxRegions = constraints?.maxRegions.toInt() ?? 1;

    ref.listen(NotificationSlotsNotifier.putCurrentLocationMutation, (_, next) {
      if (next is MutationError && context.mounted) {
        showNotificationSettingsErrorDialog(
          context: context,
          error: next.error,
          errorMessageBuilder: ref.read(errorMessageBuilderProvider),
        );
      }
    });

    ref.listen(
      GeneralNotificationSettingsNotifier.updateSettingsMutation,
      (_, next) {
        if (next is MutationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('設定の保存に失敗しました: ${next.error}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
    );

    return ListView(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      children: [
        _MasterNotificationControl(
          value: notificationsEnabled.value,
          onChanged: (value) => notificationsEnabled.value = value,
        ),
        if (notificationsEnabled.value) ...[
          const SettingsSectionHeader(text: '通知条件'),
          _PresetOptionGroup(
            selectedPreset: selectedPreset,
            onChanged: (preset) =>
                ref.read(notificationPresetProvider.notifier).select(preset),
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
          const SettingsSectionHeader(text: 'その他の通知'),
          const _GeneralNotificationSettingsSection(),
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

class _PresetOptionGroup extends StatelessWidget {
  const _PresetOptionGroup({
    required this.selectedPreset,
    required this.onChanged,
    required this.onCustomSettingsTap,
  });

  final NotificationPreset selectedPreset;
  final ValueChanged<NotificationPreset> onChanged;
  final VoidCallback onCustomSettingsTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    return Card.outlined(
      margin: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.sm,
        spacing.lg,
        spacing.md,
      ),
      color: color.surfaceCard,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: color.outlineSoft),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PresetOptionTile(
            title: '推奨設定',
            subtitle: '現在地を中心に、必要な通知を自動で受け取ります',
            isSelected: selectedPreset == NotificationPreset.recommended,
            onTap: () => onChanged(NotificationPreset.recommended),
          ),
          const Divider(height: 1),
          _PresetOptionTile(
            title: 'カスタム',
            subtitle: '通知の種類ごとに条件を細かく設定します',
            isSelected: selectedPreset == NotificationPreset.custom,
            onTap: () => onChanged(NotificationPreset.custom),
            trailing: _CustomPresetTrailing(
              enabled: selectedPreset == NotificationPreset.custom,
              onTap: onCustomSettingsTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _PresetOptionTile extends StatelessWidget {
  const _PresetOptionTile({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final textColor = designSystem.textColor;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.lg,
          vertical: spacing.md,
        ),
        child: Row(
          children: [
            _PresetSelectionMark(isSelected: isSelected),
            SizedBox(width: spacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: designSystem.typography.titleMedium.copyWith(
                      color: textColor.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: spacing.xs),
                  Text(
                    subtitle,
                    style: designSystem.typography.bodySmall.copyWith(
                      color: textColor.secondary,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: spacing.sm),
              trailing!,
            ],
          ],
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
    final color = Theme.of(context).colorScheme;

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color.primary : designSystem.textColor.tertiary,
          width: isSelected ? 6 : 3,
        ),
      ),
    );
  }
}

class _CustomPresetTrailing extends StatelessWidget {
  const _CustomPresetTrailing({
    required this.enabled,
    required this.onTap,
  });

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.chevron_right,
          color: enabled ? null : Theme.of(context).disabledColor,
        ),
        SizedBox(
          height: 40,
          child: VerticalDivider(
            color: designSystem.color.outlineSoft,
            thickness: 1,
          ),
        ),
        IconButton(
          tooltip: 'カスタム設定',
          onPressed: enabled ? onTap : null,
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
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
    final earthquakeSettings =
        ref.watch(earthquakeGlobalSettingsProvider).value;

    ref.listen(EewGlobalSettingsNotifier.updateSettingsMutation, (_, next) {
      if (next is MutationError && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('設定の保存に失敗しました: ${next.error}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });
    ref.listen(
      EarthquakeGlobalSettingsNotifier.updateSettingsMutation,
      (_, next) {
        if (next is MutationError && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('設定の保存に失敗しました: ${next.error}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text('カスタム設定')),
      body: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        children: [
          if (!isPro) const _ProUpsellBanner(),
          const SettingsSectionHeader(text: '通知の種類'),
          _CustomSettingsSection(
            isPro: isPro,
            eewForecastEnabled: eewSettings?.enabled ?? true,
            earthquakeEnabled: earthquakeSettings?.enabled ?? true,
            liveActivityEnabled: eewSettings?.startLiveActivity ?? true,
            estimatedIntensityEnabled:
                earthquakeSettings?.estimatedIntensityEnabled ?? true,
            onEewForecastChanged: ({required value}) async {
              await EewGlobalSettingsNotifier.updateSettingsMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(eewGlobalSettingsProvider.notifier)
                      .updateSettings(enabled: value);
                },
              );
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
              await EewGlobalSettingsNotifier.updateSettingsMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(eewGlobalSettingsProvider.notifier)
                      .updateSettings(startLiveActivity: value);
                },
              );
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
          const SettingsSectionHeader(text: '通知地域'),
          _SlotListSection(isPro: isPro, maxRegions: maxRegions),
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
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    return Card.outlined(
      margin: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.sm,
        spacing.lg,
        spacing.md,
      ),
      color: color.surfaceCard,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: color.outlineSoft),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _NotificationDetailTile(
            title: '緊急地震速報(予報)',
            subtitle: eewForecastEnabled ? '有効: 現在地 震度4以上' : '無効',
            enabled: eewForecastEnabled,
            onChanged: onEewForecastChanged,
          ),
          const Divider(height: 1),
          _NotificationDetailTile(
            title: '地震情報',
            subtitle: earthquakeEnabled ? '有効: 現在地 震度1以上' : '無効',
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
            title: '推計震度',
            subtitle: estimatedIntensityEnabled ? '通知する' : '通知しない',
            value: estimatedIntensityEnabled,
            onChanged: onEstimatedIntensityChanged,
          ),
          const Divider(height: 1),
          _LockedSettingTile(
            title: '通知音・割り込みレベル',
            subtitle: isPro ? '種類ごとに変更できます' : 'Freeでは固定です',
            locked: !isPro,
          ),
          const Divider(height: 1),
          _LockedSettingTile(
            title: '震度別の音設定',
            subtitle: isPro ? '震度ごとに音と割り込みを変更できます' : 'Proで利用できます',
            locked: !isPro,
          ),
          const Divider(height: 1),
          _LockedSettingTile(
            title: '1点検知',
            subtitle: isPro ? '通常またはサイレントで通知できます' : 'Proで利用できます',
            locked: !isPro,
          ),
        ],
      ),
    );
  }
}

class _NotificationDetailTile extends StatelessWidget {
  const _NotificationDetailTile({
    required this.title,
    required this.subtitle,
    required this.enabled,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool enabled;
  final Future<void> Function({required bool value}) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        await Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => _NotificationConditionDetailPage(
              title: title,
              enabled: enabled,
              onChanged: onChanged,
            ),
          ),
        );
      },
    );
  }
}

class _NotificationConditionDetailPage extends StatelessWidget {
  const _NotificationConditionDetailPage({
    required this.title,
    required this.enabled,
    required this.onChanged,
  });

  final String title;
  final bool enabled;
  final Future<void> Function({required bool value}) onChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        children: [
          _MasterNotificationControl(
            value: enabled,
            onChanged: (value) async => onChanged(value: value),
          ),
          const SettingsSectionHeader(text: '条件'),
          _SettingValueTile(
            title: '通知状態',
            subtitle: enabled ? '有効' : '無効',
          ),
          if (enabled)
            const _SettingValueTile(
              title: '対象',
              subtitle: '現在地 / 全国 / 地域スロット',
            ),
        ],
      ),
    );
  }
}

class _EewWarningDetailTile extends ConsumerWidget {
  const _EewWarningDetailTile({required this.isPro});

  final bool isPro;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final target = ref.watch(eewWarningConfigProvider).value?.target;
    return ListTile(
      title: const Text('緊急地震速報(警報)'),
      subtitle: Text(target?.label ?? '読み込み中…'),
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
    ref.listen(EewWarningConfigNotifier.updateConfigMutation, (_, next) {
      if (next is MutationError && context.mounted) {
        showNotificationSettingsErrorDialog(
          context: context,
          error: next.error,
          errorMessageBuilder: ref.read(errorMessageBuilderProvider),
        );
      }
    });

    final target = ref.watch(eewWarningConfigProvider).value?.target;

    Future<void> select(EewWarningTarget value) async {
      await EewWarningConfigNotifier.updateConfigMutation.run(ref, (tsx) async {
        await tsx
            .get(eewWarningConfigProvider.notifier)
            .updateConfig(target: value);
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('緊急地震速報(警報)')),
      body: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        children: [
          const SettingsSectionHeader(text: '通知対象'),
          _TargetOptionTile(
            title: '現在地のみ',
            subtitle: '現在地が警報対象になったときに通知します',
            selected: target == EewWarningTarget.currentLocationOnly,
            locked: false,
            onTap: () async => select(EewWarningTarget.currentLocationOnly),
          ),
          _TargetOptionTile(
            title: '現在地 + 全国',
            subtitle: isPro ? '全国の警報も通知します' : 'Proで利用できます',
            selected: target == EewWarningTarget.currentLocationAndNationwide,
            locked: !isPro,
            onTap: () async =>
                select(EewWarningTarget.currentLocationAndNationwide),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              '現在のAPI仕様では、緊急地震速報(警報)自体の無効化はありません。',
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

class _LockedSettingTile extends StatelessWidget {
  const _LockedSettingTile({
    required this.title,
    required this.subtitle,
    required this.locked,
  });

  final String title;
  final String subtitle;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final textColor = locked
        ? Theme.of(context).disabledColor
        : context.designSystem.textColor.primary;

    return ListTile(
      enabled: !locked,
      title: Text(title, style: TextStyle(color: textColor)),
      subtitle: Text(subtitle),
      trailing: locked ? const _ProBadge() : const Icon(Icons.chevron_right),
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
        : context.designSystem.textColor.primary;

    return ListTile(
      enabled: !locked,
      leading: _PresetSelectionMark(isSelected: selected),
      title: Text(title, style: TextStyle(color: textColor)),
      subtitle: Text(subtitle),
      trailing: locked ? const _ProBadge() : null,
      onTap: locked ? null : onTap,
    );
  }
}

class _SlotListSection extends ConsumerWidget {
  const _SlotListSection({
    required this.isPro,
    required this.maxRegions,
  });

  final bool isPro;
  final int maxRegions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;

    final slotsAsync = ref.watch(notificationSlotsProvider);
    final slots = [...?slotsAsync.value]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

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
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ...tiles,
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
              color: designSystem.textColor.secondary,
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
      NotificationSlotType.region => ('📍', slot.regionName ?? '地域'),
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
      trailing: isActive ? const Icon(Icons.chevron_right) : const _ProBadge(),
      onTap: onTap,
    );
  }
}

class _ProUpsellBanner extends StatelessWidget {
  const _ProUpsellBanner();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;

    return Padding(
      padding: EdgeInsets.fromLTRB(spacing.lg, 0, spacing.lg, spacing.md),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(designSystem.shape.card),
        ),
        child: Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Text(
            'EQMonitor Proにすると、地域枠の追加、震度別の音、割り込みレベル、1点検知、EEW警報の全国通知を設定できます。',
            style: designSystem.typography.bodyMedium.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProBadge extends StatelessWidget {
  const _ProBadge();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          'Pro',
          style: TextStyle(color: colorScheme.onPrimaryContainer),
        ),
      ),
    );
  }
}

class _SettingValueTile extends StatelessWidget {
  const _SettingValueTile({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
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
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    return Card.outlined(
      margin: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.sm,
        spacing.lg,
        spacing.md,
      ),
      color: color.surfaceCard,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: color.outlineSoft),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _InlineSwitchTile(
            title: '津波通知',
            subtitle: settings.tsunamiEnabled ? '通知する' : '通知しない',
            value: settings.tsunamiEnabled,
            onChanged: ({required value}) async {
              await GeneralNotificationSettingsNotifier.updateSettingsMutation
                  .run(ref, (tsx) async {
                await tsx
                    .get(generalNotificationSettingsProvider.notifier)
                    .updateSettings(tsunamiEnabled: value);
              });
            },
          ),
          const Divider(height: 1),
          _InlineSwitchTile(
            title: '訓練通知',
            subtitle: settings.trainingEnabled ? '通知する' : '通知しない',
            value: settings.trainingEnabled,
            onChanged: ({required value}) async {
              await GeneralNotificationSettingsNotifier.updateSettingsMutation
                  .run(ref, (tsx) async {
                await tsx
                    .get(generalNotificationSettingsProvider.notifier)
                    .updateSettings(trainingEnabled: value);
              });
            },
          ),
          const Divider(height: 1),
          _InlineSwitchTile(
            title: '南海トラフ臨時情報',
            subtitle:
                settings.nankaiExtraordinaryEnabled ? '通知する' : '通知しない',
            value: settings.nankaiExtraordinaryEnabled,
            onChanged: ({required value}) async {
              await GeneralNotificationSettingsNotifier.updateSettingsMutation
                  .run(ref, (tsx) async {
                await tsx
                    .get(generalNotificationSettingsProvider.notifier)
                    .updateSettings(nankaiExtraordinaryEnabled: value);
              });
            },
          ),
          const Divider(height: 1),
          _InlineSwitchTile(
            title: '南海トラフ定例情報',
            subtitle: settings.nankaiRegularEnabled ? '通知する' : '通知しない',
            value: settings.nankaiRegularEnabled,
            onChanged: ({required value}) async {
              await GeneralNotificationSettingsNotifier.updateSettingsMutation
                  .run(ref, (tsx) async {
                await tsx
                    .get(generalNotificationSettingsProvider.notifier)
                    .updateSettings(nankaiRegularEnabled: value);
              });
            },
          ),
          const Divider(height: 1),
          _InlineSwitchTile(
            title: '北海道三連動（十勝沖）',
            subtitle:
                settings.hokkaido3renOffshoreEnabled ? '通知する' : '通知しない',
            value: settings.hokkaido3renOffshoreEnabled,
            onChanged: ({required value}) async {
              await GeneralNotificationSettingsNotifier.updateSettingsMutation
                  .run(ref, (tsx) async {
                await tsx
                    .get(generalNotificationSettingsProvider.notifier)
                    .updateSettings(hokkaido3renOffshoreEnabled: value);
              });
            },
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
              backgroundColor: Theme.of(context).colorScheme.error,
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
      onTap: () async => AppSettings.openAppSettings(
        type: AppSettingsType.notification,
      ),
    );
  }
}

extension on EewWarningTarget {
  String get label => switch (this) {
    .currentLocationOnly => '現在地のみ',
    .currentLocationAndNationwide => '現在地＋全国',
  };
}
