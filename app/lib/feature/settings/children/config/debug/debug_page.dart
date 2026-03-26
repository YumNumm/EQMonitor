import 'dart:io';

import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/util/env.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_notifier.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hypocenter_icon/hypocenter_icon_page.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification/data/provider/notification_token_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_page.g.dart';

/// GoogleSignIn を初期化するプロバイダー（一度だけ実行される）
@riverpod
Future<void> googleSignInInit(Ref ref) async {
  if (Platform.isIOS || Platform.isMacOS) {
    await GoogleSignIn.instance.initialize(
      clientId: Env.googleIosClientId,
    );
  } else {
    await GoogleSignIn.instance.initialize(
      serverClientId: Env.googleAndroidClientId,
    );
  }
}

class DebugPage extends ConsumerWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Page')),
      body: const _DebugWidget(),
    );
  }
}

class _DebugWidget extends ConsumerWidget {
  const _DebugWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDebugEnabled = ref.watch(debugProvider).requireValue;
    final notificationToken = ref.watch(notificationTokenStreamProvider).value;
    final sessionToken = ref.watch(authProvider).value;

    return ListTileTheme(
      dense: true,
      child: ListView(
        children: [
          SwitchListTile(
            title: const Text('デバッグモード'),
            subtitle: Text(isDebugEnabled ? 'ON' : 'OFF'),
            value: isDebugEnabled,
            onChanged: (value) async =>
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
            onTap: () async => const TalkerRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('REST APIエンドポイント'),
            leading: const Icon(Icons.http),
            subtitle: Text(
              ref.watch(telegramUrlProvider).requireValue.restApiUrl,
            ),
            onTap: () async =>
                const HttpApiEndpointSelectorRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('WebSocketエンドポイント'),
            leading: const Icon(Icons.http),
            subtitle: Text(
              ref.watch(telegramUrlProvider).requireValue.wsApiUrl,
            ),
            onTap: () async =>
                const WebsocketEndpointSelectorRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('KyoshinMonitor'),
            leading: const Icon(Icons.list),
            onTap: () async => const DebugKyoshinMonitorRoute().push(context),
          ),
          ListTile(
            title: const Text('JmaMap'),
            leading: const Icon(Icons.map),
            onTap: () async => const DebugJmaMapRoute().push(context),
          ),
          ListTile(
            title: const Text('NIED'),
            leading: const Icon(Icons.science),
            onTap: () async => const NiedRoute().push(context),
          ),
          ListTile(
            title: const Text('Playground'),
            leading: const Icon(Icons.list),
            onTap: () async => const PlaygroundRoute().push(context),
          ),
          ListTile(
            title: const Text('地震リプレイ'),
            leading: const Icon(Icons.play_circle),
            onTap: () async => const EarthquakeReplayRoute().push(context),
          ),
          ListTile(
            title: const Text('震源アイコン生成'),
            leading: const Icon(Icons.place),
            onTap: () async => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const HypocenterIconPage(),
              ),
            ),
          ),
          ListTile(
            title: const Text('デバイス・通知'),
            subtitle: const Text('登録・トークン同期・設定・テスト通知・履歴'),
            leading: const Icon(Icons.phonelink_setup),
            onTap: () async => const DebugDeviceSettingsRoute().push<void>(
              context,
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text('認証情報'),
            leading: Icon(Icons.lock),
          ),
          ListTile(
            title: const Text('セッショントークン'),
            subtitle: Text(
              sessionToken ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.notoSansMono),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () async => Clipboard.setData(
              ClipboardData(text: sessionToken ?? ''),
            ),
          ),
          _GoogleSignInTile(),
          _SignOutTile(),
          const Divider(),
          ListTile(
            title: const Text('FCM Token'),
            subtitle: Text(
              notificationToken?.fcmToken?.toString() ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.notoSansMono),
            ),
            onTap: () async => Clipboard.setData(
              ClipboardData(text: notificationToken?.fcmToken ?? ''),
            ),
          ),
          ListTile(
            title: const Text('APNS Token'),
            subtitle: Text(
              notificationToken?.apnsToken?.toString() ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.notoSansMono),
            ),
            onTap: () async => Clipboard.setData(
              ClipboardData(text: notificationToken?.apnsToken ?? ''),
            ),
          ),
          ListTile(
            title: const Text('Push To Start Token'),
            subtitle: Text(
              notificationToken?.apnsPushToStartToken?.toString() ?? 'null',
              style: const TextStyle(fontFamily: FontFamily.notoSansMono),
            ),
            onTap: () async => Clipboard.setData(
              ClipboardData(
                text: notificationToken?.apnsPushToStartToken ?? '',
              ),
            ),
          ),
          ListTile(
            title: const Text('観測点パラメータ'),
            subtitle: Text(
              'Earthquake: ${ref.watch(jmaParameterProvider).value?.earthquake.header.version ?? 'null'}\n'
              'Tsunami   : ${ref.watch(jmaParameterProvider).value?.tsunami.header.version ?? 'null'}',
              style: const TextStyle(fontFamily: FontFamily.notoSansMono),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoogleSignInTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(AuthNotifier.signInWithGoogleMutation);
    final isPending = state is MutationPending;

    return ListTile(
      title: const Text('Google Sign-in'),
      leading: const Icon(Icons.login),
      trailing: isPending
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
            )
          : null,
      subtitle: switch (state) {
        MutationError(:final error) => Text(
          error.toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        MutationSuccess() => const Text('サインイン成功'),
        _ => null,
      },
      onTap: isPending
          ? null
          : () => AuthNotifier.signInWithGoogleMutation.run(ref, (tsx) async {
              await tsx.get(googleSignInInitProvider.future);
              final account = await GoogleSignIn.instance.authenticate();
              final idToken = account.authentication.idToken;
              if (idToken == null) {
                throw Exception('Google idToken が取得できませんでした');
              }
              await tsx
                  .get(authProvider.notifier)
                  .signInWithGoogle(idToken: idToken);
            }),
    );
  }
}

class _SignOutTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(AuthNotifier.signOutMutation);
    final isPending = state is MutationPending;

    return ListTile(
      title: const Text('サインアウト'),
      leading: const Icon(Icons.logout),
      trailing: isPending
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
            )
          : null,
      subtitle: switch (state) {
        MutationError(:final error) => Text(
          error.toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        MutationSuccess() => const Text('サインアウト完了'),
        _ => null,
      },
      onTap: isPending
          ? null
          : () => AuthNotifier.signOutMutation.run(ref, (tsx) async {
              await tsx.get(authProvider.notifier).signOut();
              await GoogleSignIn.instance.signOut();
            }),
    );
  }
}
