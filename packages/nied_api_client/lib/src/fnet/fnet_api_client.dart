import 'package:dio/dio.dart';
import 'package:nied_api_client/src/fnet/api/fnet_catalog_api.dart';
import 'package:nied_api_client/src/fnet/model/fnet_earthquake_event.dart';
import 'package:nied_api_client/src/fnet/parser/fnet_catalog_parser.dart';

/// F-net APIクライアント
class FnetApiClient {
  FnetApiClient({Dio? dio}) : _dio = dio ?? Dio() {
    _api = FnetCatalogApi(_dio);
  }

  final Dio _dio;
  late final FnetCatalogApi _api;

  /// 指定された年月のカタログデータを取得してパースする
  ///
  /// [year] 年 (例: 2025)
  /// [month] 月 (例: 11)
  Future<List<FnetEarthquakeEvent>> getCatalog({
    required int year,
    required int month,
  }) async {
    final yearMonth = '${year.toString()}${month.toString().padLeft(2, '0')}';
    final content = await _api.getCatalog(year, yearMonth);
    return FnetCatalogParser.parse(content);
  }

  /// 指定された年の全カタログデータを取得してパースする
  ///
  /// [year] 年 (例: 2025)
  Future<List<FnetEarthquakeEvent>> getYearCatalog({
    required int year,
  }) async {
    final allEvents = <FnetEarthquakeEvent>[];

    // 1月から12月まで順番に取得
    for (var month = 1; month <= 12; month++) {
      try {
        final events = await getCatalog(year: year, month: month);
        allEvents.addAll(events);
      } catch (e) {
        // 月のデータが存在しない場合はスキップ
        continue;
      }
    }

    return allEvents;
  }

  /// 指定された期間のカタログデータを取得してパースする
  ///
  /// [startYear] 開始年
  /// [startMonth] 開始月
  /// [endYear] 終了年
  /// [endMonth] 終了月
  Future<List<FnetEarthquakeEvent>> getCatalogRange({
    required int startYear,
    required int startMonth,
    required int endYear,
    required int endMonth,
  }) async {
    final allEvents = <FnetEarthquakeEvent>[];

    var currentYear = startYear;
    var currentMonth = startMonth;

    while (currentYear < endYear ||
        (currentYear == endYear && currentMonth <= endMonth)) {
      try {
        final events = await getCatalog(
          year: currentYear,
          month: currentMonth,
        );
        allEvents.addAll(events);
      } catch (e) {
        // データが存在しない場合はスキップ
      }

      // 次の月へ
      currentMonth++;
      if (currentMonth > 12) {
        currentMonth = 1;
        currentYear++;
      }
    }

    return allEvents;
  }
}
