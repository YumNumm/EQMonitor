import 'package:app_settings/app_settings.dart';
import 'package:eqmonitor/core/component/error/error_dialog.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/notification/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/notification_preset_applier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/info_link.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_min_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_warning_config_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/info_notification_tile.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_feature_widgets.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_upgrade_dialog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/test_notification_tile.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/per_intensity_sound_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/region_picker_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/sound_interruption_settings_page.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class NotificationSettingsPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('通知設定')),
      body: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const new();

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

    final isProFeaturesEnabled = ref
        .watch(buildConfigProvider)
        .isProFeaturesEnabled;
    final constraints = ref.watch(startProvider).value?.planConstraints.free;
    final isPro = isProFeaturesEnabled && (constraints?.isPro ?? false);
    final maxRegions = constraints?.maxRegions.toInt() ?? 1;

    ref.listen(NotificationSlotsNotifier.putCurrentLocationMutation, (
      _,
      next,
    ) async {
      if (next is MutationError && context.mounted) {
        await ref
            .read(errorDialogActionProvider)
            .show(context, error: next.error);
      }
    });

    ref.listen(GeneralNotificationSettingsNotifier.updateSettingsMutation, (
      _,
      next,
    ) async {
      if (next is MutationError && context.mounted) {
        await ref
            .read(errorDialogActionProvider)
            .show(context, error: next.error);
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
              try {
                await ref.read(notificationPresetApplierProvider).apply(preset);
              } on Object catch (error) {
                if (context.mounted) {
                  await ref
                      .read(errorDialogActionProvider)
                      .show(context, error: error);
                }
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
        const TestNotificationTile(),
        const _AndroidNotificationSettingsTile(),
      ],
    );
  }
}

class _MasterNotificationControl extends StatelessWidget {
  const new({
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

class _CustomNotificationSettingsPage extends ConsumerWidget {
  const new({
    required this.isPro,
    required this.maxRegions,
  });

  final bool isPro;
  final int maxRegions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final earthquakeSettings = ref
        .watch(earthquakeGlobalSettingsProvider)
        .value;

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

    return Scaffold(
      appBar: AppBar(title: const Text('カスタム設定')),
      body: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        children: [
          const SettingsSectionHeader(text: '通知地域'),
          _SlotListSection(isPro: isPro, maxRegions: maxRegions),
          const SettingsSectionHeader(text: '通知の種類'),
          _CustomSettingsSection(
            isPro: isPro,
            estimatedIntensityEnabled:
                earthquakeSettings?.estimatedIntensityEnabled ?? true,
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
  const new({
    required this.isPro,
    required this.estimatedIntensityEnabled,
    required this.onEstimatedIntensityChanged,
  });

  final bool isPro;
  final bool estimatedIntensityEnabled;
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
          _InlineSwitchTile(
            title: '推計震度分布図',
            subtitle: estimatedIntensityEnabled ? '通知する' : '通知しない',
            value: estimatedIntensityEnabled,
            onChanged: onEstimatedIntensityChanged,
          ),
          // 通知音・割り込みレベルは iOS の通知契約に依存する設定のため、
          // Android では OS の通知チャンネル設定へ委ねて非表示にする。
          if (Theme.of(context).platform == TargetPlatform.iOS) ...[
            const Divider(height: 1),
            LockedSettingTile(
              title: '通知音・割り込みレベル',
              subtitle: isPro
                  ? '種類ごとに変更できます'
                  : '通知音・割り込みレベルの変更、続報通知の上書き設定ができます',
              locked: !isPro,
              onTap: isPro
                  ? () => Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (_) => const SoundInterruptionSettingsPage(),
                      ),
                    )
                  : () async => const ProUpgradeDialogAction().show(context),
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
                  : () async => const ProUpgradeDialogAction().show(context),
            ),
          ],
          const Divider(height: 1),
          LockedSettingTile(
            title: '低精度の緊急地震速報',
            subtitle: '100gal超えのレベル法, 1点検知の低精度の緊急地震速報(予報)',
            locked: !isPro,
            onTap: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('この機能は現在準備中です')));
            },
          ),
        ],
      ),
    );
  }
}

