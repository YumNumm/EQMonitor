import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/notification_token.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/util/env.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hypocenter_icon/hypocenter_icon_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/kyoshin_monitor/debug_kyoshin_monitor.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/playground/playground_page.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugPage extends ConsumerWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Page')),
      body: ListView(children: const [_DebugWidget()]),
    );
  }
}

class _DebugWidget extends ConsumerWidget {
  const _DebugWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDebugEnabled = ref.watch(debugProvider);

    return Card(
      margin: const EdgeInsets.all(4),
      elevation: 1,
      shadowColor: Colors.transparent,
      // 角丸にして Border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.dividerColor.withValues(alpha: 0.6),
          width: 0,
        ),
      ),
      child: ListTileTheme(
        dense: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SheetHeader(title: 'デバッグメニュー'),
              SwitchListTile(
                title: const Text('デバッグモード'),
                subtitle: Text(isDebugEnabled ? 'ON' : 'OFF'),
                value: isDebugEnabled,
                onChanged:
                    (value) async =>
                        ref.read(debugProvider.notifier).save(isEnabled: value),
              ),
              ListTile(
                title: const Text('Flavor'),
                leading: const Icon(Icons.flag),
                subtitle: Text(Env.flavor.name),
              ),
              ListTile(
                title: const Text('ログ'),
                leading: const Icon(Icons.list),
                onTap: () async => context.push(const TalkerRoute().location),
              ),
              ListTile(
                title: const Text('REST APIエンドポイント'),
                leading: const Icon(Icons.http),
                subtitle: Text(ref.watch(telegramUrlProvider).restApiUrl),
                onTap:
                    () async => const HttpApiEndpointSelectorRoute().push<void>(
                      context,
                    ),
              ),
              ListTile(
                title: const Text('WebSocketエンドポイント'),
                leading: const Icon(Icons.http),
                subtitle: Text(ref.watch(telegramUrlProvider).wsApiUrl),
                onTap:
                    () async => const WebsocketEndpointSelectorRoute()
                        .push<void>(context),
              ),
              ListTile(
                title: const Text('KyoshinMonitor'),
                leading: const Icon(Icons.list),
                onTap:
                    () async => const DebugKyoshinMonitorRoute().push(context),
              ),
              ListTile(
                title: const Text('Playground'),
                leading: const Icon(Icons.list),
                onTap: () async => const PlaygroundRoute().push(context),
              ),
              ListTile(
                title: const Text('震源アイコン生成'),
                leading: const Icon(Icons.place),
                onTap:
                    () async => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => const HypocenterIconPage(),
                      ),
                    ),
              ),
              ListTile(
                title: const Text('FCM Token'),
                subtitle: Text(
                  ref
                          .watch(notificationTokenProvider)
                          .valueOrNull
                          ?.fcmToken
                          ?.toString() ??
                      'null',
                ),
                onTap: () async {
                  final token = await FirebaseMessaging.instance.getToken();
                  await Clipboard.setData(ClipboardData(text: token ?? ''));
                },
              ),
              BorderedContainer(
                child: Column(
                  children:
                      ref.watch(goRouterProvider).configuration.routes.map((e) {
                        final route = e as GoRoute;
                        return _Route(routes: [route]);
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Route extends StatelessWidget {
  const _Route({required this.routes, this.parent = const []});

  final List<GoRoute> routes;
  final List<GoRoute> parent;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      dense: true,
      child: Column(
        children:
            routes.map((route) {
              final currentPath = [...parent, route];
              if (route.routes.isEmpty) {
                final path = [...parent, route].map((e) => e.path).join('/');

                return ListTile(
                  title: Text(path),
                  onTap: () async => context.push(path),
                );
              }

              return _Route(
                routes: route.routes.whereType<GoRoute>().toList(),
                parent: currentPath,
              );
            }).toList(),
      ),
    );
  }
}
