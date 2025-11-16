import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'fnet_catalog_api.g.dart';

/// F-netカタログAPI
@RestApi(baseUrl: 'https://www.fnet.bosai.go.jp/event/mcata/data/')
abstract class FnetCatalogApi {
  factory FnetCatalogApi(Dio dio, {String? baseUrl}) = _FnetCatalogApi;

  /// 指定された年月のカタログデータを取得
  /// @param year 年 (例: 2025)
  /// @param yearMonth 年月 (例: 202511)
  @GET('/data/{year}/{yearMonth}_UT.txt')
  Future<String> getCatalog(
    @Path('year') int year,
    @Path('yearMonth') String yearMonth,
  );
}
