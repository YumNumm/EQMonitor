import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_by_source_provider.g.dart';

@riverpod
Future<FeedDetail> feedBySource(
  Ref ref,
  String telegramHash,
) async {
  final repository = await ref.watch(feedRepositoryProvider.future);
  return repository.fetchByTelegramHash(telegramHash);
}
