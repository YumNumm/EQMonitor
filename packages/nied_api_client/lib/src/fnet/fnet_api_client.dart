import 'package:nied_api_client/src/fnet/api/fnet_catalog_api.dart';
import 'package:nied_api_client/src/fnet/parser/fnet_catalog_parser.dart';
import 'package:nied_api_client/src/hinet/fnet/model/fnet_event.dart';

/// F-net APIクライアント
class FnetApiClient {
  new({
    required FnetCatalogApi api,
    required FnetCatalogParser parser,
  }) : _api = api,
       _parser = parser;

  final FnetCatalogApi _api;
  final FnetCatalogParser _parser;

  /// 指定された年月のカタログデータを取得してパースする
  ///
  /// [year] 年 (例: 2025)
  /// [month] 月 (例: 11)
  Future<List<FnetEvent>> getCatalog({
    required int year,
    required int month,
  }) async {
    final yearMonth = '$year${month.toString().padLeft(2, '0')}';
    final content = await _api.getCatalog(year, yearMonth);
    return _parser.parse(content);
  }

  /// 指定された年の全カタログデータを取得してパースする
  ///
  /// [year] 年 (例: 2025)
  Future<List<FnetEvent>> getYearCatalog({
    required int year,
  }) async {
    final allEvents = <FnetEvent>[];

    // 1月から12月まで順番に取得
    for (var month = 1; month <= 12; month++) {
      try {
        final events = await getCatalog(year: year, month: month);
        allEvents.addAll(events);
      } on Exception catch (_) {
        // 月のデータが存在しない場合はスキップ
        continue;
      }
    }

    return allEvents;
  }
}
