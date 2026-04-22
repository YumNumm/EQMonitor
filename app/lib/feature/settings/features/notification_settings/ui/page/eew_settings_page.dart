import 'dart:async';

import 'package:eqmonitor/core/component/selector/prefecture_selector.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EewSettingsPage extends StatelessWidget {
  const EewSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('緊急地震速報の通知')),
      body: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(eewSettingsProvider);

    if (settingsAsync.hasError && !settingsAsync.isLoading) {
      return _ErrorBody(
        onRetry: () => ref.invalidate(eewSettingsProvider),
      );
    }

    final settings = settingsAsync.value ??
        const EewNotificationSettings(
          enabled: true,
          criticalThreshold: null,
          regions: [],
        );

    return Skeletonizer(
      enabled: settingsAsync.isLoading,
      child: ListView(
        children: [
          const SettingsSectionHeader(text: '通知の有効化'),
          _EnabledSection(settings: settings),
          const SettingsSectionHeader(text: 'クリティカル通知'),
          _ThresholdSection(settings: settings),
          const SettingsSectionHeader(text: '通知地域'),
          _RegionsSection(settings: settings),
        ],
      ),
    );
  }
}

class _EnabledSection extends ConsumerWidget {
  const _EnabledSection({required this.settings});

  final EewNotificationSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveState = ref.watch(EewSettingsNotifier.saveSettingsMutation);
    final isSaving = saveState is MutationPending;

    return AppSwitchListTile(
      title: '緊急地震速報の通知',
      subtitle: '緊急地震速報（警報）を受け取ります',
      value: settings.enabled,
      onChanged: isSaving
          ? null
          : (value) {
              unawaited(
                EewSettingsNotifier.saveSettingsMutation.run(ref, (tsx) async {
                  await tsx
                      .get(eewSettingsProvider.notifier)
                      .setEnabled(enabled: value);
                }),
              );
            },
    );
  }
}

class _ThresholdSection extends ConsumerWidget {
  const _ThresholdSection({required this.settings});

  final EewNotificationSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveState = ref.watch(EewSettingsNotifier.saveSettingsMutation);
    final isSaving = saveState is MutationPending;
    final threshold = settings.criticalThreshold;
    final themeColors = Theme.of(context).colorScheme;

    return ListTile(
      title: const Text('クリティカル通知のしきい値'),
      subtitle: Text(
        threshold != null
            ? '震度${threshold.mainText}${threshold.suffix}以上'
            : '設定なし',
      ),
      trailing: isSaving
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
                backgroundColor: themeColors.onSurfaceVariant,
              ),
            )
          : const Icon(Icons.chevron_right),
      onTap: isSaving
          ? null
          : () async {
              final picked = await _showIntensityPicker(
                context: context,
                current: threshold,
              );
              if (picked == null) {
                return;
              }
              if (!context.mounted) {
                return;
              }
              await EewSettingsNotifier.saveSettingsMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(eewSettingsProvider.notifier)
                      .setCriticalThreshold(
                        picked == _kClearThreshold ? null : picked,
                      );
                },
              );
            },
    );
  }
}

class _RegionsSection extends ConsumerWidget {
  const _RegionsSection({required this.settings});

  final EewNotificationSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regionsState = ref.watch(EewSettingsNotifier.updateRegionsMutation);
    final isBusy = regionsState is MutationPending;

