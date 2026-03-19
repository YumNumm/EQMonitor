// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/eew_array_response.dart';
import '../models/eew_item_with_relations.dart';
import '../models/eew_latest_response.dart';
import '../models/eew_list_response.dart';

part 'eew_api_client.g.dart';

@RestApi()
abstract class EewApiClient {
  factory EewApiClient(Dio dio, {String? baseUrl}) = _EewApiClient;

  /// 最終報の緊急地震速報一覧を取得.
  ///
  /// [limit] - 1~100 の整数(string).
  @GET(EewApiClientUrls.getV2Eew)
  Future<HttpResponse<EewListResponse>> getV2Eew({
    @Query('limit') String? limit,
  });

  @GET(EewApiClientUrls.getV2EewLatest)
  Future<HttpResponse<EewLatestResponse>> getV2EewLatest();

  @GET(EewApiClientUrls.getV2EewEventId)
  Future<HttpResponse<EewArrayResponse>> getV2EewEventId({
    @Path('eventId') required String eventId,
  });

  @GET(EewApiClientUrls.getV2EewEventIdSerialNo)
  Future<HttpResponse<EewItemWithRelations>> getV2EewEventIdSerialNo({
    @Path('eventId') required String eventId,
    @Path('serialNo') required String serialNo,
  });
}

abstract class EewApiClientUrls {
  /// /v2/eew
  static const getV2Eew = "/v2/eew";

  /// /v2/eew/latest
  static const getV2EewLatest = "/v2/eew/latest";

  /// /v2/eew/{eventId}
  static const getV2EewEventId = "/v2/eew/{eventId}";

  /// /v2/eew/{eventId}/{serialNo}
  static const getV2EewEventIdSerialNo = "/v2/eew/{eventId}/{serialNo}";
}
