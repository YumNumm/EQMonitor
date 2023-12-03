import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_data_source.g.dart';

@Riverpod(
  keepAlive: true,
)
TsunamiHistoryDataSource tsunamiHistoryDataSource(
  TsunamiHistoryDataSourceRef ref,
) =>
    TsunamiHistoryDataSource(
      api: ref.watch(eqApiProvider),
    );

class TsunamiHistoryDataSource {
  TsunamiHistoryDataSource({required this.api});

  final EqApi api;

  /// EventIdごとに電文をまとめた電文履歴を取得する
  Future<TelegramHistoryV3> getTsunamiHistory({
    required int limit,
    required int offset,
  }) async =>
      api.v3.getTsunamiHistory(
        limit: limit,
        offset: offset,
      );
}
