import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_region_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EewSettingsPage extends StatelessWidget {
  const EewSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('緊急地震速報の通知'),),
      body: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(EewSettingsNotifier.saveSettingsMutation, (_, next) {
      if (next is MutationError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('設定の保存に失敗しました: ${next.error}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });
    ref.listen(EewSettingsNotifier.saveLiveActivityMutation, (_, next) {
      if (next is MutationError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Live Activity設定の保存に失敗しました: ${next.error}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });
    final settingsAsync = ref.watch(eewSettingsProvider);

    if (settingsAsync.hasError && !settingsAsync.isLoading) {
      return _ErrorBody(
        onRetry: () => ref.invalidate(eewSettingsProvider, asReload: true),
      );
    }

    final settings =
        settingsAsync.value ??
        const EewNotificationSettings(
          enabled: true,
          startLiveActivity: true,
          onePointEnabled: true,
          regions: [],
        );

    return Skeletonizer(
      enabled: settingsAsync.isLoading,
      child: ListView(
        children: [
          const SettingsSectionHeader(text: '通知の有効化'),
          _EnabledSection(settings: settings),
          // TODO(YumNumm): 重大な通知の実装
          const SizedBox(
            height: 32,
            child: Placeholder(
              child: Center(child: Text('重大な通知')),
            ),
          ),
          const SettingsSectionHeader(text: 'Live Activity'),
          _LiveActivitySection(settings: settings),
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
      // TODO(YumNumm): メッセージ変える
      subtitle: '[TODO: メッセージ変える] 緊急地震速報を受け取ります',
      value: settings.enabled,
      onChanged: isSaving
          ? null
          : (value) async {
              try {
                await EewSettingsNotifier.saveSettingsMutation.run(
                  ref,
                  (tsx) async {
                    await tsx
                        .get(eewSettingsProvider.notifier)
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

class _LiveActivitySection extends ConsumerWidget {
  const _LiveActivitySection({required this.settings});

  final EewNotificationSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveState = ref.watch(EewSettingsNotifier.saveLiveActivityMutation);
    final isSaving = saveState is MutationPending;

    return AppSwitchListTile(
      title: 'Live Activity を開始',
      subtitle: 'EEW 発生時にDynamic Island・ロック画面に情報を表示します\n'
      '[TODO: 説明画像を挿入したい]',
      value: settings.startLiveActivity,
      onChanged: isSaving
          ? null
          : (value) async {
              try {
                await EewSettingsNotifier.saveLiveActivityMutation.run(
                  ref,
                  (tsx) async {
                    await tsx
                        .get(eewSettingsProvider.notifier)
                        .setStartLiveActivity(startLiveActivity: value);
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

  final EewNotificationSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(EewSettingsNotifier.updateRegionsMutation, (_, next) {
      if (next is MutationError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('地域の更新に失敗しました: ${next.error}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });
    final regionsState = ref.watch(EewSettingsNotifier.updateRegionsMutation);
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
                await EewSettingsNotifier.updateRegionsMutation.run(
                  ref,
                  (tsx) async {
                    await tsx
                        .get(eewSettingsProvider.notifier)
                        .removeRegion(
                          regionId: region.regionId,
                          isCurrentLocation: region.isCurrentLocation,
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
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.tonal(
                onPressed: isBusy || hasCurrentLocation
                    ? null
                    : () async {
                        final location = await _ensurePermissionAndGetLocation(
                          context,
                        );
                        if (location == null || !context.mounted) {
                          return;
                        }
                        final resolver = await ref.read(
                          jmaRegionResolverProvider.future,
                        );
                        final code = resolver.resolveRegionCode(
                          location.lat,
                          location.lon,
                        );
                        final name = resolver.resolveRegionName(
                          location.lat,
                          location.lon,
                        );
                        if (!context.mounted) {
                          return;
                        }
                        if (code == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('現在地のJMA細分区域を解決できませんでした'),
                            ),
                          );
                          return;
                        }
                        try {
                          await EewSettingsNotifier.updateRegionsMutation.run(
                            ref,
                            (tsx) async {
                              await tsx
                                  .get(eewSettingsProvider.notifier)
                                  .addCurrentLocationRegion(
                                    regionCode: code,
                                    regionName: name,
                                  );
                            },
                          );
                        } on Object {
                          return;
                        }
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
                        final result = await showNotificationRegionPickerDialog(
                          context,
                          allRegionAlreadyAdded: hasAllRegion,
                        );
                        if (result == null || !context.mounted) {
                          return;
                        }
                        try {
                          await EewSettingsNotifier.updateRegionsMutation.run(
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
                          );
                        } on Object {
                          return;
                        }
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

/// 現在地通知のために位置情報の常時許可を取得し、現在位置を返す。
/// 権限が無い場合や whileInUse の場合は設定アプリ誘導ダイアログを表示する。
Future<({double lat, double lon})?> _ensurePermissionAndGetLocation(
  BuildContext context,
) async {
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    if (!context.mounted) {
      return null;
    }
    final shouldOpen = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: const Text('位置情報の許可が必要です'),
        content: const Text(
          'EEWの現在地通知には、位置情報の「常に許可」が必要です。\n'
          '設定アプリで権限を変更してください。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('設定を開く'),
          ),
        ],
      ),
    );
    if (shouldOpen ?? false) {
      await Geolocator.openAppSettings();
    }
    return null;
  }

  // whileInUse のみ許可されている場合は「常に許可」への昇格を促す。
  // 昇格しなくても現在地を追加し続けることはできるが、バックグラウンドでは動かない。
  if (permission == LocationPermission.whileInUse) {
    if (!context.mounted) {
      return null;
    }
    final shouldOpen = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: const Text('「常に許可」への変更をお願いします'),
        content: const Text(
          'バックグラウンドでも位置情報を更新するには、'
          '位置情報の許可を「常に許可」に変更する必要があります。\n'
          '設定アプリで「位置情報」→「常に許可」を選択してください。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('後で'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('設定を開く'),
          ),
        ],
      ),
    );
    if (shouldOpen ?? false) {
      await Geolocator.openAppSettings();
      // 設定アプリから戻るまで待つ（ユーザーが変更した場合に備えて）
      return null;
    }
    // 「後で」を選択した場合はそのまま現在地を取得して追加する
  }

  try {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
      ),
    );
    return (lat: position.latitude, lon: position.longitude);
  } on Object {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('現在地の取得に失敗しました')),
      );
    }
    return null;
  }
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
