import 'dart:async';

import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

/// アプリ起動時に認証状態を確認し、
/// 未ログインであれば匿名認証を行うスプラッシュ画面。
class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mutationState = ref.watch(AuthNotifier.signInAnonymouslyMutation);

    void signInAnonymously() {
      unawaited(
        AuthNotifier.signInAnonymouslyMutation.run(
          ref,
          (tsx) async {
            await tsx.get(authProvider.notifier).signInAnonymously();
          },
        ),
      );
    }

    useEffect(
      () {
        Future<void> checkAuth() async {
          final token = await ref.read(authProvider.future);
          if (!context.mounted) {
            return;
          }
          if (token != null) {
            const HomeRoute().go(context);
            return;
          }
          signInAnonymously();
        }

        unawaited(checkAuth());
        return null;
      },
      [],
    );

    void skipAuth() => const HomeRoute().go(context);

    ref.listen(AuthNotifier.signInAnonymouslyMutation, (prev, next) {
      if (next is MutationSuccess) {
        const HomeRoute().go(context);
      }
    });

    return Scaffold(
      body: Center(
        child: switch (mutationState) {
          MutationIdle() ||
          MutationPending() ||
          MutationSuccess() => const CircularProgressIndicator.adaptive(),
          MutationError(:final error) => _AuthErrorView(
            error: error,
            onRetry: signInAnonymously,
            onSkip: skipAuth,
          ),
        },
      ),
    );
  }
}

class _AuthErrorView extends StatelessWidget {
  const _AuthErrorView({
    required this.error,
    required this.onRetry,
    required this.onSkip,
  });

  final Object error;
  final VoidCallback onRetry;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text('認証に失敗しました', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('再試行'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onSkip,
            child: const Text('スキップ'),
          ),
        ],
      ),
    );
  }
}
