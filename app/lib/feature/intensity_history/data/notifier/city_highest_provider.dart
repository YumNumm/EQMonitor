import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ApiClient;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'city_highest_provider.g.dart';

/// 指定都道府県の市区町村ごとの過去最高震度一覧を取得する family provider。
@riverpod
class CityHighest extends _$CityHighest
    with CachedNotifier<List<HighestIntensityEntry>> {
  @override
  Future<List<HighestIntensityEntry>> build(String prefectureCode) async {
    await ref.watch(intensityHighestRepositoryProvider.future);
    return cachedBuild();
  }

  @override
  Future<List<HighestIntensityEntry>> fetch(ApiClient client) async {
    final repository = await ref.read(
      intensityHighestRepositoryProvider.future,
    );
    return repository.fetchCityHighest(prefectureCode, client: client);
  }
}
