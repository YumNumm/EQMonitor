// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/hypocenter_list_response.dart';
import '../models/hypocenter_manifest_response.dart';

part 'hypocenters_api_client.g.dart';

@RestApi()
abstract class HypocentersApiClient {
  factory HypocentersApiClient(Dio dio, {String? baseUrl}) = _HypocentersApiClient;

  /// MapLibre向け震源PMTiles manifest.
  ///
  /// [ifNoneMatch] - ETag validator for conditional GET.
  ///
  /// [ifModifiedSince] - Last-Modified validator for conditional GET.
  @GET(HypocentersApiClientUrls.getV2HypocentersManifest)
  Future<HttpResponse<HypocenterManifestResponse>> getV2HypocentersManifest({
    @Header('If-None-Match') String? ifNoneMatch,
    @Header('If-Modified-Since') String? ifModifiedSince,
  });

  /// 期間・Polygon・震源要素で個別震源を検索.
  ///
  /// [ifNoneMatch] - ETag validator for conditional GET.
  ///
  /// [ifModifiedSince] - Last-Modified validator for conditional GET.
  @GET(HypocentersApiClientUrls.getV2Hypocenters)
  Future<HttpResponse<HypocenterListResponse>> getV2Hypocenters({
    @Query('origin_time_gte') required DateTime originTimeGte,
    @Query('origin_time_lte') required DateTime originTimeLte,
    @Query('limit') int? limit = 100,
    @Query('area') String? area,
    @Query('magnitude_gte') String? magnitudeGte,
    @Query('magnitude_lte') String? magnitudeLte,
    @Query('depth_gte') String? depthGte,
    @Query('depth_lte') String? depthLte,
    @Query('determination_flags') String? determinationFlags,
    @Query('earthquake_event_id') String? earthquakeEventId,
    @Query('cursor') String? cursor,
    @Query('expected_revision') String? expectedRevision,
    @CancelRequest() CancelToken? cancelToken,
    @Header('If-None-Match') String? ifNoneMatch,
    @Header('If-Modified-Since') String? ifModifiedSince,
  });
}


abstract class HypocentersApiClientUrls {
	/// /v2/hypocenters/manifest
	static const getV2HypocentersManifest = "/v2/hypocenters/manifest";
	/// /v2/hypocenters
	static const getV2Hypocenters = "/v2/hypocenters";
}
