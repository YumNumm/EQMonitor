import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String feedItemDataText(FeedItemData data) => switch (data) {
  FeedItemDataEarthquakeNotice(:final text) => text,
  FeedItemDataEarthquakeExplanation(:final text) => text,
  FeedItemDataEarthquakeCounts(:final text) => text ?? '',
  FeedItemDataEarthquakeNankai(:final text) => text ?? '',
  FeedItemDataAppUpdate(:final version) => 'バージョン ${version ?? ""}',
  FeedItemDataIncident() => '障害情報',
  FeedItemDataDeveloperMessage() => '開発者メッセージ',
};

String? feedItemUrl(FeedItemData data) => switch (data) {
  FeedItemDataAppUpdate(:final url) => url,
  FeedItemDataIncident(:final url) => url,
  FeedItemDataDeveloperMessage(:final url) => url,
  _ => null,
};

String _feedTypeLabel(FeedItemData data) => switch (data) {
  FeedItemDataEarthquakeNotice() => '地震情報',
  FeedItemDataEarthquakeExplanation() => '地震解説',
  FeedItemDataEarthquakeCounts() => '地震回数',
  FeedItemDataEarthquakeNankai() => '南海トラフ',
  FeedItemDataAppUpdate() => 'アップデート',
  FeedItemDataIncident() => '障害情報',
  FeedItemDataDeveloperMessage() => 'お知らせ',
};

Future<void> _openUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null || !await canLaunchUrl(uri)) {
    return;
  }
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

class FeedItemCard extends StatelessWidget {
  const FeedItemCard({required this.item, super.key});

  final FeedItem item;

  static Future<void> showDetail(BuildContext context, FeedItem item) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => _FeedDetailSheet(
          item: item,
          scrollController: scrollController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('yyyy/MM/dd HH:mm').format(item.publishedAt);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => showDetail(context, item),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FeedPriorityBadge(priority: item.priority),
                  const SizedBox(width: 8),
                  FeedTypeBadge(data: item.data),
                  const Spacer(),
                  Text(dateStr, style: theme.textTheme.labelSmall),
                ],
              ),
              if (item.title != null) ...[
                const SizedBox(height: 8),
                Text(
                  item.title!,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              if (item.summary != null) ...[
                const SizedBox(height: 4),
                Text(
                  item.summary!,
                  style: theme.textTheme.bodySmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (item.title == null && item.summary == null) ...[
                const SizedBox(height: 8),
                Text(
                  feedItemDataText(item.data),
                  style: theme.textTheme.bodySmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class FeedItemListTileContent extends StatelessWidget {
  const FeedItemListTileContent({required this.item, super.key});

  final FeedItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('yyyy/MM/dd HH:mm').format(item.publishedAt);
    final title = item.title ?? item.summary ?? feedItemDataText(item.data);

    return Row(
      children: [
        FeedPriorityBadge(priority: item.priority),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                dateStr,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: context.designSystem.colorTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.chevron_right_rounded,
          size: 18,
          color: context.designSystem.colorTheme.onSurfaceVariant,
        ),
      ],
    );
  }
}

class FeedPriorityBadge extends StatelessWidget {
  const FeedPriorityBadge({required this.priority, super.key});

  final FeedPriority priority;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (priority) {
      FeedPriority.critical => (Colors.red, '緊急'),
      FeedPriority.high => (Colors.orange, '重要'),
      FeedPriority.normal => (Colors.blue, '通常'),
      FeedPriority.low => (Colors.grey, '低'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class FeedTypeBadge extends StatelessWidget {
  const FeedTypeBadge({required this.data, super.key});

  final FeedItemData data;

  @override
  Widget build(BuildContext context) {
    return Text(
      _feedTypeLabel(data),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: context.designSystem.colorTheme.onSurfaceVariant,
      ),
    );
  }
}

class _FeedDetailSheet extends StatelessWidget {
  const _FeedDetailSheet({
    required this.item,
    required this.scrollController,
  });

  final FeedItem item;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('yyyy年MM月dd日 HH:mm').format(item.publishedAt);
    final url = feedItemUrl(item.data);

    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(24),
      children: [
        Center(
          child: Container(
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: context.designSystem.colorTheme.onSurfaceVariant.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (item.title != null)
          Text(
            item.title!,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 8),
        Row(
          children: [
            FeedPriorityBadge(priority: item.priority),
            const SizedBox(width: 8),
            FeedTypeBadge(data: item.data),
            const Spacer(),
            Text(dateStr, style: theme.textTheme.labelSmall),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        MarkdownBody(
          data: feedItemDataText(item.data),
          softLineBreak: true,
          styleSheet: MarkdownStyleSheet.fromTheme(theme),
          onTapLink: (text, href, title) async {
            if (href != null) {
              await _openUrl(href);
            }
          },
        ),
        if (url != null) ...[
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.tonalIcon(
              onPressed: () => _openUrl(url),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: const Text('リンクを開く'),
            ),
          ),
        ],
        if (item.expiresAt != null) ...[
          const SizedBox(height: 16),
          Text(
            '有効期限: ${DateFormat('yyyy年MM月dd日 HH:mm').format(item.expiresAt!)}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: context.designSystem.colorTheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
