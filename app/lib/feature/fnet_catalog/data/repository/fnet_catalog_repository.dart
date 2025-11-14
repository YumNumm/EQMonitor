import 'package:nied_api_client/nied_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../nied/data/provider/nied_api_client_provider.dart';

part 'fnet_catalog_repository.g.dart';

@Riverpod(keepAlive: true)
FnetCatalogRepository fnetCatalogRepository(Ref ref) =>
    FnetCatalogRepository(client: ref.watch(niedApiClientProvider));

class FnetCatalogRepository {
  FnetCatalogRepository({required NiedApiClient client}) : _client = client;

  final NiedApiClient _client;

  /// 指定された年月のカタログデータを取得
  Future<List<FnetEarthquakeEvent>> fetchCatalog({
    required int year,
    required int month,
  }) async =>
      _client.fnet.getCatalog(year: year, month: month);

  /// 指定された年の全カタログデータを取得
  Future<List<FnetEarthquakeEvent>> fetchYearCatalog({
    required int year,
  }) async =>
      _client.fnet.getYearCatalog(year: year);

  /// 指定された期間のカタログデータを取得
  Future<List<FnetEarthquakeEvent>> fetchCatalogRange({
    required int startYear,
    required int startMonth,
    required int endYear,
    required int endMonth,
  }) async =>
      _client.fnet.getCatalogRange(
        startYear: startYear,
        startMonth: startMonth,
        endYear: endYear,
        endMonth: endMonth,
      );
}
