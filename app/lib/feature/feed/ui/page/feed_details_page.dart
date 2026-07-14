import 'package:eqmonitor/core/component/cached_data_banner.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_by_source_provider.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
      body: Column(
        children: [
          CachedDataBanner(values: [feed]),
          Expanded(
            // 再検証失敗時は stale を表示し続け、失敗はバナーが伝える。
            child: feed.when(
              skipError: true,
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (error, _) => ErrorCard(
                error: error,
                onReload: () async =>
                    ref.invalidate(feedBySourceProvider(telegramHash)),
              ),
              data: (item) => _FeedDetailsBody(item: item),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedDetailsBody extends StatelessWidget {
  const _FeedDetailsBody({required this.item});

  final FeedDetail item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('yyyy年MM月dd日 HH:mm').format(item.publishedAt);
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
              FeedTypeBadge(data: item.data),
              const Spacer(),
              Text(dateStr, style: theme.textTheme.labelSmall),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          MarkdownBody(
            data: _bodyText(item),
            softLineBreak: true,
            styleSheet: MarkdownStyleSheet.fromTheme(theme),
            onTapLink: (text, href, title) async {
              final uri = href != null ? Uri.tryParse(href) : null;
              if (uri != null) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
          ),
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

  static String _bodyText(FeedDetail item) {
    if (item.body case final body? when body.isNotEmpty) {
      return body;
    }
    return switch (item.data) {
      FeedItemDataEarthquakeNankai(:final text, :final earthquakeInfo) =>
        text ?? earthquakeInfo?.text ?? item.summary ?? '',
      final data => feedItemDataText(data),
    };
  }

  static Uri? _url(FeedItemData data) {
    final url = feedItemUrl(data);
    return url != null ? Uri.tryParse(url) : null;
  }
}