    final hasCurrentLocation = settings.regions.any(
      (r) => r.isCurrentLocation,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (settings.regions.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '通知地域が設定されていません',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        for (final region in settings.regions)
          _RegionListTile(
            region: region,
            isBusy: isBusy,
            onDelete: () {
              unawaited(
                EewSettingsNotifier.updateRegionsMutation.run(ref, (tsx) async {
                  await tsx
                      .get(eewSettingsProvider.notifier)
                      .removeRegion(region.regionId);
                }),
              );
            },
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Wrap(
            spacing: 8,
            children: [
              FilledButton.tonal(
                onPressed: isBusy || hasCurrentLocation
                    ? null
                    : () {
                        unawaited(
                          EewSettingsNotifier.updateRegionsMutation.run(
                            ref,
                            (tsx) async {
                              await tsx
                                  .get(eewSettingsProvider.notifier)
                                  .addCurrentLocationRegion();
                            },
                          ),
                        );
                      },
                child: isBusy
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('現在地を追加'),
              ),
              FilledButton.tonal(
                onPressed: isBusy
                    ? null
                    : () async {
                        final result =
                            await _showRegionPicker(context: context);
                        if (result == null || !context.mounted) {
                          return;
                        }
                        unawaited(
                          EewSettingsNotifier.updateRegionsMutation.run(
                            ref,
                            (tsx) async {
                              await tsx
                                  .get(eewSettingsProvider.notifier)
                                  .addRegion(
                                    regionId: result.regionId,
                                    regionName: result.regionName,
                                    minIntensity: result.minIntensity,
                                  );
                            },
                          ),
                        );
                      },
                child: const Text('地域を追加'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RegionListTile extends StatelessWidget {
  const _RegionListTile({
    required this.region,
    required this.isBusy,
    required this.onDelete,
  });

  final NotificationRegion region;
  final bool isBusy;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final name = region.isCurrentLocation
        ? '現在地'
        : (region.regionName ?? '地域ID: ${region.regionId}');
    final threshold = region.minJmaIntensity;
    return ListTile(
      title: Text(name),
      subtitle: Text('震度${threshold.mainText}${threshold.suffix}以上で通知'),
      trailing: isBusy
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
            )
          : IconButton(
              tooltip: '削除',
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
            ),
    );
  }
}

typedef _RegionPickerResult = ({
  int regionId,
  String regionName,
  JmaIntensity minIntensity,
});

Future<_RegionPickerResult?> _showRegionPicker({
  required BuildContext context,
}) => showDialog<_RegionPickerResult>(
      context: context,
      builder: (_) => const _RegionPickerDialog(),
    );

class _RegionPickerDialog extends StatefulWidget {
  const _RegionPickerDialog();

  @override
  State<_RegionPickerDialog> createState() => _RegionPickerDialogState();
}

class _RegionPickerDialogState extends State<_RegionPickerDialog> {
  String? _selectedCode;
  String? _selectedName;
  JmaIntensity _intensity = JmaIntensity.four;

  static const List<JmaIntensity> _intensities = [
    JmaIntensity.one,
    JmaIntensity.two,
    JmaIntensity.three,
    JmaIntensity.four,
    JmaIntensity.fiveLower,
    JmaIntensity.fiveUpper,
    JmaIntensity.sixLower,
    JmaIntensity.sixUpper,
    JmaIntensity.seven,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('地域を追加'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrefectureSelector(
            selectedCode: _selectedCode,
            onChanged: (sel) => setState(() {
              _selectedCode = sel?.code;
              _selectedName = sel?.name;
            }),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<JmaIntensity>(
            initialValue: _intensity,
            decoration: const InputDecoration(labelText: '最小震度'),
            items: _intensities
                .map(
                  (i) => DropdownMenuItem(
                    value: i,
                    child: Text('震度${i.mainText}${i.suffix}以上'),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) {
                setState(() => _intensity = v);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: _selectedCode == null
              ? null
              : () => Navigator.of(context).pop((
                    regionId: int.parse(_selectedCode!),
                    regionName: _selectedName!,
                    minIntensity: _intensity,
                  )),
          child: const Text('追加'),
        ),
      ],
    );
  }
}

const JmaIntensity _kClearThreshold = JmaIntensity.unknown;

Future<JmaIntensity?> _showIntensityPicker({
  required BuildContext context,
  required JmaIntensity? current,
}) async {
  const selectableIntensities = [
    JmaIntensity.one,
    JmaIntensity.two,
    JmaIntensity.three,
    JmaIntensity.four,
    JmaIntensity.fiveLower,
    JmaIntensity.fiveUpper,
    JmaIntensity.sixLower,
    JmaIntensity.sixUpper,
    JmaIntensity.seven,
  ];

  return showDialog<JmaIntensity>(
    context: context,
    builder: (context) => SimpleDialog(
      title: const Text('通知のしきい値を選択'),
      children: [
        SimpleDialogOption(
          onPressed: () => Navigator.of(context).pop(_kClearThreshold),
          child: const Text('設定なし'),
        ),
        for (final intensity in selectableIntensities)
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(intensity),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '震度${intensity.mainText}${intensity.suffix}以上',
                  ),
                ),
                if (current == intensity)
                  Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18,
                  ),
              ],
            ),
          ),
      ],
    ),
  );
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          const Text('設定の読み込みに失敗しました'),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('再試行'),
          ),
        ],
      ),
    );
  }
}
