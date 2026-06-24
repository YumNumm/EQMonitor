// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


import '../models/parameter_type.dart';
import '../models/parameters_manifest_response.dart';

part 'parameters_api_client.g.dart';

@RestApi()
abstract class ParametersApiClient {
  factory ParametersApiClient(Dio dio, {String? baseUrl}) = _ParametersApiClient;

  /// パラメーターデータのバージョン・取得先一覧
  @GET(ParametersApiClientUrls.getV2ParametersManifest)
  Future<HttpResponse<ParametersManifestResponse>> getV2ParametersManifest({
    @Header('if-none-match') String? ifNoneMatch,
  });

  /// 指定したパラメーターデータ
  @GET(ParametersApiClientUrls.getV2ParametersType)
  Future<HttpResponse<Map<String, Object?>>> getV2ParametersType({
    @Path('type') required ParameterType type,
    @Header('if-none-match') String? ifNoneMatch,
  });
}


abstract class ParametersApiClientUrls {
	/// /v2/parameters/manifest
	static const getV2ParametersManifest = "/v2/parameters/manifest";
	/// /v2/parameters/{type}
	static const getV2ParametersType = "/v2/parameters/{type}";
}

