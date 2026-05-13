import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShakeDetectionSettingsPage extends StatelessWidget {
  const ShakeDetectionSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('揺れ検知の通知')),
      body: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(shakeDetectionSettingsProvider);

    if (stateAsync.hasError && !stateAsync.isLoading) {
      return _ErrorBody(
        onRetry: () => ref.invalidate(shakeDetectionSettingsProvider),
      );
    }

    final state = stateAsync.value ??
        const (entries: <ShakeDetectionEntry>[], availableSubRegions: []);

    ref.listen(
      ShakeDetectionSettingsNotifier.addCurrentLocationMutation,
      (_, next) {
        if (next is MutationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('現在地の追加に失敗しました: ${next.error}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
    );
    ref.listen(ShakeDetectionSettingsNotifier.removeEntryMutation, (_, next) {
      if (next is MutationError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('地域の削除に失敗しました: ${next.error}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });
    final addState = ref.watch(
      ShakeDetectionSettingsNotifier.addCurrentLocationMutation,
    );
    final removeState = ref.watch(
      ShakeDetectionSettingsNotifier.removeEntryMutation,
    );
    final updateState = ref.watch(
      ShakeDetectionSettingsNotifier.updateLevelMutation,
    );
    final isBusy = addState is MutationPending ||
        removeState is MutationPending ||
        updateState is MutationPending;

    return Skeletonizer(
      enabled: stateAsync.isLoading,
      child: ListView(
        children: [
          if (state.entries.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(
                    Icons.vibration,
                    size: 48,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '揺れ検知の地域が設定されていません',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          for (final entry in state.entries)
            _ShakeEntryCard(
              entry: entry,
              isBusy: isBusy,
              onDelete: () async {
                await ShakeDetectionSettingsNotifier.removeEntryMutation.run(
                  ref,
                  (tsx) async {
                    await tsx
                        .get(shakeDetectionSettingsProvider.notifier)
                        .removeEntry(entry.id);
                  },
                );
              },
              onLevelChanged: (level) async {
                await ShakeDetectionSettingsNotifier.updateLevelMutation.run(
                  ref,
                  (tsx) async {
                    await tsx
                        .get(shakeDetectionSettingsProvider.notifier)
                        .updateLevel(entry.id, level);
                  },
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: FilledButton.tonal(
              onPressed: isBusy ||
                      state.entries.any((e) => e.isCurrentLocation)
                  ? null
                  : () async {
                      await ShakeDetectionSettingsNotifier
                          .addCurrentLocationMutation
                          .run(ref, (tsx) async {
                        await tsx
                            .get(shakeDetectionSettingsProvider.notifier)
                            .addCurrentLocation();
                      });
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
          ),
        ],
      ),
    );
  }
}

class _ShakeEntryCard extends StatelessWidget {
  const _ShakeEntryCard({
    required this.entry,
    required this.isBusy,
    required this.onDelete,
    required this.onLevelChanged,
  });

  final ShakeDetectionEntry entry;
  final bool isBusy;
  final VoidCallback onDelete;
  final ValueChanged<api.ShakeDetectionLevel> onLevelChanged;

  @override
  Widget build(BuildContext context) {
    final name = entry.isCurrentLocation
        ? '現在地'
        : (entry.subRegionName ?? entry.subRegionId ?? '不明な地域');

    return ListTile(
      title: Text(name),
      subtitle: isBusy
          ? const LinearProgressIndicator()
          : DropdownButtonHideUnderline(
              child: DropdownButton<api.ShakeDetectionLevel>(
                value: entry.minLevel,
                isDense: true,
                items: api.ShakeDetectionLevel.values
                    .map(
                      (level) => DropdownMenuItem(
                        value: level,
                        child: Text(_levelLabel(level)),
                      ),
                    )
                    .toList(),
                onChanged: isBusy
                    ? null
                    : (level) {
                        if (level != null) {
                          onLevelChanged(level);
                        }
                      },
              ),
            ),
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

  String _levelLabel(api.ShakeDetectionLevel level) => switch (level) {
    api.ShakeDetectionLevel.weaker => '最小（Weaker）',
    api.ShakeDetectionLevel.weak => '小（Weak）',
    api.ShakeDetectionLevel.medium => '中（Medium）',
    api.ShakeDetectionLevel.strong => '大（Strong）',
    api.ShakeDetectionLevel.stronger => '最大（Stronger）',
  };
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
