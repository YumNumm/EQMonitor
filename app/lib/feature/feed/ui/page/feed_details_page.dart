import 'package:eqmonitor/core/component/cached_data_banner.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_by_source_provider.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_card.dart';
import 'package:extensions/extensions.dart';
import 'package:material_ui/material_ui.dart';
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
              data: (item) => FeedDetailsBody(item: item),
            ),
          ),
        ],
      ),
    );
  }
}

class FeedDetailsBody extends StatelessWidget {
  const FeedDetailsBody({required this.item, super.key});

  final FeedDetail item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('yyyy年MM月dd日 HH:mm').format(item.publishedAt);
    final rawUrl = feedItemUrl(item.data);
    final url = (rawUrl != null && rawUrl.isNotEmpty)
        ? Uri.tryParse(rawUrl)
        : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        crossAxisAlignment: .start,
        children: [
          if (item.title case final title?)
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .start,
            children: [
              FeedTypeBadge(data: item.data),
              const Spacer(),
              Flexible(
                child: Text(
                  dateStr,
                  style: theme.textTheme.labelSmall!.copyWith(
                    fontFamily: FontFamily.googleSansCode,
                    fontFamilyFallback: const [FontFamily.notoSansJP],
                    letterSpacing: -0.2,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          Text(_bodyText(item).toHalfWidth),
          if (url != null) ...[
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () async => launchUrl(url, mode: .externalApplication),
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
}
