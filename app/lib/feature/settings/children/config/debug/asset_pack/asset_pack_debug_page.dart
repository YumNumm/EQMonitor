import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/util/byte_size_formatter.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_repository.dart';
import 'package:material_ui/material_ui.dart';
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
            tooltip: '診断を再読込',
            onPressed: () =>
                ref.invalidate(assetPackDebugInfoProvider, asReload: true),
          ),
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(visualDensity: .compact),
        child: ListTileTheme(
          dense: true,
          child: switch (infoAsync) {
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
            AsyncData(:final value) => _AssetPackDebugContent(info: value),
          },
        ),
      ),
    );
  }
}

class _AssetPackDebugContent extends StatelessWidget {
  const _AssetPackDebugContent({required this.info});

  final AssetPackDebugInfo info;

  @override
  Widget build(BuildContext context) {
    final diagnostics = info.diagnostics;
    final statusLabel = switch (diagnostics.status) {
      AssetPackDiagnosticStatus.ready => '利用可能',
      AssetPackDiagnosticStatus.unsupportedOs => '未対応OS',
      AssetPackDiagnosticStatus.manifestUrlResolutionFailed =>
        'manifest URL解決失敗',
      AssetPackDiagnosticStatus.manifestMissing => 'manifestなし',
      AssetPackDiagnosticStatus.manifestUnreadable => 'manifest読込失敗',
      AssetPackDiagnosticStatus.manifestInvalid => 'manifest不正',
      AssetPackDiagnosticStatus.assetMissing => 'asset不足',
      AssetPackDiagnosticStatus.assetSizeMismatch => 'assetサイズ不一致',
    };
    final availabilityLabel = switch (diagnostics.systemAvailability) {
      AssetPackSystemAvailability.available => 'available',
      AssetPackSystemAvailability.unavailable => 'unavailable',
      AssetPackSystemAvailability.apiUnavailable => 'API unavailable',
    };
    final isReady = diagnostics.status == AssetPackDiagnosticStatus.ready;
    final statusColor = isReady
        ? context.designSystem.colorTheme.onSurface
        : context.designSystem.colorTheme.error;
    final nativeError = diagnostics.nativeError;
    final manifest = info.manifest;

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
        _CopyableTile(title: 'system_availability', value: availabilityLabel),
        if (diagnostics.manifestUrl case final value?)
          _CopyableTile(title: 'manifest_url', value: value),
        if (diagnostics.packRoot case final value?)
          _CopyableTile(title: 'pack_root', value: value),
        if (nativeError != null) ...[
          const Divider(),
          _CopyableTile(title: 'error_domain', value: nativeError.domain),
          _CopyableTile(title: 'error_code', value: '${nativeError.code}'),
          _CopyableTile(
            title: 'error_description',
            value: nativeError.description,
          ),
        ],
        if (info.manifestParseError case final value?)
          _CopyableTile(title: 'manifest_parse_error', value: value),
        if (manifest != null) ...[
          const Divider(),
          _CopyableTile(title: 'pack_version', value: manifest.packVersion),
          _CopyableTile(
            title: 'schema_version',
            value: '${manifest.schemaVersion}',
          ),
          _CopyableTile(title: 'generated_at', value: manifest.generatedAt),
        ],
        const Divider(),
        ListTile(
          title: Text(
            'Assets (${info.assets.length})',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        if (info.assets.isEmpty)
          const ListTile(subtitle: Text('asset情報はまだ取得できていません')),
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
    const formatter = ByteSizeFormatter();
    final diagnostic = status.diagnostic;
    final item = status.item;
    final colorTheme = context.designSystem.colorTheme;
    final isReady = diagnostic.status == AssetPackFileDiagnosticStatus.ready;
    final stateLabel = switch (diagnostic.status) {
      AssetPackFileDiagnosticStatus.ready => 'OK',
      AssetPackFileDiagnosticStatus.resolutionFailed => 'パス解決失敗',
      AssetPackFileDiagnosticStatus.missing => 'ファイルなし',
      AssetPackFileDiagnosticStatus.sizeMismatch => 'サイズ不一致',
    };
    final expectedSize = diagnostic.expectedSizeBytes;
    final actualSize = diagnostic.actualSizeBytes;
    final sizeEvidence =
        '期待: ${expectedSize == null ? '-' : formatter.format(expectedSize)} / '
        '実際: ${actualSize == null ? '-' : formatter.format(actualSize)}';
    final resolvedUrl = diagnostic.resolvedUrl;
    final nativeError = diagnostic.nativeError;
    final resolutionEvidence = [
      if (resolvedUrl != null) 'resolved_url: $resolvedUrl',
      if (nativeError != null)
        'native_error: ${nativeError.domain} (${nativeError.code}) '
            '${nativeError.description}',
    ].join('\n');

    return ListTile(
      isThreeLine: true,
      leading: Icon(
        isReady ? Icons.check_circle_outline : Icons.error_outline,
        color: isReady
            ? colorTheme.onSurface.withValues(alpha: 0.7)
            : colorTheme.error,
      ),
      title: Text(item?.id.name ?? diagnostic.path),
      subtitle: Text(
        'path: ${diagnostic.path}\n[$stateLabel] $sizeEvidence\n'
        'exists: ${diagnostic.exists}'
        '${resolutionEvidence.isEmpty ? '' : '\n$resolutionEvidence'}',
        style: const TextStyle(fontFamily: FontFamily.googleSansCode),
      ),
      onLongPress: () async {
        await Clipboard.setData(ClipboardData(text: diagnostic.path));
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('asset path をコピーしました')));
        }
      },
    );
  }
}

class _CopyableTile extends StatelessWidget {
  const _CopyableTile({required this.title, required this.value});

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
