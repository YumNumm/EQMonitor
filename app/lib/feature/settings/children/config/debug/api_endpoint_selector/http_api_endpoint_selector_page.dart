import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/api_endpoint_selector/custom_api_endpoint_dialog.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

enum _ServerPreset { prod, dev, stub, custom }

class HttpApiEndpointSelectorPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildCfg = ref.watch(buildConfigProvider);
    final current = ref.watch(
      telegramUrlProvider.select((v) => v.requireValue),
    );
    final isSaving = ref.watch(TelegramUrl.updateMutation) is MutationPending;

    final prodRest = buildCfg.restApiUrl;
    final prodWs = buildCfg.wsApiUrl;
    final devRest = prodRest.replaceAll('v2.api.', 'dev.v2.api.');
    final devWs = prodWs.replaceAll('websocket.', 'dev.websocket.');
    const stubRest = 'https://stub.api.eqmonitor.app';
    final stubWs = devWs;

    final selectedPreset = switch (current.restApiUrl) {
      final url when url == prodRest => _ServerPreset.prod,
      final url when url == devRest => _ServerPreset.dev,
      stubRest => _ServerPreset.stub,
      _ => _ServerPreset.custom,
    };

    Future<void> selectPreset(_ServerPreset preset) async {
      final (String rest, String ws) = switch (preset) {
        .prod => (prodRest, prodWs),
        .dev => (devRest, devWs),
        .stub => (stubRest, stubWs),
        .custom => (current.restApiUrl, current.wsApiUrl),
      };
      try {
        await TelegramUrl.updateMutation.run(
          ref,
          (tsx) => tsx
              .get(telegramUrlProvider.notifier)
              .updateServer(restApiUrl: rest, wsApiUrl: ws),
        );
        // ignore: avoid_catches_without_on_clauses
      } catch (error, stackTrace) {
        talker.error('API接続先の保存に失敗しました', error, stackTrace);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('接続先を保存できませんでした')),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('サーバ選択')),
      body: ListView(
        children: [
          _ServerTile(
            label: 'Prod',
            description: '本番サーバ',
            restUrl: prodRest,
            selected: selectedPreset == _ServerPreset.prod,
            onTap: isSaving ? null : () => selectPreset(_ServerPreset.prod),
            accentColor: Colors.green,
          ),
          _ServerTile(
            label: 'Dev',
            description: '開発サーバ',
            restUrl: devRest,
            selected: selectedPreset == _ServerPreset.dev,
            onTap: isSaving ? null : () => selectPreset(_ServerPreset.dev),
            accentColor: Colors.blue,
          ),
          _ServerTile(
            label: 'Stub',
            description: 'API スタブ（固定レスポンス）',
            restUrl: stubRest,
            selected: selectedPreset == _ServerPreset.stub,
            onTap: isSaving ? null : () => selectPreset(_ServerPreset.stub),
            accentColor: Colors.orange,
          ),
          _ServerTile(
            label: 'Custom',
            description: 'URLを手入力',
            restUrl: selectedPreset == _ServerPreset.custom
                ? current.restApiUrl
                : null,
            selected: selectedPreset == _ServerPreset.custom,
            onTap: isSaving
                ? null
                : () async {
                    TelegramUrl.updateMutation.reset(ref);
                    await showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => CustomApiEndpointDialog(
                        initialUrl: current.restApiUrl,
                      ),
                    );
                  },
            accentColor: Colors.purple,
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('WebSocketは選択したAPIが案内する接続先に自動で接続します。'),
          ),
        ],
      ),
    );
  }
}

class _ServerTile extends StatelessWidget {
  const new({
    required this.label,
    required this.description,
    required this.restUrl,
    required this.selected,
    required this.onTap,
    required this.accentColor,
  });

  final String label;
  final String description;
  final String? restUrl;
  final bool selected;
  final VoidCallback? onTap;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;
    return BorderedContainer(
      accentColor: null,
      elevation: 0,
      onPressed: onTap,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: .circle,
              color: selected ? accentColor : Colors.transparent,
              border: Border.all(
                color: selected ? accentColor : Colors.grey,
                width: 2,
              ),
            ),
            child: selected
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: .bold,
                        color: selected ? accentColor : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorTheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                if (restUrl case final url?) ...[
                  const SizedBox(height: 4),
                  _UrlRow(icon: Icons.http, label: 'REST', url: url),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UrlRow extends StatelessWidget {
  const new({required this.icon, required this.label, required this.url});

  final IconData icon;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: context.designSystem.colorTheme.outline),
        const SizedBox(width: 4),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.designSystem.colorTheme.outline,
            fontWeight: .w600,
          ),
        ),
        Expanded(
          child: Text(
            url,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.designSystem.colorTheme.onSurfaceVariant,
              fontFamily: 'monospace',
            ),
            overflow: .ellipsis,
          ),
        ),
      ],
    );
  }
}
