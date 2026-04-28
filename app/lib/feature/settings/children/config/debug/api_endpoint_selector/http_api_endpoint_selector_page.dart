import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HttpApiEndpointSelectorPage extends ConsumerWidget {
  const HttpApiEndpointSelectorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultUrl = ref.watch(buildConfigProvider).restApiUrl;
    final developUrl = defaultUrl.replaceAll('api.', 'dev.api.');
    final state = ref.watch(telegramUrlProvider.select((v) => v.requireValue.restApiUrl));
    return Scaffold(
      appBar: AppBar(title: const Text('API Endpoint Selector')),
      body: Column(
        children: [
          BorderedContainer(
            child: RadioGroup(
              onChanged: (value) async =>
                  ref.read(telegramUrlProvider.notifier).updateRestUrl(value!),
              groupValue: state,
              child: Column(
                children: [
                  RadioListTile<String>.adaptive(
                    title: const Text('[HTTP API] Default'),
                    subtitle: Text(defaultUrl),
                    value: defaultUrl,
                  ),
                  RadioListTile.adaptive(
                    title: const Text('[HTTP API] DEV'),
                    value: developUrl,
                    subtitle: Text(developUrl),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
