import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_history_data_source.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [],
)
TelegramHistoryDataSource telegramHistoryDataSource(
  TelegramHistoryDataSourceRef ref,
) =>
    TelegramHistoryDataSource(
      api: ref.watch(eqApiProvider),
    );

class TelegramHistoryDataSource {
  TelegramHistoryDataSource({required this.api});

  final EqApi api;

  /// EventIdごとに電文をまとめた電文履歴を取得する
  Future<TelegramHistoryV3> getTelegramHistoryV3({
    required bool includeEew,
    required int limit,
    required int offset,
  }) async {
    final response = await api.v3.getTelegramHistoryV3(
      includeEew: includeEew,
      limit: limit,
      offset: offset,
    );
    return response;
  }
}
