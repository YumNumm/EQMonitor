import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/notifier/feed_notifier.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_last_read_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unread_high_urgency_feed_provider.g.dart';

/// 未読の緊急度の高いお知らせのうち最新の1件。該当なしなら null。
/// 既読位置が未設定(初回起動直後)の間も null を返し、表示しない。
@riverpod
FeedItem? unreadHighUrgencyFeed(Ref ref) {
  final items = ref.watch(feedProvider).value?.items;
  final lastRead = ref.watch(feedLastReadProvider).value;
  if (items == null || lastRead == null) {
    return null;
  }
  FeedItem? newest;
  for (final item in items) {
    if (!item.isHighUrgency || !item.publishedAt.isAfter(lastRead)) {
      continue;
    }
    if (newest == null || item.publishedAt.isAfter(newest.publishedAt)) {
      newest = item;
    }
  }
  return newest;
}
