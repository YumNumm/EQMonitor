// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedItemCard extends StatelessWidget {
  const FeedItemCard({required this.item, super.key});

  final api.FeedItem item;

  static Future<void> showDetail(BuildContext context, api.FeedItem item) {
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
    final dateStr = _formatPublishedAt(item.publishedAt);

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
                  dataText(item.data),
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

  static String dataText(api.FeedItemDataUnion data) => switch (data) {
        api.FeedItemDataUnionFeedEarthquakeNoticeData(:final text) => text,
        api.FeedItemDataUnionFeedEarthquakeExplanationData(:final text) => text,
        api.FeedItemDataUnionFeedEarthquakeCountsData(:final text) =>
          text ?? '',
        api.FeedItemDataUnionFeedEarthquakeNankaiData(:final text) =>
          text ?? '',
        api.FeedItemDataUnionFeedAppUpdateData(:final version) =>
          'バージョン ${version ?? ""}',
        api.FeedItemDataUnionFeedIncidentData() => '障害情報',
        api.FeedItemDataUnionFeedDeveloperMessageData() => '開発者メッセージ',
      };

  static String _formatPublishedAt(String publishedAt) {
    final dt = DateTime.tryParse(publishedAt)?.toLocal();
    if (dt == null) {
      return publishedAt;
    }
    return DateFormat('yyyy/MM/dd HH:mm').format(dt);
  }
}

class FeedItemListTileContent extends StatelessWidget {
  const FeedItemListTileContent({required this.item, super.key});

  final api.FeedItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = FeedItemCard._formatPublishedAt(item.publishedAt);
    final title = item.title ?? item.summary ?? FeedItemCard.dataText(item.data);

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

  final api.FeedPriority priority;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (priority) {
      api.FeedPriority.critical => (Colors.red, '緊急'),
      api.FeedPriority.high => (Colors.orange, '重要'),
      api.FeedPriority.normal => (Colors.blue, '通常'),
      api.FeedPriority.low => (Colors.grey, '低'),
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

  final api.FeedItemDataUnion data;

  @override
  Widget build(BuildContext context) {
    final label = switch (data) {
      api.FeedItemDataUnionFeedEarthquakeNoticeData() => '地震情報',
      api.FeedItemDataUnionFeedEarthquakeExplanationData() => '地震解説',
      api.FeedItemDataUnionFeedEarthquakeCountsData() => '地震回数',
      api.FeedItemDataUnionFeedEarthquakeNankaiData() => '南海トラフ',
      api.FeedItemDataUnionFeedAppUpdateData() => 'アップデート',
      api.FeedItemDataUnionFeedIncidentData() => '障害情報',
      api.FeedItemDataUnionFeedDeveloperMessageData() => 'お知らせ',
    };

    return Text(
      label,
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

  final api.FeedItem item;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final publishedAt = DateTime.tryParse(item.publishedAt)?.toLocal();
    final dateStr = publishedAt != null
        ? DateFormat('yyyy年MM月dd日 HH:mm').format(publishedAt)
        : item.publishedAt;

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
        Text(
          FeedItemCard.dataText(item.data),
          style: theme.textTheme.bodyMedium,
        ),
        if (item.expiresAt != null) ...[
          const SizedBox(height: 16),
          Text(
            '有効期限: ${_formatExpires(item.expiresAt!)}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: context.designSystem.colorTheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }

  String _formatExpires(String expiresAt) {
    final dt = DateTime.tryParse(expiresAt)?.toLocal();
    if (dt == null) {
      return expiresAt;
    }
    return DateFormat('yyyy年MM月dd日 HH:mm').format(dt);
  }
}
