import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/env/env.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebSocketApiEndpointSelectorPage extends ConsumerWidget {
  const WebSocketApiEndpointSelectorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultUrl = Env.wsApiUrl;
    final developUrl = defaultUrl.replaceAll('api.', 'dev.api.');
    final state = ref.watch(telegramUrlProvider.select((v) => v.wsApiUrl));
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Endpoint Selector'),
      ),
      body: Column(
        children: [
          BorderedContainer(
            child: Column(
              children: [
                RadioListTile<String>.adaptive(
                  title: const Text('[WebSocket API] Production Endpoint'),
                  subtitle: Text(defaultUrl),
                  value: defaultUrl,
                  groupValue: state,
                  onChanged: (value) {
                    ref
                        .read(telegramUrlProvider.notifier)
                        .updateWebSocketUrl(value!);
                  },
                ),
                RadioListTile.adaptive(
                  title: const Text('[WebSocket API] Development Endpoint'),
                  value: developUrl,
                  subtitle: Text(developUrl),
                  groupValue: state,
                  onChanged: (value) {
                    ref
                        .read(telegramUrlProvider.notifier)
                        .updateWebSocketUrl(value!);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
