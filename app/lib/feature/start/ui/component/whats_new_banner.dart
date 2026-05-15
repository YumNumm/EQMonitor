import 'dart:async';

import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kSeenKey = 'whats_new_seen_version';

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

class _WhatsNewBannerContent extends StatefulWidget {
  const _WhatsNewBannerContent({
    required this.latest,
    required this.bottomSpacing,
  });

  final api.LatestVersion latest;
  final double bottomSpacing;

  @override
  State<_WhatsNewBannerContent> createState() => _WhatsNewBannerContentState();
}

class _WhatsNewBannerContentState extends State<_WhatsNewBannerContent> {
  var _dismissed = false;

  @override
  void initState() {
    super.initState();
    unawaited(_checkSeen());
  }

  Future<void> _checkSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getString(_kSeenKey);
    if (seen == widget.latest.version && mounted) {
      setState(() => _dismissed = true);
    }
  }

  Future<void> _markSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSeenKey, widget.latest.version);
    if (mounted) {
      setState(() => _dismissed = true);
    }
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.95,
        minChildSize: 0.3,
        builder: (_, controller) => _WhatsNewSheet(
          latest: widget.latest,
          whatsNew: widget.latest.whatsNew,
          scrollController: controller,
          onClose: () {
            Navigator.of(ctx).pop();
            unawaited(_markSeen());
          },
        ),
      ),
    ).ignore();
  }

  @override
  Widget build(BuildContext context) {
    if (_dismissed) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomSpacing),
      child: Material(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showDetail(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  Icons.new_releases_outlined,
                  color: colorScheme.onPrimaryContainer,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'v${widget.latest.version} にアップデートしました',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onPrimaryContainer,
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
