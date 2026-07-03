// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_by_source_provider.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_card.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedDetailsPage extends ConsumerWidget {
  const FeedDetailsPage({required this.telegramHash, super.key});

  final String telegramHash;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = ref.watch(feedBySourceProvider(telegramHash));

    return Scaffold(
      appBar: AppBar(title: const Text('お知らせ')),
      body: feed.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, _) => ErrorCard(
          error: error,
          onReload: () async =>
              ref.invalidate(feedBySourceProvider(telegramHash)),
        ),
        data: (item) => _FeedDetailsBody(item: item),
      ),
    );
  }
}

class _FeedDetailsBody extends StatelessWidget {
  const _FeedDetailsBody({required this.item});

  final api.FeedDetailResponse item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final publishedAt = DateTime.tryParse(item.publishedAt)?.toLocal();
    final dateStr = publishedAt != null
        ? DateFormat('yyyy年MM月dd日 HH:mm').format(publishedAt)
        : item.publishedAt;
    final url = _url(item.data);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.title case final title?)
            Text(
              title,
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
          SelectableText(_bodyText(item), style: theme.textTheme.bodyMedium),
          if (url != null) ...[
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () async =>
                  launchUrl(url, mode: LaunchMode.externalApplication),
              icon: const Icon(Icons.open_in_new),
              label: const Text('詳細を開く'),
            ),
          ],
        ],
      ),
    );
  }

  static String _bodyText(api.FeedDetailResponse item) {
    if (item.body case final body? when body.isNotEmpty) {
      return body;
    }
    return switch (item.data) {
      api.FeedItemDataUnionFeedEarthquakeNankaiData(
        :final text,
        :final earthquakeInfo,
      ) =>
        text ?? earthquakeInfo?.text ?? item.summary ?? '',
      final data => FeedItemCard.dataText(data),
    };
  }

  static Uri? _url(api.FeedItemDataUnion data) {
    final url = switch (data) {
      api.FeedItemDataUnionFeedAppUpdateData(:final url) => url,
      api.FeedItemDataUnionFeedIncidentData(:final url) => url,
      api.FeedItemDataUnionFeedDeveloperMessageData(:final url) => url,
      _ => null,
    };
    return url != null ? Uri.tryParse(url) : null;
  }
}
