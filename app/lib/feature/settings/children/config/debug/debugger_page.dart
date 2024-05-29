import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/home/component/kmoni/kmoni_settings_dialog.dart';
import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebuggerPage extends ConsumerWidget {
  const DebuggerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debugger'),
      ),
      body: ListView(
        children: const [
          _DebugWidget(),
        ],
      ),
    );
  }
}

class _DebugWidget extends ConsumerWidget {
  const _DebugWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(4),
      elevation: 1,
      shadowColor: Colors.transparent,
      // 角丸にして Border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.dividerColor.withOpacity(0.6),
          width: 0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetHeader(title: 'デバッグメニュー'),
            ListTile(
              title: const Text('ログ'),
              leading: const Icon(Icons.list),
              onTap: () => context.push(const TalkerRoute().location),
            ),
            ListTile(
              title: const Text('強震モニタ'),
              leading: const Icon(Icons.settings),
              onTap: () => showDialog<void>(
                context: context,
                builder: (context) => const KmoniSettingsModal(),
              ),
            ),
            ListTile(
              title: const Text('重大な通知権限'),
              leading: const Icon(Icons.notifications_active),
              onTap: () async {
                {
                  final result =
                      await FirebaseMessaging.instance.requestPermission(
                    criticalAlert: true,
                  );
                  if (context.mounted) {
                    await showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('重大な通知権限 (FirebaseMessaging)'),
                        content: Text(result.toString()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
            ),
            ListTile(
              title: const Text('REST APIエンドポイント'),
              leading: const Icon(Icons.http),
              subtitle: Text(ref.watch(telegramUrlProvider).restApiUrl),
              onTap: () => const ApiEndpointSelectorRoute().push<void>(context),
            ),
            ListTile(
              title: const Text('WebSocketエンドポイント'),
              leading: const Icon(Icons.http),
              subtitle: Text(ref.watch(telegramUrlProvider).wsApiUrl),
            ),
            ListTile(
              title: const Text('Earthquake Parameter'),
              leading: const Icon(Icons.settings),
              onTap: () =>
                  const EarthquakeParameterListRoute().push<void>(context),
            ),
            ListTile(
              title: const Text('揺れ検知通知 購読'),
              leading: const Icon(Icons.notifications_active),
              onTap: () async {
                try {
                  await FirebaseMessaging.instance.subscribeToTopic('kevi');
                } on Exception catch (e) {
                  if (context.mounted) {
                    await showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('揺れ検知通知 購読エラー'),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
                if (context.mounted) {
                  await showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('揺れ検知通知 購読結果'),
                      content: const Text('OK'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            SwitchListTile.adaptive(
              value: ref.watch(isDioProxyEnabledProvider),
              onChanged: (value) => ref
                  .read(isDioProxyEnabledProvider.notifier)
                  .set(value: value),
              title: const Text('Dio Proxy'),
              subtitle: const Text('macbook-pro:9090へのPROXY'),
            ),
            BorderedContainer(
              child: Column(
                children:
                    ref.watch(goRouterProvider).configuration.routes.map((e) {
                  final route = e as GoRoute;
                  return _Route(
                    routes: [route],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Route extends StatelessWidget {
  const _Route({
    required this.routes,
    this.depth = 0,
    this.parent = const [],
  });

  final List<GoRoute> routes;
  final int depth;
  final List<GoRoute> parent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: routes.map(
        (route) {
          if (route.routes.isNotEmpty) {
            return _Route(
              routes: route.routes.cast<GoRoute>(),
              depth: depth + 1,
              parent: [...parent, route],
            );
          }
          return ListTile(
            title: Text([...parent, route].map((e) => e.path).join('/')),
            onTap: () => context.push(
              [...parent, route].map((e) => e.path).join('/'),
            ),
            visualDensity: VisualDensity.compact,
          );
        },
      ).toList(),
    );
  }
}
