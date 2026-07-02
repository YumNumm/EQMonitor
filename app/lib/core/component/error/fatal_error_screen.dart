import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FatalErrorScreen extends StatelessWidget {
  const FatalErrorScreen({required this.error, super.key});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text('問題が発生しました', style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                'お手数ですが、アプリを再操作してください。',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              if (kDebugMode && error != null) ...[
                const SizedBox(height: 16),
                Text(
                  '$error',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => const HomeRoute().go(context),
                icon: const Icon(Icons.home_rounded),
                label: const Text('ホームへ戻る'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [ErrorWidget.builder] 用。MaterialApp 祖先が無い状況でも安全に描画する。
Widget buildFatalErrorWidget(FlutterErrorDetails details) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      color: const Color(0xFF1C1B1F),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 40,
            color: Color(0xFFB0AEB8),
          ),
          const SizedBox(height: 12),
          const Text(
            '問題が発生しました',
            style: TextStyle(color: Color(0xFFE6E1E5), fontSize: 16),
          ),
          if (kDebugMode) ...[
            const SizedBox(height: 8),
            Text(
              '${details.exception}',
              style: const TextStyle(color: Color(0xFFB0AEB8), fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    ),
  );
}
