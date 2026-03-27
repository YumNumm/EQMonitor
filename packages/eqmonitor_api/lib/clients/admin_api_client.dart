// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/admin_dispatch_summary_detail_response.dart';
import '../models/admin_dispatch_summary_list_response.dart';

part 'admin_api_client.g.dart';

@RestApi()
abstract class AdminApiClient {
  factory AdminApiClient(Dio dio, {String? baseUrl}) = _AdminApiClient;

  /// 配信サマリー一覧
  @GET(AdminApiClientUrls.getV2AdminDispatches)
  Future<HttpResponse<AdminDispatchSummaryListResponse>> getV2AdminDispatches();

  /// 配信サマリー詳細
  @GET(AdminApiClientUrls.getV2AdminDispatchesCorrelationKey)
  Future<HttpResponse<AdminDispatchSummaryDetailResponse>> getV2AdminDispatchesCorrelationKey({
    @Path('correlationKey') required String correlationKey,
  });
}


abstract class AdminApiClientUrls {
	/// /v2/admin/dispatches
	static const getV2AdminDispatches = "/v2/admin/dispatches";
	/// /v2/admin/dispatches/{correlationKey}
	static const getV2AdminDispatchesCorrelationKey = "/v2/admin/dispatches/{correlationKey}";
}

