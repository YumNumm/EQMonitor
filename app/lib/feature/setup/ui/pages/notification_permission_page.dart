import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionPage extends HookConsumerWidget {
  const NotificationPermissionPage({
    required this.onComplete,
    super.key,
  });

  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(flex: 2),
            // アイコン
            _NotificationIcon(colorScheme: colorScheme),
            const SizedBox(height: 32),
            // タイトル
            Text(
              '通知の許可',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            // 説明
            Text(
              '地震・津波情報をいち早くお届けするために、\n通知を許可してください',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            // 機能説明カード
            _FeatureCard(colorScheme: colorScheme),
            const Spacer(flex: 3),
            // 許可ボタン
            FilledButton.icon(
              onPressed: () async {
                unawaited(Permission.notification.request());
                onComplete();
              },
              icon: const Icon(Icons.notifications_active_outlined),
              label: const Text('通知を許可する'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                textStyle: theme.textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 12),
            // スキップボタン
            TextButton(
              onPressed: onComplete,
              child: Text(
                'あとで設定する',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.notifications_outlined,
        size: 48,
        color: colorScheme.onPrimaryContainer,
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FeatureItem(
              icon: Icons.warning_amber_rounded,
              title: '緊急地震速報',
              description: '地震発生時に素早くお知らせ',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 16),
            _FeatureItem(
              icon: Icons.waves,
              title: '津波警報',
              description: '津波に関する情報をお届け',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 16),
            _FeatureItem(
              icon: Icons.info_outline,
              title: '地震情報',
              description: '震度や震源地の詳細情報',
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.colorScheme,
  });

  final IconData icon;
  final String title;
  final String description;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
