// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/admin_dispatch_summary_detail_response.dart';
import '../models/admin_dispatch_summary_list_response.dart';
import '../models/admin_replay_file_detail_response.dart';
import '../models/admin_replay_file_download_url_response.dart';
import '../models/admin_replay_file_list_response.dart';
import '../models/post_v2_admin_simulation_eew_response.dart';
import '../models/post_v2_admin_test_live_event_response.dart';
import '../models/v2_admin_simulation_eew_request_body.dart';
import '../models/v2_admin_test_live_event_request_body.dart';

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

  /// 任意のデバイスにテスト用Live Activityイベントを送信
  @POST(AdminApiClientUrls.postV2AdminTestLiveEvent)
  Future<HttpResponse<PostV2AdminTestLiveEventResponse>> postV2AdminTestLiveEvent({
    @Body() required V2AdminTestLiveEventRequestBody body,
  });

  /// EEW Live Activity 高頻度シミュレーション。指定シナリオのイベントを Redis events ストリームに投入する。test-scenario- プレフィクス + targetDeviceId で安全に1台のみへ配信。
  @POST(AdminApiClientUrls.postV2AdminSimulationEew)
  Future<HttpResponse<PostV2AdminSimulationEewResponse>> postV2AdminSimulationEew({
    @Body() required V2AdminSimulationEewRequestBody body,
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
  Future<HttpResponse<AdminReplayFileDownloadUrlResponse>> getV2AdminReplayFilesIdDownloadUrl({
    @Path('id') required String id,
  });
}


abstract class AdminApiClientUrls {
	/// /v2/admin/dispatches
	static const getV2AdminDispatches = "/v2/admin/dispatches";
	/// /v2/admin/dispatches/{correlationKey}
	static const getV2AdminDispatchesCorrelationKey = "/v2/admin/dispatches/{correlationKey}";
	/// /v2/admin/test-live-event
	static const postV2AdminTestLiveEvent = "/v2/admin/test-live-event";
	/// /v2/admin/simulation/eew
	static const postV2AdminSimulationEew = "/v2/admin/simulation/eew";
	/// /v2/admin/replay-files
	static const getV2AdminReplayFiles = "/v2/admin/replay-files";
	/// /v2/admin/replay-files/{id}
	static const getV2AdminReplayFilesId = "/v2/admin/replay-files/{id}";
	/// /v2/admin/replay-files/{id}/download-url
	static const getV2AdminReplayFilesIdDownloadUrl = "/v2/admin/replay-files/{id}/download-url";
}

