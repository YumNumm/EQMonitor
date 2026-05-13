import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_credentials_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KnetWaveformPage extends ConsumerWidget {
  const KnetWaveformPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credentials = ref.watch(knetCredentialsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('K-NET 強震波形'),
      ),
      body: credentials.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
        data: (data) {
          if (data == null) {
            return _UnconfiguredView(
              onSetup: () =>
                  const KnetCredentialsSettingsRoute().push<void>(context),
            );
          }
          return _ConfiguredView(
            userId: data.userId,
            onBrowse: () => const KnetEarthquakeListRoute().push<void>(context),
          );
        },
      ),
    );
  }
}

class _UnconfiguredView extends StatelessWidget {
  const _UnconfiguredView({required this.onSetup});

  final VoidCallback onSetup;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'BOSAI 認証情報が未設定です',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '防災科研の強震波形データをダウンロードするには、'
              ' 事前に NIED のサイトでユーザー登録を行い、'
              ' 認証情報を設定してください。',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onSetup,
              icon: const Icon(Icons.settings),
              label: const Text('認証情報を設定する'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfiguredView extends StatelessWidget {
  const _ConfiguredView({
    required this.userId,
    required this.onBrowse,
  });

  final String userId;
  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sensors,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'K-NET/KiK-net 強震観測網',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'ユーザー: $userId',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onBrowse,
              icon: const Icon(Icons.list_alt),
              label: const Text('地震データを閲覧'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () =>
                  const KnetCredentialsSettingsRoute().push<void>(context),
              icon: const Icon(Icons.settings),
              label: const Text('認証設定'),
            ),
          ],
        ),
      ),
    );
  }
}
