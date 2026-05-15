// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/get_v2_subscription_me_response_union.dart';

part 'subscription_api_client.g.dart';

@RestApi()
abstract class SubscriptionApiClient {
  factory SubscriptionApiClient(Dio dio, {String? baseUrl}) = _SubscriptionApiClient;

  /// 現在のサブスクリプション状態を取得する。Authorization: Bearer <deviceToken> が必要。
  @GET(SubscriptionApiClientUrls.getV2SubscriptionMe)
  Future<HttpResponse<GetV2SubscriptionMeResponseUnion>> getV2SubscriptionMe();
}


abstract class SubscriptionApiClientUrls {
	/// /v2/subscription/me
	static const getV2SubscriptionMe = "/v2/subscription/me";
}

