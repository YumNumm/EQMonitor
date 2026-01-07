import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    required this.onNext,
    super.key,
  });

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(flex: 2),
            // アプリアイコン
            _AppIcon(colorScheme: colorScheme),
            const SizedBox(height: 32),
            // タイトル
            Text(
              'EQMonitor',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'へようこそ',
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            // 説明文
            Text(
              '地震・津波情報をリアルタイムで\nお届けします',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(flex: 3),
            // 次へボタン
            FilledButton.icon(
              onPressed: onNext,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('はじめる'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                textStyle: theme.textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 16),
            // 利用規約・プライバシーポリシー
            _LegalNotice(colorScheme: colorScheme),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: const Image(
          image: AssetImage('assets/images/icon.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _LegalNotice extends StatelessWidget {
  const _LegalNotice({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        );
    final linkStyle = textStyle?.copyWith(
      decoration: TextDecoration.underline,
      color: colorScheme.primary,
    );

    return Text.rich(
      TextSpan(
        style: textStyle,
        children: [
          const TextSpan(text: '続行することで、'),
          TextSpan(
            text: '利用規約',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.push(
                    const TermOfServiceRoute($extra: null).location,
                  ),
          ),
          const TextSpan(text: ' と '),
          TextSpan(
            text: 'プライバシーポリシー',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.push(
                    const PrivacyPolicyRoute($extra: null).location,
                  ),
          ),
          const TextSpan(text: ' に\n同意したものとみなします'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
