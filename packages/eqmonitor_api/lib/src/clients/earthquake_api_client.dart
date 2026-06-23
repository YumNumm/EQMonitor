// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/earthquake_datasource.dart';
import '../models/earthquake_detail_response.dart';
import '../models/earthquake_list_response.dart';
import '../models/earthquake_sort_by.dart';
import '../models/earthquake_type.dart';
import '../models/intensity_city_search_response.dart';
import '../models/intensity_prefecture_search_response.dart';
import '../models/intensity_region_search_response.dart';
import '../models/intensity_station_search_response.dart';
import '../models/jma_intensity.dart';
import '../models/jma_lpgm_intensity.dart';
import '../models/sort_order.dart';

import '../models/telegram_status.dart';

import '../models/earthquake_telegram_type.dart';

part 'earthquake_api_client.g.dart';

@RestApi()
abstract class EarthquakeApiClient {
  factory EarthquakeApiClient(Dio dio, {String? baseUrl}) =
      _EarthquakeApiClient;

  /// 地震情報一覧.
  ///
  /// [limit] - 1~100 の整数(string).
  ///
  /// [cursor] - カーソル情報, {type}:{id} を base64 エンコードしたもの.
  ///
  /// [magnitudeLte] - 0~20 の実数(string).
  ///
  /// [magnitudeGte] - 0~20 の実数(string).
  ///
  /// [depthLte] - 0~2000 の実数(string).
  ///
  /// [depthGte] - 0~2000 の実数(string).
  ///
  /// [originTimeGte] - 日付 (例: 2024-01-01).
  ///
  /// [originTimeLte] - 日付 (例: 2024-01-01).
  ///
  /// [latitudeGte] - -180~180 の実数(string).
  ///
  /// [latitudeLte] - -180~180 の実数(string).
  ///
  /// [longitudeGte] - -180~180 の実数(string).
  ///
  /// [longitudeLte] - -180~180 の実数(string).
  @GET(EarthquakeApiClientUrls.getV2Earthquake)
  Future<HttpResponse<EarthquakeListResponse>> getV2Earthquake({
    @Query('statuses') List<TelegramStatus> statuses = const [.normal],
    @Query('sortBy') EarthquakeSortBy? sortBy = EarthquakeSortBy.eventId,
    @Query('sortOrder') SortOrder? sortOrder = SortOrder.desc,
    @Query('limit') String? limit,
    @Query('cursor') String? cursor,
    @Query('magnitudeLte') String? magnitudeLte,
    @Query('magnitudeGte') String? magnitudeGte,
    @Query('depthLte') String? depthLte,
    @Query('depthGte') String? depthGte,
    @Query('intensityLte') JmaIntensity? intensityLte,
    @Query('intensityGte') JmaIntensity? intensityGte,
    @Query('maxLpgmIntensityLte') JmaLpgmIntensity? maxLpgmIntensityLte,
    @Query('maxLpgmIntensityGte') JmaLpgmIntensity? maxLpgmIntensityGte,
    @Query('originTimeGte') String? originTimeGte,
    @Query('originTimeLte') String? originTimeLte,
    @Query('epicenterCodes') List<String>? epicenterCodes,
    @Query('epicenterDetailCode') String? epicenterDetailCode,
    @Query('earthquakeType') EarthquakeType? earthquakeType,
    @Query('datasource') EarthquakeDatasource? datasource,
    @Query('telegramTypes') List<EarthquakeTelegramType>? telegramTypes,
    @Query('latitudeGte') String? latitudeGte,
    @Query('latitudeLte') String? latitudeLte,
    @Query('longitudeGte') String? longitudeGte,
    @Query('longitudeLte') String? longitudeLte,
  });

  @GET(EarthquakeApiClientUrls.getV2EarthquakeEventId)
  Future<HttpResponse<EarthquakeDetailResponse>> getV2EarthquakeEventId({
    @Path('eventId') required String eventId,
  });

