import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/earthquake_history_old/data/telegram_history_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_use_case.g.dart';

@Deprecated('Earthquake API v3 is deprecated.')
@Riverpod(
  keepAlive: true,
  dependencies: [telegramHistoryDataSource],
)
EarthquakeHistoryUseCase earthquakeHistoryUseCase(
  EarthquakeHistoryUseCaseRef ref,
) =>
    EarthquakeHistoryUseCase(ref.watch(telegramHistoryDataSourceProvider));

class EarthquakeHistoryUseCase {
  EarthquakeHistoryUseCase(this._dataSource);
  final TelegramHistoryDataSource _dataSource;

  Future<Map<String, List<TelegramV3>>> getEarthquakeHistory({
    required int limit,
    required int offset,
    required bool includeEew,
  }) async {
    try {
      final result = await _dataSource.getTelegramHistoryV3(
        includeEew: includeEew,
        limit: limit,
        offset: offset,
      );
      if (result.results == null) {
        throw Exception('No matched result.');
      }
      return result.results!;
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        throw Exception('レートリミットに達しました。10秒後に再度お試しください。');
      }
      rethrow;
    }
  }
}
