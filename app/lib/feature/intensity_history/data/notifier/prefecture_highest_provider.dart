import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ApiClient;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prefecture_highest_provider.g.dart';

/// 全都道府県の過去最高震度一覧をキャッシュする provider。
@Riverpod(keepAlive: true)
class PrefectureHighest extends _$PrefectureHighest
    with CachedNotifier<List<HighestIntensityEntry>> {
  @override
  Future<List<HighestIntensityEntry>> build() async {
    await ref.watch(intensityHighestRepositoryProvider.future);
    return cachedBuild();
  }

  @override
  Future<List<HighestIntensityEntry>> fetch(ApiClient client) async {
    final repository = await ref.read(
      intensityHighestRepositoryProvider.future,
    );
    return repository.fetchPrefectureHighest(client: client);
  }
}