  /// [limit] - 1~100 の整数(string).
  ///
  /// [cursor] - カーソル情報, {type}:{id} を base64 エンコードしたもの.
  ///
  /// [magnitudeLte] - 0~20 の実数(string).
  ///
  /// [magnitudeGte] - 0~20 の実数(string).
  ///
  /// [depthLte] - 0~2000 の実数(string).
  ///
  /// [depthGte] - 0~2000 の実数(string).
  ///
  /// [originTimeGte] - 日付 (例: 2024-01-01).
  ///
  /// [originTimeLte] - 日付 (例: 2024-01-01).
  ///
  /// [latitudeGte] - -180~180 の実数(string).
  ///
  /// [latitudeLte] - -180~180 の実数(string).
  ///
  /// [longitudeGte] - -180~180 の実数(string).
  ///
  /// [longitudeLte] - -180~180 の実数(string).
  @GET(EarthquakeApiClientUrls.getV2EarthquakeIntensityRegionCode)
  Future<HttpResponse<IntensityRegionSearchResponse>>
  getV2EarthquakeIntensityRegionCode({
    @Path('code') required String code,
    @Query('statuses') List<TelegramStatus> statuses = const [.normal],
    @Query('sortBy') EarthquakeSortBy? sortBy = EarthquakeSortBy.eventId,
    @Query('sortOrder') SortOrder? sortOrder = SortOrder.desc,
    @Query('limit') String? limit,
    @Query('cursor') String? cursor,
    @Query('magnitudeLte') String? magnitudeLte,
    @Query('magnitudeGte') String? magnitudeGte,
    @Query('depthLte') String? depthLte,
    @Query('depthGte') String? depthGte,
    @Query('intensityLte') JmaIntensity? intensityLte,
    @Query('intensityGte') JmaIntensity? intensityGte,
    @Query('maxLpgmIntensityLte') JmaLpgmIntensity? maxLpgmIntensityLte,
    @Query('maxLpgmIntensityGte') JmaLpgmIntensity? maxLpgmIntensityGte,
    @Query('originTimeGte') String? originTimeGte,
    @Query('originTimeLte') String? originTimeLte,
    @Query('epicenterCodes') List<String>? epicenterCodes,
    @Query('epicenterDetailCode') String? epicenterDetailCode,
    @Query('earthquakeType') EarthquakeType? earthquakeType,
    @Query('datasource') EarthquakeDatasource? datasource,
    @Query('telegramTypes') List<EarthquakeTelegramType>? telegramTypes,
    @Query('latitudeGte') String? latitudeGte,
    @Query('latitudeLte') String? latitudeLte,
    @Query('longitudeGte') String? longitudeGte,
    @Query('longitudeLte') String? longitudeLte,
  });

  /// [limit] - 1~100 の整数(string).
  ///
  /// [cursor] - カーソル情報, {type}:{id} を base64 エンコードしたもの.
  ///
  /// [magnitudeLte] - 0~20 の実数(string).
  ///
  /// [magnitudeGte] - 0~20 の実数(string).
  ///
  /// [depthLte] - 0~2000 の実数(string).
  ///
  /// [depthGte] - 0~2000 の実数(string).
  ///
  /// [originTimeGte] - 日付 (例: 2024-01-01).
  ///
  /// [originTimeLte] - 日付 (例: 2024-01-01).
  ///
  /// [latitudeGte] - -180~180 の実数(string).
  ///
  /// [latitudeLte] - -180~180 の実数(string).
  ///
  /// [longitudeGte] - -180~180 の実数(string).
  ///
  /// [longitudeLte] - -180~180 の実数(string).
  @GET(EarthquakeApiClientUrls.getV2EarthquakeIntensityPrefectureCode)
  Future<HttpResponse<IntensityPrefectureSearchResponse>>
  getV2EarthquakeIntensityPrefectureCode({
    @Path('code') required String code,
    @Query('statuses') List<TelegramStatus> statuses = const [.normal],
    @Query('sortBy') EarthquakeSortBy? sortBy = EarthquakeSortBy.eventId,
    @Query('sortOrder') SortOrder? sortOrder = SortOrder.desc,
    @Query('limit') String? limit,
    @Query('cursor') String? cursor,
    @Query('magnitudeLte') String? magnitudeLte,
    @Query('magnitudeGte') String? magnitudeGte,
    @Query('depthLte') String? depthLte,
    @Query('depthGte') String? depthGte,
    @Query('intensityLte') JmaIntensity? intensityLte,
    @Query('intensityGte') JmaIntensity? intensityGte,
    @Query('maxLpgmIntensityLte') JmaLpgmIntensity? maxLpgmIntensityLte,
    @Query('maxLpgmIntensityGte') JmaLpgmIntensity? maxLpgmIntensityGte,
    @Query('originTimeGte') String? originTimeGte,
    @Query('originTimeLte') String? originTimeLte,
    @Query('epicenterCodes') List<String>? epicenterCodes,
    @Query('epicenterDetailCode') String? epicenterDetailCode,
    @Query('earthquakeType') EarthquakeType? earthquakeType,
    @Query('datasource') EarthquakeDatasource? datasource,
    @Query('telegramTypes') List<EarthquakeTelegramType>? telegramTypes,
    @Query('latitudeGte') String? latitudeGte,
    @Query('latitudeLte') String? latitudeLte,
    @Query('longitudeGte') String? longitudeGte,
    @Query('longitudeLte') String? longitudeLte,
  });

