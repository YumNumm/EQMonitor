import 'package:intl/intl.dart';
import 'package:nied_api_client/src/hinet/fnet/api/fnet_catalog_api.dart';
import 'package:nied_api_client/src/hinet/fnet/model/fnet_event.dart';
import 'package:nied_api_client/src/hinet/fnet/parser/fnet_catalog_parser.dart';

/// F-net APIクライアント
///
/// F-netの地震カタログデータを取得・パースするためのクライアント
class FnetApiClient {
  FnetApiClient({
    required FnetCatalogApi api,
    required FnetCatalogParser parser,
  }) : _api = api,
       _parser = parser;

  final FnetCatalogApi _api;
  final FnetCatalogParser _parser;

  /// 指定した年月の地震イベントリストを取得
  ///
  /// [year] 年（例: 2025）
  /// [month] 月（例: 11）
  /// Returns 地震イベントのリスト
  Future<List<FnetEvent>> getEventsByMonth({
    required int year,
    required int month,
  }) async {
    final yearMonth = DateFormat('yyyyMM').format(DateTime(year, month));
    final content = await _api.getCatalog(year, yearMonth);
    return _parser.parse(content);
  }

  /// 指定した期間の地震イベントリストを取得
  ///
  /// [startYear] 開始年
  /// [startMonth] 開始月
  /// [endYear] 終了年
  /// [endMonth] 終了月
  /// Returns 地震イベントのリスト
  Future<List<FnetEvent>> getEventsByPeriod({
    required int startYear,
    required int startMonth,
    required int endYear,
    required int endMonth,
  }) async {
    final events = <FnetEvent>[];
    var currentDate = DateTime(startYear, startMonth);
    final endDate = DateTime(endYear, endMonth);

    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      final monthEvents = await getEventsByMonth(
        year: currentDate.year,
        month: currentDate.month,
      );
      events.addAll(monthEvents);

      currentDate = DateTime(currentDate.year, currentDate.month + 1);
    }

    return events;
  }

  /// 最新の地震イベントリストを取得（当月）
  Future<List<FnetEvent>> getLatestEvents() {
    final now = DateTime.now().toUtc();
    return getEventsByMonth(year: now.year, month: now.month);
  }
}
