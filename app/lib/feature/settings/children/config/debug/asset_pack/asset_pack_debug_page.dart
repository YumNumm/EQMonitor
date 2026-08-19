import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_diagnostics.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_storage_repository.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_provider.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class AssetPackDebugPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diagnosticsAsync = ref.watch(assetPackDiagnosticsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Pack'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '診断を再読込',
            onPressed: () =>
                ref.invalidate(assetPackDiagnosticsProvider, asReload: true),
          ),
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(visualDensity: .compact),
        child: ListTileTheme(
          dense: true,
          child: switch (diagnosticsAsync) {
            AsyncLoading() => const Center(child: CircularProgressIndicator()),
            AsyncError(:final error) => ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.error_outline),
                  title: const Text('診断の取得に失敗'),
                  subtitle: Text(error.toString()),
                ),
              ],
            ),
            AsyncData(:final value) => _AssetPackDebugContent(
              diagnostics: value,
            ),
          },
        ),
      ),
    );
  }
}

class _AssetPackDebugContent extends StatelessWidget {
  const new({required this.diagnostics});

  final AssetPackDiagnostics diagnostics;

  @override
  Widget build(BuildContext context) {
    final isBundled = diagnostics.sourceKind == AssetPackSourceKind.bundled;
    final manifest = diagnostics.manifest;

    return ListView(
      children: [
        ListTile(
          leading: Icon(
            isBundled ? Icons.inventory_2_outlined : Icons.cloud_done_outlined,
            color: context.designSystem.colorTheme.onSurface,
          ),
          title: Text(isBundled ? 'アプリ同梱Pack' : 'ダウンロード済みPack'),
          subtitle: Text('${manifest.assets.length}個のアセットを読み込み可能'),
        ),
        _CopyableTile(title: 'pack_version', value: manifest.packVersion),
        _CopyableTile(title: 'generated_at', value: manifest.generatedAt),
        _CopyableTile(title: 'root', value: diagnostics.rootPath),
        _CopyableTile(
          title: 'bundled_root',
          value: diagnostics.bundledRootPath,
        ),
        const Divider(),
        for (final asset in manifest.assets) _AssetTile(asset: asset),
      ],
    );
  }
}

class _AssetTile extends StatelessWidget {
  const new({required this.asset});

  final AssetPackManifestItem asset;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(asset.id.name),
      subtitle: Text(
        '${asset.path}\n'
        '${asset.sizeBytes} bytes / source ${asset.sourceVersion}',
        style: const TextStyle(fontFamily: FontFamily.googleSansCode),
      ),
      isThreeLine: true,
    );
  }
}

class _CopyableTile extends StatelessWidget {
  const new({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: SelectableText(
        value.isEmpty ? '(none)' : value,
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
