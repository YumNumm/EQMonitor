import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'city_max_intensity_repository.g.dart';

@Riverpod(keepAlive: true)
Future<CityMaxIntensityRepository> cityMaxIntensityRepository(Ref ref) async {
  final apiClient = await ref.watch(apiClientProvider.future);
  return CityMaxIntensityRepository(earthquake: apiClient.earthquake);
}

class CityMaxIntensityRepository {
  const new({required EarthquakeApiClient earthquake})
    : _earthquake = earthquake;

  final EarthquakeApiClient _earthquake;

  /// 全国の市区町村ごとの観測史上最大震度を取得する。
  ///
  /// バックエンド側で事前集計済みのため、都道府県での絞り込みや status 指定は無い。
  Future<CityMaxIntensity> fetch({ApiClient? client}) async {
    final response = await (client?.earthquake ?? _earthquake)
        .getV2EarthquakeIntensityCityMax();
    return response.data.toAppModel();
  }
}