  /// [limit] - 1~100 の整数(string).
  ///
  /// [cursor] - カーソル情報, {type}:{id} を base64 エンコードしたもの.
  ///
  /// [magnitudeLte] - 0~20 の実数(string).
  ///
  /// [magnitudeGte] - 0~20 の実数(string).
  ///
  /// [depthLte] - 0~2000 の実数(string).
  ///
  /// [depthGte] - 0~2000 の実数(string).
  ///
  /// [originTimeGte] - 日付 (例: 2024-01-01).
  ///
  /// [originTimeLte] - 日付 (例: 2024-01-01).
  ///
  /// [latitudeGte] - -180~180 の実数(string).
  ///
  /// [latitudeLte] - -180~180 の実数(string).
  ///
  /// [longitudeGte] - -180~180 の実数(string).
  ///
  /// [longitudeLte] - -180~180 の実数(string).
  @GET(EarthquakeApiClientUrls.getV2EarthquakeIntensityCityCode)
  Future<HttpResponse<IntensityCitySearchResponse>>
  getV2EarthquakeIntensityCityCode({
    @Path('code') required String code,
    @Query('statuses') List<TelegramStatus> statuses = const [.normal],
    @Query('sortBy') EarthquakeSortBy? sortBy = EarthquakeSortBy.eventId,
    @Query('sortOrder') SortOrder? sortOrder = SortOrder.desc,
    @Query('limit') String? limit,
    @Query('cursor') String? cursor,
    @Query('magnitudeLte') String? magnitudeLte,
    @Query('magnitudeGte') String? magnitudeGte,
    @Query('depthLte') String? depthLte,
    @Query('depthGte') String? depthGte,
    @Query('intensityLte') JmaIntensity? intensityLte,
    @Query('intensityGte') JmaIntensity? intensityGte,
    @Query('maxLpgmIntensityLte') JmaLpgmIntensity? maxLpgmIntensityLte,
    @Query('maxLpgmIntensityGte') JmaLpgmIntensity? maxLpgmIntensityGte,
    @Query('originTimeGte') String? originTimeGte,
    @Query('originTimeLte') String? originTimeLte,
    @Query('epicenterCodes') List<String>? epicenterCodes,
    @Query('epicenterDetailCode') String? epicenterDetailCode,
    @Query('earthquakeType') EarthquakeType? earthquakeType,
    @Query('datasource') EarthquakeDatasource? datasource,
    @Query('telegramTypes') List<EarthquakeTelegramType>? telegramTypes,
    @Query('latitudeGte') String? latitudeGte,
    @Query('latitudeLte') String? latitudeLte,
    @Query('longitudeGte') String? longitudeGte,
    @Query('longitudeLte') String? longitudeLte,
  });

  /// [limit] - 1~100 の整数(string).
  ///
  /// [cursor] - カーソル情報, {type}:{id} を base64 エンコードしたもの.
  ///
  /// [magnitudeLte] - 0~20 の実数(string).
  ///
  /// [magnitudeGte] - 0~20 の実数(string).
  ///
  /// [depthLte] - 0~2000 の実数(string).
  ///
  /// [depthGte] - 0~2000 の実数(string).
  ///
  /// [originTimeGte] - 日付 (例: 2024-01-01).
  ///
  /// [originTimeLte] - 日付 (例: 2024-01-01).
  ///
  /// [latitudeGte] - -180~180 の実数(string).
  ///
  /// [latitudeLte] - -180~180 の実数(string).
  ///
  /// [longitudeGte] - -180~180 の実数(string).
  ///
  /// [longitudeLte] - -180~180 の実数(string).
  @GET(EarthquakeApiClientUrls.getV2EarthquakeIntensityStationCode)
  Future<HttpResponse<IntensityStationSearchResponse>>
  getV2EarthquakeIntensityStationCode({
    @Path('code') required String code,
    @Query('statuses') List<TelegramStatus> statuses = const [.normal],
    @Query('sortBy') EarthquakeSortBy? sortBy = EarthquakeSortBy.eventId,
    @Query('sortOrder') SortOrder? sortOrder = SortOrder.desc,
    @Query('limit') String? limit,
    @Query('cursor') String? cursor,
    @Query('magnitudeLte') String? magnitudeLte,
    @Query('magnitudeGte') String? magnitudeGte,
    @Query('depthLte') String? depthLte,
    @Query('depthGte') String? depthGte,
    @Query('intensityLte') JmaIntensity? intensityLte,
    @Query('intensityGte') JmaIntensity? intensityGte,
    @Query('maxLpgmIntensityLte') JmaLpgmIntensity? maxLpgmIntensityLte,
    @Query('maxLpgmIntensityGte') JmaLpgmIntensity? maxLpgmIntensityGte,
    @Query('originTimeGte') String? originTimeGte,
    @Query('originTimeLte') String? originTimeLte,
    @Query('epicenterCodes') List<String>? epicenterCodes,
    @Query('epicenterDetailCode') String? epicenterDetailCode,
    @Query('earthquakeType') EarthquakeType? earthquakeType,
    @Query('datasource') EarthquakeDatasource? datasource,
    @Query('telegramTypes') List<EarthquakeTelegramType>? telegramTypes,
    @Query('latitudeGte') String? latitudeGte,
    @Query('latitudeLte') String? latitudeLte,
    @Query('longitudeGte') String? longitudeGte,
    @Query('longitudeLte') String? longitudeLte,
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
}
