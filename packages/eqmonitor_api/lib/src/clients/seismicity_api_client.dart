// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/seismicity_manifest_response.dart';

part 'seismicity_api_client.g.dart';

@RestApi()
abstract class SeismicityApiClient {
  factory SeismicityApiClient(Dio dio, {String? baseUrl}) = _SeismicityApiClient;

  /// 地震活動可視化用GeoJSONレイヤーのmanifest
  @GET(SeismicityApiClientUrls.getV2SeismicityManifest)
  Future<HttpResponse<SeismicityManifestResponse>> getV2SeismicityManifest();
}


abstract class SeismicityApiClientUrls {
	/// /v2/seismicity/manifest
	static const getV2SeismicityManifest = "/v2/seismicity/manifest";
}

