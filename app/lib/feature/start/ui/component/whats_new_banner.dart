import 'package:eqmonitor/core/component/banner/app_banner.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/start/data/notifier/update_banner_seen_version_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホームシートに表示する「アップデートしました」バナー。
/// アプリのバージョンが更新され、まだ確認していない場合のみ表示する。
/// タップで変更履歴(Changelog)画面に遷移する。
class WhatsNewBanner extends ConsumerWidget {
  const new({super.key});

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

    Future<void> markSeen() => ref
        .read(updateBannerSeenVersionProvider.notifier)
        .markSeen(currentVersion);

    return AppBanner(
      icon: Icons.new_releases_outlined,
      title: 'v$currentVersion へアップデートしました',
      backgroundColor: colorTheme.primaryContainer,
      foregroundColor: colorTheme.onPrimaryContainer,
      onTap: () {
        markSeen();
        const ChangelogRoute().push<void>(context);
      },
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: colorTheme.onPrimaryContainer,
        size: 20,
      ),
      onDismiss: markSeen,
    );
  }
}
