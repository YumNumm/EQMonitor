// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'dart:async';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホームシートに表示する「What's New」バナー。
/// 未閲覧の最新バージョンがある場合のみ表示する。
class WhatsNewBanner extends ConsumerWidget {
  const WhatsNewBanner({required this.bottomSpacing, super.key});

  final double bottomSpacing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startState = ref.watch(startProvider);
    final latest = startState.value?.app.version.latest;

    if (latest == null || !latest.showWhatsNew) {
      return const SizedBox.shrink();
    }

    return _WhatsNewBannerContent(
      latest: latest,
      bottomSpacing: bottomSpacing,
    );
  }
}

class _WhatsNewBannerContent extends HookConsumerWidget {
  const _WhatsNewBannerContent({
    required this.latest,
    required this.bottomSpacing,
  });

  final api.LatestVersion latest;
  final double bottomSpacing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dismissed = useState(false);

    useEffect(() {
      unawaited(
        Future.microtask(() async {
          final dataSource = await ref.read(
            sharedPreferencesDataSourceProvider.future,
          );
          final seen = await dataSource.getString(
            key: SharedPreferencesKey.whatsNewSeenVersion,
          );
          if (seen == latest.version) {
            dismissed.value = true;
          }
        }),
      );
      return null;
    }, const []);

    Future<void> markSeen() async {
      final dataSource = await ref.read(
        sharedPreferencesDataSourceProvider.future,
      );
      await dataSource.setString(
        key: SharedPreferencesKey.whatsNewSeenVersion,
        value: latest.version,
      );
      dismissed.value = true;
    }

    void showDetail(BuildContext context) {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (ctx) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.95,
          minChildSize: 0.3,
          builder: (_, controller) => _WhatsNewSheet(
            latest: latest,
            whatsNew: latest.whatsNew,
            scrollController: controller,
            onClose: () {
              Navigator.of(ctx).pop();
              unawaited(markSeen());
            },
          ),
        ),
      ).ignore();
    }

    if (dismissed.value) {
      return const SizedBox.shrink();
    }

    final colorTheme = context.designSystem.colorTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Material(
        color: colorTheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => showDetail(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  Icons.new_releases_outlined,
                  color: colorTheme.onPrimaryContainer,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'v${latest.version} にアップデートしました',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorTheme.onPrimaryContainer,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorTheme.onPrimaryContainer,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WhatsNewSheet extends StatelessWidget {
  const _WhatsNewSheet({
    required this.latest,
    required this.whatsNew,
    required this.scrollController,
    required this.onClose,
  });

  final api.LatestVersion latest;
  final api.WhatsNew? whatsNew;
  final ScrollController scrollController;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = whatsNew?.title ?? 'v${latest.version} の新機能';
    final content = whatsNew?.content ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: onClose,
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        child: content.isNotEmpty
            ? MarkdownBody(
                data: content,
                styleSheet: MarkdownStyleSheet.fromTheme(theme),
              )
            : Text(
                'このバージョンの更新内容はありません。',
                style: theme.textTheme.bodyMedium,
              ),
      ),
    );
  }
}