class _InlineSwitchTile extends StatelessWidget {
  const new({
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

class _SlotListSection extends ConsumerWidget {
  const new({required this.isPro, required this.maxRegions});

  final bool isPro;
  final int maxRegions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;

    final slotsAsync = ref.watch(notificationSlotsProvider);
    final warningEnabled = ref.watch(
      eewGlobalSettingsProvider.select((s) => s.value?.warningEnabled ?? true),
    );
    final warningTarget = ref.watch(eewWarningConfigProvider).value?.target;

    ref.listen(NotificationSlotsNotifier.putNationwideMutation, (
      _,
      next,
    ) async {
      if (next is MutationError && context.mounted) {
        await ref
            .read(errorDialogActionProvider)
            .show(context, error: next.error);
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
          warningEnabled: warningEnabled,
          warningTarget: warningTarget,
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
      ],
    );
  }
}

class _SlotListTile extends StatelessWidget {
  const new({
    required this.slot,
    required this.isActive,
    required this.warningEnabled,
    required this.warningTarget,
    required this.onTap,
  });

  final NotificationSlot slot;
  final bool isActive;
  final bool warningEnabled;
  final EewWarningTarget? warningTarget;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final (icon, title) = switch (slot.slotType) {
      NotificationSlotType.currentLocation => (
        const Icon(Icons.my_location),
        '現在地',
      ),
      NotificationSlotType.nationwide => (const Icon(Icons.public), '全国'),
      NotificationSlotType.region => (
        const Icon(Icons.location_on),
        slot.cityName != null
            ? '${slot.regionName ?? '地域'} ${slot.cityName}'
            : slot.regionName ?? '地域',
      ),
    };

    final eewText = slot.eewEnabled
        ? '緊急地震速報(予報): '
              '${slot.eewMinIntensity?.minIntensityThresholdLabel ?? '-'}'
        : '緊急地震速報(予報): 無効';
    final showWarning = switch (slot.slotType) {
      NotificationSlotType.currentLocation => warningEnabled,
      NotificationSlotType.nationwide =>
        warningTarget == EewWarningTarget.currentLocationAndNationwide,
      NotificationSlotType.region => false,
    };
    final warningText = showWarning ? '緊急地震速報(警報): 有効' : null;
    final earthquakeText = slot.earthquakeEnabled
        ? '地震情報: '
              '${slot.earthquakeMinIntensity?.minIntensityThresholdLabel ?? '-'}'
        : '地震情報: 無効';

    final textColor = isActive ? null : Theme.of(context).disabledColor;

    return ListTile(
      enabled: isActive,
      leading: icon,
      title: Text(title, style: TextStyle(color: textColor)),
      subtitle: Text([eewText, ?warningText, earthquakeText].join('\n')),
      trailing: isActive ? const Icon(Icons.chevron_right) : const ProBadge(),
      onTap: onTap,
    );
  }
}

class _GeneralNotificationSettingsSection extends ConsumerWidget {
  const new();

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
            subtitleText: '北海道の根室沖から東北地方の三陸沖の巨大地震の想定震源域やその周辺でMw7.0以上の地震が発生し、大規模地震の発生可能性が平常時より相対的に高まっている際に「北海道・三陸沖後発地震注意情報」を発表 ',
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
                url: 'https://www.jma.go.jp/jma/kishou/know/jishin/nceq/info_guide.html',
              ),
              InfoLink(
                title: '配信資料に関する仕様 No.40701 ～北海道・三陸沖後発地震注意情報～',
                url: 'https://www.data.jma.go.jp/suishin/shiyou/pdf/no40701',
              ),
            ],
          ),
          InfoNotificationTile(
            title: '南海トラフ地震関連解説情報(定例外)',
            subtitleText: '南海トラフ沿いで異常な現象が観測され、その現象が南海トラフ沿いの大規模な地震と関連するかどうか調査を開始・解説・終了した場合等に発表 ',
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
                url: 'https://www.jma.go.jp/jma/kishou/know/jishin/nteq/info_criterion.html',
              ),
              InfoLink(
                title: '「南海トラフ地震臨時情報」が発表されたときの防災対応',
                url: 'https://www.jma.go.jp/jma/kishou/know/jishin/nteq/bosai.html',
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
                url: 'https://www.jma.go.jp/jma/kishou/know/jishin/nteq/info_criterion.html',
              ),
              InfoLink(
                title: '南海トラフ沿いの地震に関する評価検討会とは',
                url: 'https://www.jma.go.jp/jma/kishou/know/jishin/nteq/assessment.html',
              ),
            ],
          ),
          InfoNotificationTile(
            title: '地震・津波に関するお知らせ',
            subtitleText: '気象庁が発表する「地震・津波に関するお知らせ」(VZSE40)を通知します。試験・訓練配信のお知らせや、市町村の震度データの入電停止などの情報が含まれます。',
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
  const new();

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

class _AndroidNotificationSettingsTile extends StatelessWidget {
  const new();

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
