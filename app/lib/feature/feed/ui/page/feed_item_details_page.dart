import 'package:collection/collection.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/ui/page/feed_details_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 一覧で取得済みの [FeedItem] を表示するお知らせ詳細ページ。
///
/// 通常はルートの `$extra` で [item] が渡される。状態復元などで
/// [item] が無い場合は [feedProvider] のキャッシュから [id] で解決する。
/// （id 指定で1件取得するAPIは存在しないため、解決できない場合は
/// 見つからない旨を表示して一覧へ誘導する）
class FeedItemDetailsPage extends ConsumerWidget {
  const FeedItemDetailsPage({required this.id, this.item, super.key});

  final String id;
  final FeedItem? item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passed = item;
    final Widget body;
    if (passed != null) {
      body = FeedDetailsBody(item: passed.toDetail());
    } else {
      final state = ref.watch(feedProvider);
      final resolved = state.value?.items.firstWhereOrNull((e) => e.id == id);
      if (resolved != null) {
        body = FeedDetailsBody(item: resolved.toDetail());
      } else if (state.isLoading) {
        body = const Center(child: CircularProgressIndicator.adaptive());
      } else {
        body = const _FeedItemNotFound();
      }
    }
    return Scaffold(
      appBar: AppBar(title: const Text('お知らせ')),
      body: body,
    );
  }
}

class _FeedItemNotFound extends StatelessWidget {
  const _FeedItemNotFound();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('お知らせが見つかりませんでした'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async => const FeedRoute().push<void>(context),
              child: const Text('お知らせ一覧へ'),
            ),
          ],
        ),
      ),
    );
  }
}
