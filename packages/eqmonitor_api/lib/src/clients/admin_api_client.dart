// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/admin_dispatch_summary_detail_response.dart';
import '../models/admin_dispatch_summary_list_response.dart';
import '../models/admin_earthquake_archive_detail_response.dart';
import '../models/admin_earthquake_archive_download_url_response.dart';
import '../models/admin_earthquake_archive_list_response.dart';
import '../models/admin_replay_file_detail_response.dart';
import '../models/admin_replay_file_download_url_response.dart';
import '../models/admin_replay_file_list_response.dart';
import '../models/earthquake_archive_type.dart';
import '../models/post_v2_admin_simulation_eew_response.dart';
import '../models/v2_admin_simulation_eew_request_body.dart';

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

  /// 地震アーカイブ一覧（フレームの種類ごとの件数・容量を含む）.
  ///
  /// [cursor] - カーソル情報, {type}:{id} を base64 エンコードしたもの.
  @GET(AdminApiClientUrls.getV2AdminEarthquakeArchives)
  Future<HttpResponse<AdminEarthquakeArchiveListResponse>> getV2AdminEarthquakeArchives({
    @Query('limit') int? limit,
    @Query('cursor') String? cursor,
    @Query('type') EarthquakeArchiveType? type,
  });

  /// 地震アーカイブ詳細（フレームの種類ごとの件数・容量を含む）
  @GET(AdminApiClientUrls.getV2AdminEarthquakeArchivesEventId)
  Future<HttpResponse<AdminEarthquakeArchiveDetailResponse>> getV2AdminEarthquakeArchivesEventId({
    @Path('eventId') required String eventId,
  });

  /// 地震アーカイブの署名付きダウンロード URL 発行
  @GET(AdminApiClientUrls.getV2AdminEarthquakeArchivesEventIdDownloadUrl)
  Future<HttpResponse<AdminEarthquakeArchiveDownloadUrlResponse>> getV2AdminEarthquakeArchivesEventIdDownloadUrl({
    @Path('eventId') required String eventId,
  });

  /// 地震アーカイブのファイル（.eqrp）を返す。保存先は外から開けないため、API が中継する。
  @GET(AdminApiClientUrls.getV2AdminEarthquakeArchivesEventIdFile)
  Future<HttpResponse<void>> getV2AdminEarthquakeArchivesEventIdFile({
    @Path('eventId') required String eventId,
  });
}


abstract class AdminApiClientUrls {
	/// /v2/admin/dispatches
	static const getV2AdminDispatches = "/v2/admin/dispatches";
	/// /v2/admin/dispatches/{correlationKey}
	static const getV2AdminDispatchesCorrelationKey = "/v2/admin/dispatches/{correlationKey}";
	/// /v2/admin/simulation/eew
	static const postV2AdminSimulationEew = "/v2/admin/simulation/eew";
	/// /v2/admin/replay-files
	static const getV2AdminReplayFiles = "/v2/admin/replay-files";
	/// /v2/admin/replay-files/{id}
	static const getV2AdminReplayFilesId = "/v2/admin/replay-files/{id}";
	/// /v2/admin/replay-files/{id}/download-url
	static const getV2AdminReplayFilesIdDownloadUrl = "/v2/admin/replay-files/{id}/download-url";
	/// /v2/admin/earthquake-archives
	static const getV2AdminEarthquakeArchives = "/v2/admin/earthquake-archives";
	/// /v2/admin/earthquake-archives/{eventId}
	static const getV2AdminEarthquakeArchivesEventId = "/v2/admin/earthquake-archives/{eventId}";
	/// /v2/admin/earthquake-archives/{eventId}/download-url
	static const getV2AdminEarthquakeArchivesEventIdDownloadUrl = "/v2/admin/earthquake-archives/{eventId}/download-url";
	/// /v2/admin/earthquake-archives/{eventId}/file
	static const getV2AdminEarthquakeArchivesEventIdFile = "/v2/admin/earthquake-archives/{eventId}/file";
}

