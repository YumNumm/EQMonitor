import 'package:dio/dio.dart';
import 'package:eqapi_types/model/telegram_v3.dart';
import 'package:eqmonitor/feature/tsunami_history/data/tsunami_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_history_use_case.g.dart';

@Riverpod(keepAlive: true)
TsunamiHistoryUseCase tsunamiHistoryUseCase(
  TsunamiHistoryUseCaseRef ref,
) =>
    TsunamiHistoryUseCase(ref.watch(tsunamiHistoryDataSourceProvider));

class TsunamiHistoryUseCase {
  TsunamiHistoryUseCase(this._dataSource);
  final TsunamiHistoryDataSource _dataSource;

  Future<Map<String, List<TelegramV3>>> getTsunamiHistory({
    required int limit,
    required int offset,
  }) async {
    try {
      final result = await _dataSource.getTsunamiHistory(
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
      throw Exception(e.message);
    }
  }
}
