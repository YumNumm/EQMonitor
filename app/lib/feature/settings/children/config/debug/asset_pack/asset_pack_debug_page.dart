import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final statusLabel = switch (diagnostics.status) {
      AssetPackDiagnosticStatus.ready => '利用可能',
      AssetPackDiagnosticStatus.manifestMissing => 'manifestなし',
    };
    final isReady = diagnostics.status == AssetPackDiagnosticStatus.ready;
    final statusColor = isReady
        ? context.designSystem.colorTheme.onSurface
        : context.designSystem.colorTheme.error;

    return ListView(
      children: [
        ListTile(
          leading: Icon(
            isReady ? Icons.check_circle_outline : Icons.error_outline,
            color: statusColor,
          ),
          title: Text(statusLabel),
          subtitle: Text(diagnostics.detail),
        ),
        _CopyableTile(title: 'status', value: diagnostics.status.name),
        _CopyableTile(title: 'platform', value: diagnostics.platform),
        _CopyableTile(title: 'os_version', value: diagnostics.osVersion),
        _CopyableTile(title: 'pack_id', value: diagnostics.packIdentifier),
        if (diagnostics.packRoot case final value?)
          _CopyableTile(title: 'pack_root', value: value),
      ],
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
