import 'package:eqmonitor/core/component/banner/app_banner.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// ホームシートに表示するメンテナンス通知バナー。
/// メンテナンス中の場合のみ表示する。
class MaintenanceBanner extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startState = ref.watch(startProvider);
    final maintenance = startState.value?.flags.maintenance;

    if (maintenance == null || !maintenance.enabled) {
      return const SizedBox.shrink();
    }

    final colorTheme = context.designSystem.colorTheme;
    final message = maintenance.message ?? 'メンテナンス中です。しばらくお待ちください。';
    final url = maintenance.url;

    return AppBanner(
      icon: Icons.build_outlined,
      title: message,
      backgroundColor: colorTheme.tertiaryContainer,
      foregroundColor: colorTheme.onTertiaryContainer,
      onTap: url != null
          ? () => launchUrlString(url, mode: LaunchMode.externalApplication)
          : null,
      trailing: url != null
          ? Icon(
              Icons.open_in_new,
              color: colorTheme.onTertiaryContainer,
              size: 16,
            )
          : null,
    );
  }
}
