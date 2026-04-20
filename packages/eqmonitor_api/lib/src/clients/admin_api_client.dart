// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/admin_dispatch_summary_detail_response.dart';
import '../models/admin_dispatch_summary_list_response.dart';
import '../models/admin_replay_file_detail_response.dart';
import '../models/admin_replay_file_download_url_response.dart';
import '../models/admin_replay_file_list_response.dart';

part 'admin_api_client.g.dart';

@RestApi()
abstract class AdminApiClient {
  factory AdminApiClient(Dio dio, {String? baseUrl}) = _AdminApiClient;

  /// 配信サマリー一覧
  @GET(AdminApiClientUrls.getV2AdminDispatches)
  Future<HttpResponse<AdminDispatchSummaryListResponse>> getV2AdminDispatches();

  /// 配信サマリー詳細
  @GET(AdminApiClientUrls.getV2AdminDispatchesCorrelationKey)
  Future<HttpResponse<AdminDispatchSummaryDetailResponse>>
  getV2AdminDispatchesCorrelationKey({
    @Path('correlationKey') required String correlationKey,
  });

  /// リプレイファイル一覧.
  ///
  /// [cursor] - カーソル情報, {type}:{id} を base64 エンコードしたもの.
  @GET(AdminApiClientUrls.getV2AdminReplayFiles)
  Future<HttpResponse<AdminReplayFileListResponse>> getV2AdminReplayFiles({
    @Query('limit') String? limit,
    @Query('cursor') String? cursor,
  });

  /// リプレイファイル詳細（トリガー情報含む）
  @GET(AdminApiClientUrls.getV2AdminReplayFilesId)
  Future<HttpResponse<AdminReplayFileDetailResponse>> getV2AdminReplayFilesId({
    @Path('id') required String id,
  });

  /// 署名付きダウンロード URL 発行
  @GET(AdminApiClientUrls.getV2AdminReplayFilesIdDownloadUrl)
  Future<HttpResponse<AdminReplayFileDownloadUrlResponse>>
  getV2AdminReplayFilesIdDownloadUrl({
    @Path('id') required String id,
  });
}

abstract class AdminApiClientUrls {
  /// /v2/admin/dispatches
  static const getV2AdminDispatches = "/v2/admin/dispatches";

  /// /v2/admin/dispatches/{correlationKey}
  static const getV2AdminDispatchesCorrelationKey =
      "/v2/admin/dispatches/{correlationKey}";

  /// /v2/admin/replay-files
  static const getV2AdminReplayFiles = "/v2/admin/replay-files";

  /// /v2/admin/replay-files/{id}
  static const getV2AdminReplayFilesId = "/v2/admin/replay-files/{id}";

  /// /v2/admin/replay-files/{id}/download-url
  static const getV2AdminReplayFilesIdDownloadUrl =
      "/v2/admin/replay-files/{id}/download-url";
}
