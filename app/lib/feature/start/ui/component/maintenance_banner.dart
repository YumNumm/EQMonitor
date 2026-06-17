import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// ホームシートに表示するメンテナンス通知バナー。
/// メンテナンス中の場合のみ表示する。
class MaintenanceBanner extends ConsumerWidget {
  const MaintenanceBanner({required this.bottomSpacing, super.key});

  final double bottomSpacing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startState = ref.watch(startProvider);
    final maintenance = startState.value?.flags.maintenance;

    if (maintenance == null || !maintenance.enabled) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final message = maintenance.message ?? 'メンテナンス中です。しばらくお待ちください。';
    final url = maintenance.url;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Material(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: url != null
              ? () => launchUrlString(
                  url,
                  mode: LaunchMode.externalApplication,
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  Icons.build_outlined,
                  color: colorScheme.onTertiaryContainer,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onTertiaryContainer,
                    ),
                  ),
                ),
                if (url != null) ...[
                  Icon(
                    Icons.open_in_new,
                    color: colorScheme.onTertiaryContainer,
                    size: 16,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
