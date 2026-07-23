// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/shake_detection_active_snapshot.dart';

part 'shake_detection_api_client.g.dart';

@RestApi()
abstract class ShakeDetectionApiClient {
  factory ShakeDetectionApiClient(Dio dio, {String? baseUrl}) = _ShakeDetectionApiClient;

  /// 現在有効な揺れ検知イベントの完全Snapshotを取得
  @GET(ShakeDetectionApiClientUrls.getV2ShakeDetectionActive)
  Future<HttpResponse<ShakeDetectionActiveSnapshot>> getV2ShakeDetectionActive();
}


abstract class ShakeDetectionApiClientUrls {
	/// /v2/shake-detection/active
	static const getV2ShakeDetectionActive = "/v2/shake-detection/active";
}
