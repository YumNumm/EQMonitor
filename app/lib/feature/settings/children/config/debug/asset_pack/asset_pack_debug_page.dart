import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/util/byte_size_formatter.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssetPackDebugPage extends ConsumerWidget {
  const AssetPackDebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infoAsync = ref.watch(assetPackDebugInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Pack'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '再読込',
            onPressed: () =>
                ref.invalidate(assetPackDebugInfoProvider),
          ),
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(visualDensity: .compact),
        child: ListTileTheme(
          dense: true,
          child: switch (infoAsync) {
            AsyncLoading() => const Center(child: CircularProgressIndicator()),
            AsyncError(:final error) => _NotReady(error: error),
            AsyncData(:final value) => _AssetPackDebugContent(info: value),
          },
        ),
      ),
    );
  }
}

class _NotReady extends StatelessWidget {
  const _NotReady({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final message = error is AssetPackNotReadyException
        ? (error as AssetPackNotReadyException).message
        : error.toString();
    return ListView(
      children: [
        const ListTile(
          leading: Icon(Icons.download_for_offline_outlined),
          title: Text('Asset Pack 未取得'),
          subtitle: Text('Pack がダウンロードされていないか、破損しています'),
        ),
        ListTile(
          title: const Text('詳細'),
          subtitle: Text(
            message,
            style: const TextStyle(fontFamily: FontFamily.googleSansCode),
          ),
        ),
      ],
    );
  }
}

class _AssetPackDebugContent extends StatelessWidget {
  const _AssetPackDebugContent({required this.info});

  final AssetPackDebugInfo info;

  @override
  Widget build(BuildContext context) {
    final manifest = info.manifest;
    return ListView(
      children: [
        _CopyableTile(
          leading: const Icon(Icons.inventory_2_outlined),
          title: 'pack_version',
          value: manifest.packVersion,
        ),
        _CopyableTile(
          leading: const Icon(Icons.schema_outlined),
          title: 'schema_version',
          value: '${manifest.schemaVersion}',
        ),
        _CopyableTile(
          leading: const Icon(Icons.schedule),
          title: 'generated_at',
          value: manifest.generatedAt,
        ),
        _CopyableTile(
          leading: const Icon(Icons.folder_outlined),
          title: 'pack root',
          value: info.packRoot,
        ),
        const Divider(),
        ListTile(
          title: Text(
            'Assets (${info.assets.length})',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        for (final status in info.assets) _AssetTile(status: status),
      ],
    );
  }
}

class _AssetTile extends StatelessWidget {
  const _AssetTile({required this.status});

  final AssetPackAssetFileStatus status;

  @override
  Widget build(BuildContext context) {
    final item = status.item;
    const formatter = ByteSizeFormatter();
    final colorTheme = context.designSystem.colorTheme;

    final String fileState;
    final Color fileStateColor;
    if (!status.exists) {
      fileState = 'ファイルなし';
      fileStateColor = colorTheme.error;
    } else if (!status.sizeMatches) {
      fileState =
          'サイズ不一致 (期待 ${formatter.format(item.sizeBytes)} / '
          '実際 ${formatter.format(status.actualSizeBytes ?? 0)})';
      fileStateColor = colorTheme.error;
    } else {
      fileState = 'OK';
      fileStateColor = colorTheme.onSurface.withValues(alpha: 0.7);
    }

    return ListTile(
      isThreeLine: true,
      leading: Icon(
        status.exists && status.sizeMatches
            ? Icons.check_circle_outline
            : Icons.error_outline,
        color: fileStateColor,
      ),
      title: Text(item.id.name),
      subtitle: Text(
        'path: ${item.path}\n'
        'size: ${formatter.format(item.sizeBytes)} (${item.sizeBytes} B)  '
        '[$fileState]\n'
        'source_version: ${item.sourceVersion}  '
        'updated: ${item.sourceUpdatedAt ?? '-'}\n'
        'sha256: ${item.sha256.substring(0, 16)}…',
        style: const TextStyle(fontFamily: FontFamily.googleSansCode),
      ),
      onLongPress: () async {
        await Clipboard.setData(ClipboardData(text: item.sha256));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${item.id.name} の sha256 をコピーしました')),
          );
        }
      },
    );
  }
}

class _CopyableTile extends StatelessWidget {
  const _CopyableTile({
    required this.title,
    required this.value,
    this.leading,
  });

  final String title;
  final String value;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title),
      subtitle: Text(
        value,
        style: const TextStyle(fontFamily: FontFamily.googleSansCode),
      ),
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: value));
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('$title をコピーしました')));
        }
      },
    );
  }
}
