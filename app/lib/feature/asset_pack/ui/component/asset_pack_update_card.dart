import 'dart:async';

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/notifier/asset_pack_update_notifier.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_update_installer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssetPackUpdateCard extends HookConsumerWidget {
  const AssetPackUpdateCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(assetPackUpdateProvider);
    useEffect(() {
      if (kIsWeb) {
        return null;
      }
      unawaited(
        Future<void>.microtask(
          () => AssetPackUpdateNotifier.checkMutation.run(
            ref,
            (transaction) =>
                transaction.get(assetPackUpdateProvider.notifier).check(),
          ),
        ),
      );
      return null;
    }, const []);

    if (kIsWeb) {
      return const SizedBox.shrink();
    }

    return switch (state) {
      AssetPackUpdateIdle() ||
      AssetPackUpdateChecking() => const SizedBox.shrink(),
      AssetPackUpdateAvailableState(:final entry, :final changelogEntries) =>
        _AssetPackAvailableCard(
          entry: entry,
          changelogEntries: changelogEntries,
        ),
      AssetPackUpdateInstalling(:final entry, :final progress) =>
        _AssetPackInstallingCard(entry: entry, progress: progress),
      AssetPackUpdateAppRequiredState(:final entry) => _AssetPackMessageCard(
        icon: Icons.system_update_alt_rounded,
        title: 'アプリの更新が必要です',
        message:
            'Asset Pack v${entry.version} はアプリ v${entry.minimumAppVersion} '
            '以降で利用できます。',
      ),
      AssetPackUpdateCompleted(:final version) => _AssetPackMessageCard(
        icon: Icons.check_circle_outline_rounded,
        title: 'Asset Pack を更新しました',
        message: 'v$version のデータへ安全に切り替えました。',
      ),
      AssetPackUpdateError(:final message) => _AssetPackErrorCard(
        message: message,
      ),
    };
  }
}

class _AssetPackAvailableCard extends ConsumerWidget {
  const _AssetPackAvailableCard({
    required this.entry,
    required this.changelogEntries,
  });

  final AssetPackDistributionEntry entry;
  final List<AssetPackDistributionEntry> changelogEntries;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final sizeMiB = entry.archiveSizeBytes / (1024 * 1024);
    return Card.outlined(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: const Icon(Icons.download_for_offline_outlined),
        title: Text('Asset Pack v${entry.version} を利用できます'),
        subtitle: Text('ダウンロードサイズ: ${sizeMiB.toStringAsFixed(1)} MiB'),
        trailing: const Icon(Icons.chevron_right_rounded),
        contentPadding: EdgeInsets.symmetric(
          horizontal: designSystem.spacing.md,
          vertical: designSystem.spacing.xs,
        ),
        onTap: () async {
          final accepted = await showDialog<bool>(
            context: context,
            builder: (context) => _AssetPackConsentDialog(
              entry: entry,
              changelogEntries: changelogEntries,
            ),
          );
          if (accepted != true || !context.mounted) {
            return;
          }
          await AssetPackUpdateNotifier.installMutation.run(ref, (
            transaction,
          ) async {
            await transaction
                .get(assetPackUpdateProvider.notifier)
                .install(entry);
          });
        },
      ),
    );
  }
}

class _AssetPackConsentDialog extends StatelessWidget {
  const _AssetPackConsentDialog({
    required this.entry,
    required this.changelogEntries,
  });

  final AssetPackDistributionEntry entry;
  final List<AssetPackDistributionEntry> changelogEntries;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final changes = [
      for (final changelogEntry in changelogEntries)
        for (final section
            in changelogEntry.localization(languageCode: languageCode).sections)
          (version: changelogEntry.version, section: section),
    ];
    final sizeMiB = entry.archiveSizeBytes / (1024 * 1024);
    return AlertDialog(
      title: Text('Asset Pack v${entry.version}'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 420),
        child: SizedBox(
          width: 420,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: changes.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${sizeMiB.toStringAsFixed(1)} MiB をダウンロードします。'
                    '完了後に検証してからデータを切り替えます。',
                  ),
                );
              }
              final change = changes[index - 1];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'v${change.version} • ${change.section.title}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    ...change.section.items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text('• $item'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('あとで'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.download_rounded),
          label: const Text('ダウンロード'),
        ),
      ],
    );
  }
}

class _AssetPackInstallingCard extends StatelessWidget {
  const _AssetPackInstallingCard({required this.entry, required this.progress});

  final AssetPackDistributionEntry entry;
  final AssetPackInstallProgress progress;

  @override
  Widget build(BuildContext context) {
    final label = switch (progress.phase) {
      AssetPackInstallPhase.downloading =>
        'ダウンロード中 ${(progress.progress * 100).round()}%',
      AssetPackInstallPhase.verifying => 'ダウンロードを検証しています',
      AssetPackInstallPhase.extracting => '安全に展開しています',
      AssetPackInstallPhase.activating => 'データを切り替えています',
      AssetPackInstallPhase.completed => '更新が完了しました',
    };
    final determinateProgress =
        progress.phase == AssetPackInstallPhase.downloading
        ? progress.progress
        : null;
    return Card.outlined(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Asset Pack v${entry.version}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: determinateProgress),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _AssetPackMessageCard extends StatelessWidget {
  const _AssetPackMessageCard({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) => Card.outlined(
    margin: EdgeInsets.zero,
    child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(message),
    ),
  );
}

class _AssetPackErrorCard extends ConsumerWidget {
  const _AssetPackErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Card.outlined(
    margin: EdgeInsets.zero,
    child: ListTile(
      leading: const Icon(Icons.info_outline_rounded),
      title: const Text('Asset Pack の更新確認に失敗しました'),
      subtitle: Text(message),
      trailing: IconButton(
        tooltip: '再試行',
        icon: const Icon(Icons.refresh_rounded),
        onPressed: () => unawaited(
          AssetPackUpdateNotifier.checkMutation.run(
            ref,
            (transaction) =>
                transaction.get(assetPackUpdateProvider.notifier).check(),
          ),
        ),
      ),
    ),
  );
}
