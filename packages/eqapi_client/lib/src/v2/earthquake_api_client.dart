import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:retrofit/retrofit.dart';

part 'earthquake_api_client.g.dart';

/// 地震情報API
@RestApi()
abstract class EarthquakeApiClient {
  factory EarthquakeApiClient(Dio dio, {String baseUrl}) = _EarthquakeApiClient;

  /// 地震一覧を取得
  @GET('/v2/earthquake')
  Future<EarthquakeListResponse> getList({
    @Query('limit') int? limit,
    @Query('cursor') String? cursor,
    @Query('magnitudeLte') double? magnitudeLte,
    @Query('magnitudeGte') double? magnitudeGte,
    @Query('depthLte') int? depthLte,
    @Query('depthGte') int? depthGte,
    @Query('intensityLte') String? intensityLte,
    @Query('intensityGte') String? intensityGte,
    @Query('statuses') List<String>? statuses,
  });

  /// 地震詳細を取得
  @GET('/v2/earthquake/{eventId}')
  Future<EarthquakeDetailResponse> getDetail({
    @Path('eventId') required String eventId,
  });

  /// 震度細分区域から地震検索
  @GET('/v2/earthquake/intensity/region/{code}')
  Future<IntensityRegionSearchResponse> searchByRegion({
    @Path('code') required String code,
    @Query('limit') int? limit,
    @Query('cursor') String? cursor,
    @Query('magnitudeLte') double? magnitudeLte,
    @Query('magnitudeGte') double? magnitudeGte,
    @Query('depthLte') int? depthLte,
    @Query('depthGte') int? depthGte,
    @Query('intensityLte') String? intensityLte,
    @Query('intensityGte') String? intensityGte,
    @Query('statuses') List<String>? statuses,
  });

  /// 都道府県から地震検索
  @GET('/v2/earthquake/intensity/prefecture/{code}')
  Future<IntensityPrefectureSearchResponse> searchByPrefecture({
    @Path('code') required String code,
    @Query('limit') int? limit,
    @Query('cursor') String? cursor,
    @Query('magnitudeLte') double? magnitudeLte,
    @Query('magnitudeGte') double? magnitudeGte,
    @Query('depthLte') int? depthLte,
    @Query('depthGte') int? depthGte,
    @Query('intensityLte') String? intensityLte,
    @Query('intensityGte') String? intensityGte,
    @Query('statuses') List<String>? statuses,
  });

  /// 市区町村から地震検索
  @GET('/v2/earthquake/intensity/city/{code}')
  Future<IntensityCitySearchResponse> searchByCity({
    @Path('code') required String code,
    @Query('limit') int? limit,
    @Query('cursor') String? cursor,
    @Query('magnitudeLte') double? magnitudeLte,
    @Query('magnitudeGte') double? magnitudeGte,
    @Query('depthLte') int? depthLte,
    @Query('depthGte') int? depthGte,
    @Query('intensityLte') String? intensityLte,
    @Query('intensityGte') String? intensityGte,
    @Query('statuses') List<String>? statuses,
  });

  /// 観測点から地震検索
  @GET('/v2/earthquake/intensity/station/{code}')
  Future<IntensityStationSearchResponse> searchByStation({
    @Path('code') required String code,
    @Query('limit') int? limit,
    @Query('cursor') String? cursor,
    @Query('magnitudeLte') double? magnitudeLte,
    @Query('magnitudeGte') double? magnitudeGte,
    @Query('depthLte') int? depthLte,
    @Query('depthGte') int? depthGte,
    @Query('intensityLte') String? intensityLte,
    @Query('intensityGte') String? intensityGte,
    @Query('statuses') List<String>? statuses,
  });

  /// 震源地から地震検索
  @GET('/v2/earthquake/epicenter/{code}')
  Future<EpicenterSearchResponse> searchByEpicenter({
    @Path('code') required int code,
    @Query('limit') int? limit,
    @Query('cursor') String? cursor,
    @Query('magnitudeLte') double? magnitudeLte,
    @Query('magnitudeGte') double? magnitudeGte,
    @Query('depthLte') int? depthLte,
    @Query('depthGte') int? depthGte,
    @Query('intensityLte') String? intensityLte,
    @Query('intensityGte') String? intensityGte,
    @Query('statuses') List<String>? statuses,
  });
}
