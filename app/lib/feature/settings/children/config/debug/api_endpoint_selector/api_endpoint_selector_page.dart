import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/env/env.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ApiEndpointSelectorPage extends ConsumerWidget {
  const ApiEndpointSelectorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultUrl = Env.restApiUrl;
    final developUrl = defaultUrl.replaceAll('api.', 'dev.api.');
    final state = ref.watch(telegramUrlProvider.select((v) => v.restApiUrl));
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Endpoint Selector'),
      ),
      body: ListView(
        children: [
          RadioListTile<String>.adaptive(
            title: const Text('Default'),
            subtitle: Text(defaultUrl),
            value: defaultUrl,
            groupValue: state,
            onChanged: (value) {
              ref.read(telegramUrlProvider.notifier).updateRestUrl(value!);
            },
          ),
          RadioListTile.adaptive(
            title: const Text('DEV'),
            value: developUrl,
            subtitle: Text(developUrl),
            groupValue: state,
            onChanged: (value) {
              ref.read(telegramUrlProvider.notifier).updateRestUrl(value!);
            },
          ),
        ],
      ),
    );
  }
}
