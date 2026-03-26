// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/post_delete_anonymous_user_response.dart';
import '../models/post_sign_in_anonymous_response.dart';

part 'anonymous_api_client.g.dart';

@RestApi()
abstract class AnonymousApiClient {
  factory AnonymousApiClient(Dio dio, {String? baseUrl}) = _AnonymousApiClient;

  /// Sign in anonymously
  @POST(AnonymousApiClientUrls.postSignInAnonymous)
  Future<HttpResponse<PostSignInAnonymousResponse>> postSignInAnonymous();

  /// Delete an anonymous user
  @POST(AnonymousApiClientUrls.postDeleteAnonymousUser)
  Future<HttpResponse<PostDeleteAnonymousUserResponse>> postDeleteAnonymousUser();
}


abstract class AnonymousApiClientUrls {
	/// /sign-in/anonymous
	static const postSignInAnonymous = "/sign-in/anonymous";
	/// /delete-anonymous-user
	static const postDeleteAnonymousUser = "/delete-anonymous-user";
}

