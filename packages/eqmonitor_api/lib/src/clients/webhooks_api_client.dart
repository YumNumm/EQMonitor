// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'webhooks_api_client.g.dart';

@RestApi()
abstract class WebhooksApiClient {
  factory WebhooksApiClient(Dio dio, {String? baseUrl}) = _WebhooksApiClient;

  /// RevenueCat Webhook イベントを受信してサブスクリプション状態を更新する
  @POST(WebhooksApiClientUrls.postWebhooksRevenuecat)
  Future<HttpResponse<void>> postWebhooksRevenuecat();
}


abstract class WebhooksApiClientUrls {
	/// /webhooks/revenuecat
	static const postWebhooksRevenuecat = "/webhooks/revenuecat";
}

