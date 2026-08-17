import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum _ServerPreset { prod, dev, stub, custom }

class HttpApiEndpointSelectorPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildCfg = ref.watch(buildConfigProvider);
    final current = ref.watch(
      telegramUrlProvider.select((v) => v.requireValue),
    );

    final prodRest = buildCfg.restApiUrl;
    final prodWs = buildCfg.wsApiUrl;
    final devRest = prodRest.replaceAll('v2.api.', 'dev.v2.api.');
    final devWs = prodWs.replaceAll('websocket.', 'dev.websocket.');
    const stubRest = 'https://stub.api.eqmonitor.app';
    final stubWs = devWs;

    _ServerPreset selectedPreset;
    if (current.restApiUrl == prodRest && current.wsApiUrl == prodWs) {
      selectedPreset = _ServerPreset.prod;
    } else if (current.restApiUrl == devRest && current.wsApiUrl == devWs) {
      selectedPreset = _ServerPreset.dev;
    } else if (current.restApiUrl == stubRest) {
      selectedPreset = _ServerPreset.stub;
    } else {
      selectedPreset = _ServerPreset.custom;
    }

    Future<void> selectPreset(_ServerPreset preset) async {
      final (String rest, String ws) = switch (preset) {
        .prod => (prodRest, prodWs),
        .dev => (devRest, devWs),
        .stub => (stubRest, stubWs),
        .custom => (current.restApiUrl, current.wsApiUrl),
      };
      await ref
          .read(telegramUrlProvider.notifier)
          .updateServer(restApiUrl: rest, wsApiUrl: ws);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('サーバ選択')),
      body: ListView(
        children: [
          _ServerTile(
            label: 'Prod',
            description: '本番サーバ',
            restUrl: prodRest,
            wsUrl: prodWs,
            selected: selectedPreset == _ServerPreset.prod,
            onTap: () => selectPreset(_ServerPreset.prod),
            accentColor: Colors.green,
          ),
          _ServerTile(
            label: 'Dev',
            description: '開発サーバ',
            restUrl: devRest,
            wsUrl: devWs,
            selected: selectedPreset == _ServerPreset.dev,
            onTap: () => selectPreset(_ServerPreset.dev),
            accentColor: Colors.blue,
          ),
          _ServerTile(
            label: 'Stub',
            description: 'API スタブ（固定レスポンス）',
            restUrl: stubRest,
            wsUrl: stubWs,
            selected: selectedPreset == _ServerPreset.stub,
            onTap: () => selectPreset(_ServerPreset.stub),
            accentColor: Colors.orange,
          ),
          if (selectedPreset == _ServerPreset.custom)
            _ServerTile(
              label: 'Custom',
              description: 'カスタム設定',
              restUrl: current.restApiUrl,
              wsUrl: current.wsApiUrl,
              selected: true,
              onTap: null,
              accentColor: Colors.purple,
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
    required this.wsUrl,
    required this.selected,
    required this.onTap,
    required this.accentColor,
  });

  final String label;
  final String description;
  final String restUrl;
  final String wsUrl;
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
              shape: BoxShape.circle,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: selected ? accentColor : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                _UrlRow(icon: Icons.http, label: 'REST', url: restUrl),
                const SizedBox(height: 2),
                _UrlRow(icon: Icons.wifi, label: 'WS', url: wsUrl),
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
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            url,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.designSystem.colorTheme.onSurfaceVariant,
              fontFamily: 'monospace',
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
