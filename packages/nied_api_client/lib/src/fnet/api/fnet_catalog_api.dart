import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'fnet_catalog_api.g.dart';

/// F-netカタログAPI
@RestApi(baseUrl: 'https://www.fnet.bosai.go.jp/event/mcata/data/')
abstract class FnetCatalogApi {
  factory FnetCatalogApi(Dio dio, {String? baseUrl}) = _FnetCatalogApi;

<<<<<<<< HEAD:packages/nied_api_client/lib/src/hinet/fnet/api/fnet_catalog_api.dart
  /// 指定した年月のカタログデータを取得
  ///
  /// [year] 年（例: 2025）
  /// [yearMonth] 年月（例: 202511）
  /// Returns カタログテキスト
  @GET('{year}/{yearMonth}_UT.txt')
========
  /// 指定された年月のカタログデータを取得
  /// @param year 年 (例: 2025)
  /// @param yearMonth 年月 (例: 202511)
  @GET('/data/{year}/{yearMonth}_UT.txt')
>>>>>>>> 0a08d0f1490fdc902d175d415269dbaa3b5d21da:packages/nied_api_client/lib/src/fnet/api/fnet_catalog_api.dart
  Future<String> getCatalog(
    @Path('year') int year,
    @Path('yearMonth') String yearMonth,
  );
}
