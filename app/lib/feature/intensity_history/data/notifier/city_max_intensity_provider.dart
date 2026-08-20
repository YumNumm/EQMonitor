import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/city_max_intensity_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ApiClient;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'city_max_intensity_provider.g.dart';

/// 全国の市区町村ごとの観測史上最大震度をキャッシュする provider。
@Riverpod(keepAlive: true)
class CityMaxIntensityNotifier extends _$CityMaxIntensityNotifier
    with CachedNotifier<CityMaxIntensity> {
  @override
  Future<CityMaxIntensity> build() async {
    await ref.watch(cityMaxIntensityRepositoryProvider.future);
    return cachedBuild();
  }

  @override
  Future<CityMaxIntensity> fetch(ApiClient client) async {
    final repository = await ref.read(
      cityMaxIntensityRepositoryProvider.future,
    );
    return repository.fetch(client: client);
  }
}
