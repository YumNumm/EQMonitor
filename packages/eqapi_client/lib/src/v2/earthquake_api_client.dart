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
  @GET('/v2/earthquake/intensity/region')
  Future<IntensityRegionSearchResponse> searchByRegion({
    @Query('code') required String code,
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
  @GET('/v2/earthquake/intensity/prefecture')
  Future<IntensityPrefectureSearchResponse> searchByPrefecture({
    @Query('code') required String code,
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
  @GET('/v2/earthquake/intensity/city')
  Future<IntensityCitySearchResponse> searchByCity({
    @Query('code') required String code,
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
  @GET('/v2/earthquake/intensity/station')
  Future<IntensityStationSearchResponse> searchByStation({
    @Query('code') required String code,
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
