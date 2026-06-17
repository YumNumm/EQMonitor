import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/earthquake_notification_region_picker.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_region_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EarthquakeSettingsPage extends StatelessWidget {
  const EarthquakeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('地震情報の通知')),
      body: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(EarthquakeNotificationSettingsNotifier.saveSettingsMutation, (
      _,
      next,
    ) {
      if (next is MutationError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('設定の保存に失敗しました: ${next.error}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });
    final settingsAsync = ref.watch(earthquakeNotificationSettingsProvider);

    if (settingsAsync.hasError && !settingsAsync.isLoading) {
      return _ErrorBody(
        onRetry: () => ref.invalidate(
          earthquakeNotificationSettingsProvider,
          asReload: true,
        ),
      );
    }

    final settings =
        settingsAsync.value ??
        const EarthquakeNotificationSettings(
          enabled: true,
          criticalThreshold: null,
          estimatedIntensityEnabled: false,
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
          const SettingsSectionHeader(text: '推定震度'),
          _EstimatedIntensitySection(settings: settings),
          const SettingsSectionHeader(text: '通知地域'),
          _RegionsSection(settings: settings),
        ],
      ),
    );
  }
}

class _EnabledSection extends ConsumerWidget {
  const _EnabledSection({required this.settings});

  final EarthquakeNotificationSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveState = ref.watch(
      EarthquakeNotificationSettingsNotifier.saveSettingsMutation,
    );
    final isSaving = saveState is MutationPending;

    return AppSwitchListTile(
      title: '地震情報の通知',
      subtitle: '地震発生時に通知を受け取ります',
      value: settings.enabled,
      onChanged: isSaving
          ? null
          : (value) async {
              try {
                await EarthquakeNotificationSettingsNotifier
                    .saveSettingsMutation
                    .run(
                      ref,
                      (tsx) async {
                        await tsx
                            .get(
                              earthquakeNotificationSettingsProvider.notifier,
                            )
                            .setEnabled(enabled: value);
                      },
                    );
              } on Object {
                return;
              }
            },
    );
  }
}

class _ThresholdSection extends ConsumerWidget {
  const _ThresholdSection({required this.settings});

  final EarthquakeNotificationSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveState = ref.watch(
      EarthquakeNotificationSettingsNotifier.saveSettingsMutation,
    );
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
              try {
                await EarthquakeNotificationSettingsNotifier
                    .saveSettingsMutation
                    .run(
                      ref,
                      (tsx) async {
                        await tsx
                            .get(
                              earthquakeNotificationSettingsProvider.notifier,
                            )
                            .setCriticalThreshold(
                              picked == _kClearThreshold ? null : picked,
                            );
                      },
                    );
              } on Object {
                return;
              }
            },
    );
  }
}

class _EstimatedIntensitySection extends ConsumerWidget {
  const _EstimatedIntensitySection({required this.settings});

  final EarthquakeNotificationSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveState = ref.watch(
      EarthquakeNotificationSettingsNotifier.saveSettingsMutation,
    );
    final isSaving = saveState is MutationPending;

    return AppSwitchListTile(
      title: '推定震度を含む',
      subtitle: '気象庁発表前の推定震度を通知に含めます',
      value: settings.estimatedIntensityEnabled,
      onChanged: isSaving
          ? null
          : (value) async {
              try {
                await EarthquakeNotificationSettingsNotifier
                    .saveSettingsMutation
                    .run(
                      ref,
                      (tsx) async {
                        await tsx
                            .get(
                              earthquakeNotificationSettingsProvider.notifier,
                            )
                            .setEstimatedIntensityEnabled(enabled: value);
                      },
                    );
              } on Object {
                return;
              }
            },
    );
  }
}

class _RegionsSection extends ConsumerWidget {
  const _RegionsSection({required this.settings});

  final EarthquakeNotificationSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(EarthquakeNotificationSettingsNotifier.updateRegionsMutation, (
      _,
      next,
    ) {
      if (next is MutationError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('地域の更新に失敗しました: ${next.error}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });
    final regionsState = ref.watch(
      EarthquakeNotificationSettingsNotifier.updateRegionsMutation,
    );
    final isBusy = regionsState is MutationPending;
    final hasCurrentLocation = settings.regions.any((r) => r.isCurrentLocation);
    final hasAllRegion = settings.regions.any(
      (r) => !r.isCurrentLocation && r.regionId == 0,
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
          NotificationRegionListTile(
            region: region,
            isBusy: isBusy,
            onDelete: () async {
              try {
                await EarthquakeNotificationSettingsNotifier
                    .updateRegionsMutation
                    .run(
                      ref,
                      (tsx) async {
                        await tsx
                            .get(
                              earthquakeNotificationSettingsProvider.notifier,
                            )
                            .removeRegion(
                              regionId: region.regionId,
                              isCurrentLocation: region.isCurrentLocation,
                              cityCode: region.cityCode,
                            );
                      },
                    );
              } on Object {
                return;
              }
            },
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: FilledButton.tonal(
            onPressed: isBusy
                ? null
                : () async {
                    final result =
                        await showEarthquakeNotificationRegionPickerDialog(
                          context,
                          allRegionAlreadyAdded: hasAllRegion,
                          currentLocationAlreadyAdded: hasCurrentLocation,
                        );
                    if (result == null || !context.mounted) {
                      return;
                    }
                    try {
                      await EarthquakeNotificationSettingsNotifier
                          .updateRegionsMutation
                          .run(ref, (tsx) async {
                            final notifier = tsx.get(
                              earthquakeNotificationSettingsProvider.notifier,
                            );
                            if (result.isCurrentLocation) {
                              await notifier.addCurrentLocationRegion(
                                regionCode: result.regionId,
                                regionName: result.regionName,
                                cityCode: result.cityCode,
                                cityName: result.cityName,
                                minIntensity: result.minIntensity,
                              );
                            } else {
                              await notifier.addRegion(
                                regionId: result.regionId,
                                regionName: result.regionName,
                                minIntensity: result.minIntensity,
                                cityCode: result.cityCode,
                                cityName: result.cityName,
                              );
                            }
                          });
                    } on Object {
                      return;
                    }
                  },
            child: isBusy
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                  )
                : const Text('地域を追加'),
          ),
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
