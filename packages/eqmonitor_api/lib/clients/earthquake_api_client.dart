// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/earthquake_detail_response.dart';
import '../models/earthquake_list_response.dart';
import '../models/epicenter_search_response.dart';
import '../models/intensity_city_search_response.dart';
import '../models/intensity_prefecture_search_response.dart';
import '../models/intensity_region_search_response.dart';
import '../models/intensity_station_search_response.dart';

part 'earthquake_api_client.g.dart';

@RestApi()
abstract class EarthquakeApiClient {
  factory EarthquakeApiClient(Dio dio, {String? baseUrl}) =
      _EarthquakeApiClient;

  /// 地震情報一覧.
  ///
  /// [limit] - 1~100 の整数(string).
  @GET(EarthquakeApiClientUrls.getV2Earthquake)
  Future<HttpResponse<EarthquakeListResponse>> getV2Earthquake({
    @Query('limit') String? limit,
  });

  @GET(EarthquakeApiClientUrls.getV2EarthquakeEventId)
  Future<HttpResponse<EarthquakeDetailResponse>> getV2EarthquakeEventId({
    @Path('eventId') required String eventId,
  });

  /// [limit] - 1~100 の整数(string)
  @GET(EarthquakeApiClientUrls.getV2EarthquakeIntensityRegionCode)
  Future<HttpResponse<IntensityRegionSearchResponse>>
  getV2EarthquakeIntensityRegionCode({
    @Path('code') required String code,
    @Query('limit') String? limit,
  });

  /// [limit] - 1~100 の整数(string)
  @GET(EarthquakeApiClientUrls.getV2EarthquakeIntensityPrefectureCode)
  Future<HttpResponse<IntensityPrefectureSearchResponse>>
  getV2EarthquakeIntensityPrefectureCode({
    @Path('code') required String code,
    @Query('limit') String? limit,
  });

  /// [limit] - 1~100 の整数(string)
  @GET(EarthquakeApiClientUrls.getV2EarthquakeIntensityCityCode)
  Future<HttpResponse<IntensityCitySearchResponse>>
  getV2EarthquakeIntensityCityCode({
    @Path('code') required String code,
    @Query('limit') String? limit,
  });

  /// [limit] - 1~100 の整数(string)
  @GET(EarthquakeApiClientUrls.getV2EarthquakeIntensityStationCode)
  Future<HttpResponse<IntensityStationSearchResponse>>
  getV2EarthquakeIntensityStationCode({
    @Path('code') required String code,
    @Query('limit') String? limit,
  });

  /// [limit] - 1~100 の整数(string)
  @GET(EarthquakeApiClientUrls.getV2EarthquakeEpicenterCode)
  Future<HttpResponse<EpicenterSearchResponse>> getV2EarthquakeEpicenterCode({
    @Path('code') required String code,
    @Query('limit') String? limit,
  });
}

abstract class EarthquakeApiClientUrls {
  /// /v2/earthquake
  static const getV2Earthquake = "/v2/earthquake";

  /// /v2/earthquake/{eventId}
  static const getV2EarthquakeEventId = "/v2/earthquake/{eventId}";

  /// /v2/earthquake/intensity/region/{code}
  static const getV2EarthquakeIntensityRegionCode =
      "/v2/earthquake/intensity/region/{code}";

  /// /v2/earthquake/intensity/prefecture/{code}
  static const getV2EarthquakeIntensityPrefectureCode =
      "/v2/earthquake/intensity/prefecture/{code}";

  /// /v2/earthquake/intensity/city/{code}
  static const getV2EarthquakeIntensityCityCode =
      "/v2/earthquake/intensity/city/{code}";

  /// /v2/earthquake/intensity/station/{code}
  static const getV2EarthquakeIntensityStationCode =
      "/v2/earthquake/intensity/station/{code}";

  /// /v2/earthquake/epicenter/{code}
  static const getV2EarthquakeEpicenterCode = "/v2/earthquake/epicenter/{code}";
}
