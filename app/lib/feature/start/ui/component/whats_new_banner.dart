import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/start/data/notifier/update_banner_seen_version_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホームシートに表示する「アップデートしました」バナー。
/// アプリのバージョンが更新され、まだ確認していない場合のみ表示する。
/// タップで変更履歴(Changelog)画面に遷移する。
class WhatsNewBanner extends ConsumerWidget {
  const WhatsNewBanner({required this.bottomSpacing, super.key});

  final double bottomSpacing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentVersion = ref.watch(packageInfoProvider).version;
    final seenAsync = ref.watch(updateBannerSeenVersionProvider);

    // 既読版数がロードされるまでは表示しない（チラつき防止）。
    if (seenAsync is! AsyncData<String?>) {
      return const SizedBox.shrink();
    }
    if (seenAsync.value == currentVersion) {
      return const SizedBox.shrink();
    }

    final colorTheme = context.designSystem.colorTheme;
    final spacing = context.designSystem.spacing;

    Future<void> markSeen() => ref
        .read(updateBannerSeenVersionProvider.notifier)
        .markSeen(currentVersion);

    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Material(
        color: colorTheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            markSeen();
            const ChangelogRoute().push<void>(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.md,
              vertical: spacing.sm,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.new_releases_outlined,
                  color: colorTheme.onPrimaryContainer,
                  size: 20,
                ),
                SizedBox(width: spacing.md),
                Expanded(
                  child: Text(
                    'v$currentVersion へアップデートしました',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorTheme.onPrimaryContainer,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorTheme.onPrimaryContainer,
                  size: 20,
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: colorTheme.onPrimaryContainer,
                    size: 20,
                  ),
                  tooltip: '閉じる',
                  onPressed: markSeen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
