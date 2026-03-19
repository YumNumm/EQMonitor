import 'dart:async';

import 'package:eqmonitor/core/auth/auth_client_provider.dart';
import 'package:eqmonitor/core/auth/auth_notifier.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

/// アプリ起動時に認証状態を確認し、
/// 未ログインであれば匿名認証を行うスプラッシュ画面。
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    unawaited(_checkAuth());
  }

  Future<void> _checkAuth() async {
    final token = await ref.read(authProvider.future);
    if (!mounted) {
      return;
    }

    if (token != null) {
      // 既にセッションがある → ホームへ遷移
      const HomeRoute().go(context);
      return;
    }

    // セッションが無い → 匿名認証を実行
    _signInAnonymously();
  }

  void _signInAnonymously() {
    unawaited(
      AuthNotifier.signInAnonymously.run(ref, (tsx) async {
        final apiClient = tsx.get(authApiClientProvider);
        final tokenStore = tsx.get(authTokenStoreProvider);

        final response = await apiClient.anonymous.postSignInAnonymous();
        final session = response.data.session;
        await tokenStore.saveToken(session.token);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mutationState = ref.watch(AuthNotifier.signInAnonymously);

    // 匿名認証が成功したらホームへ遷移
    ref.listen(AuthNotifier.signInAnonymously, (prev, next) {
      if (next is MutationSuccess) {
        const HomeRoute().go(context);
      }
    });

    return Scaffold(
      body: Center(
        child: switch (mutationState) {
          MutationIdle() ||
          MutationPending() ||
          MutationSuccess() =>
            const CircularProgressIndicator.adaptive(),
          MutationError(:final error) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    '認証に失敗しました',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _signInAnonymously,
                    icon: const Icon(Icons.refresh),
                    label: const Text('再試行'),
                  ),
                ],
              ),
            ),
        },
      ),
    );
  }
}
