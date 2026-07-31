import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/util/byte_size_formatter.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_action.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class AssetPackDebugPage extends ConsumerWidget {
  const AssetPackDebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infoAsync = ref.watch(assetPackDebugInfoProvider);
    final updateState = ref.watch(AssetPackDebugAction.checkForUpdatesMutation);
    final lastUpdate = ref.watch(assetPackLastUpdateResultProvider);

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
                _UpdateSection(
                  updateState: updateState,
                  lastUpdate: lastUpdate,
                ),
                ListTile(
                  leading: const Icon(Icons.error_outline),
                  title: const Text('診断の取得に失敗'),
                  subtitle: Text(error.toString()),
                ),
              ],
            ),
            AsyncData(:final value) => _AssetPackDebugContent(
              info: value,
              updateState: updateState,
              lastUpdate: lastUpdate,
            ),
          },
        ),
      ),
    );
  }
}

class _AssetPackDebugContent extends StatelessWidget {
  const _AssetPackDebugContent({
    required this.info,
    required this.updateState,
    required this.lastUpdate,
  });

  final AssetPackDebugInfo info;
  final MutationState<AssetPackUpdateResult> updateState;
  final AssetPackUpdateResult? lastUpdate;

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
        _UpdateSection(updateState: updateState, lastUpdate: lastUpdate),
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

class _UpdateSection extends ConsumerWidget {
  const _UpdateSection({required this.updateState, required this.lastUpdate});

  final MutationState<AssetPackUpdateResult> updateState;
  final AssetPackUpdateResult? lastUpdate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPending = updateState is MutationPending;
    final nativeError = lastUpdate?.nativeError;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: FilledButton.tonalIcon(
            onPressed: isPending
                ? null
                : () async {
                    await ref
                        .read(assetPackDebugActionProvider)
                        .checkForUpdates(ref, context);
                  },
            icon: isPending
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.system_update_alt),
            label: Text(isPending ? '更新を確認中' : '更新を確認'),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('API応答はダウンロード完了を意味しません'),
        ),
        if (lastUpdate case final result?) ...[
          _CopyableTile(title: 'checked_at', value: result.checkedAt),
          _CopyableTile(
            title: 'updating_ids',
            value: result.updatingIdentifiers.join(', '),
          ),
          _CopyableTile(
            title: 'removed_ids',
            value: result.removedIdentifiers.join(', '),
          ),
          if (nativeError != null)
            _CopyableTile(
              title: 'update_error',
              value:
                  '${nativeError.domain} (${nativeError.code})\n'
                  '${nativeError.description}',
            ),
        ],
        const Divider(),
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
      AssetPackFileDiagnosticStatus.missing => 'ファイルなし',
      AssetPackFileDiagnosticStatus.sizeMismatch => 'サイズ不一致',
    };
    final expectedSize = diagnostic.expectedSizeBytes;
    final actualSize = diagnostic.actualSizeBytes;
    final sizeEvidence =
        '期待: ${expectedSize == null ? '-' : formatter.format(expectedSize)} / '
        '実際: ${actualSize == null ? '-' : formatter.format(actualSize)}';

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
        'exists: ${diagnostic.exists}',
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
