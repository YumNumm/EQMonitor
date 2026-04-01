// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/realtime_examples_response.dart';
import '../models/realtime_state.dart';

part 'realtime_api_client.g.dart';

@RestApi()
abstract class RealtimeApiClient {
  factory RealtimeApiClient(Dio dio, {String? baseUrl}) = _RealtimeApiClient;

  /// リアルタイム状態のスナップショット（揺れ検知・EEW は Redis、地震・津波は常に DB から取得）
  @GET(RealtimeApiClientUrls.getV2RealtimeState)
  Future<HttpResponse<RealtimeState>> getV2RealtimeState();

  /// 単一 SSE（旧 WebSocket 相当の discriminated union JSON を event: realtime で配信）
  @GET(RealtimeApiClientUrls.getV2RealtimeStream)
  Future<HttpResponse<void>> getV2RealtimeStream();

  /// SSE data: と同一形のサンプル JSON（OpenAPI / クライアント codegen 用）
  @GET(RealtimeApiClientUrls.getV2RealtimeExamples)
  Future<HttpResponse<RealtimeExamplesResponse>> getV2RealtimeExamples();
}

abstract class RealtimeApiClientUrls {
  /// /v2/realtime/state
  static const getV2RealtimeState = "/v2/realtime/state";

  /// /v2/realtime/stream
  static const getV2RealtimeStream = "/v2/realtime/stream";

  /// /v2/realtime/examples
  static const getV2RealtimeExamples = "/v2/realtime/examples";
}
