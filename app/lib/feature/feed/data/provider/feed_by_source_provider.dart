import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_by_source_provider.g.dart';

@riverpod
Future<api.FeedDetailResponse> feedBySource(
  Ref ref,
  String telegramHash,
) async {
  final repository = await ref.watch(feedRepositoryProvider.future);
  return repository.fetchByTelegramHash(telegramHash);
}
