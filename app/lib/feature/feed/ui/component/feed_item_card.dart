import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

class FeedItemListTileContent extends StatelessWidget {
  const FeedItemListTileContent({required this.item, super.key});

  final FeedItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('yyyy/MM/dd HH:mm').format(item.publishedAt);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (item.summary ?? '').replaceAll("◆", ""),
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
