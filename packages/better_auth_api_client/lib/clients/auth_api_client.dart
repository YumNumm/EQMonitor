// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/change_email_request_body.dart';
import '../models/change_password_request_body.dart';
import '../models/delete_user_request_body.dart';
import '../models/get_access_token_request_body.dart';
import '../models/get_account_info_response.dart';
import '../models/get_delete_user_callback_response.dart';
import '../models/get_get_session_response.dart';
import '../models/get_list_accounts_response.dart';
import '../models/get_ok_response.dart';
import '../models/get_reset_password_token_response.dart';
import '../models/get_verify_email_response.dart';
import '../models/link_social_request_body.dart';
import '../models/post_change_email_response.dart';
import '../models/post_change_password_response.dart';
import '../models/post_delete_user_response.dart';
import '../models/post_get_access_token_response.dart';
import '../models/post_get_session_response.dart';
import '../models/post_link_social_response.dart';
import '../models/post_refresh_token_response.dart';
import '../models/post_request_password_reset_response.dart';
import '../models/post_reset_password_response.dart';
import '../models/post_revoke_other_sessions_response.dart';
import '../models/post_revoke_session_response.dart';
import '../models/post_revoke_sessions_response.dart';
import '../models/post_send_verification_email_response.dart';
import '../models/post_sign_in_email_response.dart';
import '../models/post_sign_in_social_response.dart';
import '../models/post_sign_out_response.dart';
import '../models/post_sign_up_email_response.dart';
import '../models/post_unlink_account_response.dart';
import '../models/post_update_session_response.dart';
import '../models/post_update_user_response.dart';
import '../models/post_verify_password_response.dart';
import '../models/refresh_token_request_body.dart';
import '../models/request_password_reset_request_body.dart';
import '../models/reset_password_request_body.dart';
import '../models/revoke_session_request_body.dart';
import '../models/send_verification_email_request_body.dart';
import '../models/session.dart';
import '../models/sign_in_email_request_body.dart';
import '../models/sign_in_social_request_body.dart';
import '../models/sign_up_email_request_body.dart';
import '../models/unlink_account_request_body.dart';
import '../models/update_user_request_body.dart';
import '../models/verify_password_request_body.dart';

part 'auth_api_client.g.dart';

@RestApi()
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String? baseUrl}) = _AuthApiClient;

  /// Sign in with a social provider
  @POST(AuthApiClientUrls.postSignInSocial)
  Future<HttpResponse<PostSignInSocialResponse>> postSignInSocial({
    @Body() required SignInSocialRequestBody body,
  });

  @GET(AuthApiClientUrls.getCallbackId)
  Future<HttpResponse<void>> getCallbackId();

  @POST(AuthApiClientUrls.postCallbackId)
  Future<HttpResponse<void>> postCallbackId({
    @Body() dynamic body,
  });

  /// Get the current session
  @GET(AuthApiClientUrls.getGetSession)
  Future<HttpResponse<GetGetSessionResponse?>> getGetSession();

  /// Get the current session
  @POST(AuthApiClientUrls.postGetSession)
  Future<HttpResponse<PostGetSessionResponse?>> postGetSession({
    @Body() dynamic body,
  });

  /// Sign out the current user
  @POST(AuthApiClientUrls.postSignOut)
  Future<HttpResponse<PostSignOutResponse>> postSignOut({
    @Body() dynamic body,
  });

  /// Sign up a user using email and password
  @POST(AuthApiClientUrls.postSignUpEmail)
  Future<HttpResponse<PostSignUpEmailResponse>> postSignUpEmail({
    @Body() SignUpEmailRequestBody? body,
  });

  /// Sign in with email and password
  @POST(AuthApiClientUrls.postSignInEmail)
  Future<HttpResponse<PostSignInEmailResponse>> postSignInEmail({
    @Body() required SignInEmailRequestBody body,
  });

  /// Reset the password for a user
  @POST(AuthApiClientUrls.postResetPassword)
  Future<HttpResponse<PostResetPasswordResponse>> postResetPassword({
    @Body() required ResetPasswordRequestBody body,
  });

  /// Verify the current user's password
  @POST(AuthApiClientUrls.postVerifyPassword)
  Future<HttpResponse<PostVerifyPasswordResponse>> postVerifyPassword({
    @Body() required VerifyPasswordRequestBody body,
  });

  /// Verify the email of the user.
  ///
  /// [token] - The token to verify the email.
  ///
  /// [callbackUrl] - The URL to redirect to after email verification.
  @GET(AuthApiClientUrls.getVerifyEmail)
  Future<HttpResponse<GetVerifyEmailResponse>> getVerifyEmail({
    @Query('token') required String token,
    @Query('callbackURL') String? callbackUrl,
  });

  /// Send a verification email to the user
  @POST(AuthApiClientUrls.postSendVerificationEmail)
  Future<HttpResponse<PostSendVerificationEmailResponse>> postSendVerificationEmail({
    @Body() SendVerificationEmailRequestBody? body,
  });

  @POST(AuthApiClientUrls.postChangeEmail)
  Future<HttpResponse<PostChangeEmailResponse>> postChangeEmail({
    @Body() required ChangeEmailRequestBody body,
  });

  /// Change the password of the user
  @POST(AuthApiClientUrls.postChangePassword)
  Future<HttpResponse<PostChangePasswordResponse>> postChangePassword({
    @Body() required ChangePasswordRequestBody body,
  });

  /// Update the current session
  @POST(AuthApiClientUrls.postUpdateSession)
  Future<HttpResponse<PostUpdateSessionResponse>> postUpdateSession({
    @Body() dynamic body,
  });

  /// Update the current user
  @POST(AuthApiClientUrls.postUpdateUser)
  Future<HttpResponse<PostUpdateUserResponse>> postUpdateUser({
    @Body() UpdateUserRequestBody? body,
  });

  /// Delete the user
  @POST(AuthApiClientUrls.postDeleteUser)
  Future<HttpResponse<PostDeleteUserResponse>> postDeleteUser({
    @Body() DeleteUserRequestBody? body,
  });

  /// Send a password reset email to the user
  @POST(AuthApiClientUrls.postRequestPasswordReset)
  Future<HttpResponse<PostRequestPasswordResetResponse>> postRequestPasswordReset({
    @Body() required RequestPasswordResetRequestBody body,
  });

  /// Redirects the user to the callback URL with the token.
  ///
  /// [token] - The token to reset the password.
  ///
  /// [callbackUrl] - The URL to redirect the user to reset their password.
  @GET(AuthApiClientUrls.getResetPasswordToken)
  Future<HttpResponse<GetResetPasswordTokenResponse>> getResetPasswordToken({
    @Path('token') required String token,
    @Query('callbackURL') required String callbackUrl,
  });

  /// List all active sessions for the user
  @GET(AuthApiClientUrls.getListSessions)
  Future<HttpResponse<List<Session>>> getListSessions();

  /// Revoke a single session
  @POST(AuthApiClientUrls.postRevokeSession)
  Future<HttpResponse<PostRevokeSessionResponse>> postRevokeSession({
    @Body() RevokeSessionRequestBody? body,
  });

  /// Revoke all sessions for the user
  @POST(AuthApiClientUrls.postRevokeSessions)
  Future<HttpResponse<PostRevokeSessionsResponse>> postRevokeSessions({
    @Body() dynamic body,
  });

  /// Revoke all other sessions for the user except the current one
  @POST(AuthApiClientUrls.postRevokeOtherSessions)
  Future<HttpResponse<PostRevokeOtherSessionsResponse>> postRevokeOtherSessions({
    @Body() dynamic body,
  });

  /// Link a social account to the user
  @POST(AuthApiClientUrls.postLinkSocial)
  Future<HttpResponse<PostLinkSocialResponse>> postLinkSocial({
    @Body() required LinkSocialRequestBody body,
  });

  /// List all accounts linked to the user
  @GET(AuthApiClientUrls.getListAccounts)
  Future<HttpResponse<List<GetListAccountsResponse>>> getListAccounts();

  /// Callback to complete user deletion with verification token
  @GET(AuthApiClientUrls.getDeleteUserCallback)
  Future<HttpResponse<GetDeleteUserCallbackResponse>> getDeleteUserCallback({
    @Query('token') String? token,
    @Query('callbackURL') String? callbackUrl,
  });

  /// Unlink an account
  @POST(AuthApiClientUrls.postUnlinkAccount)
  Future<HttpResponse<PostUnlinkAccountResponse>> postUnlinkAccount({
    @Body() required UnlinkAccountRequestBody body,
  });

  /// Refresh the access token using a refresh token
  @POST(AuthApiClientUrls.postRefreshToken)
  Future<HttpResponse<PostRefreshTokenResponse>> postRefreshToken({
    @Body() required RefreshTokenRequestBody body,
  });

  /// Get a valid access token, doing a refresh if needed
  @POST(AuthApiClientUrls.postGetAccessToken)
  Future<HttpResponse<PostGetAccessTokenResponse>> postGetAccessToken({
    @Body() required GetAccessTokenRequestBody body,
  });

  /// Get the account info provided by the provider
  @GET(AuthApiClientUrls.getAccountInfo)
  Future<HttpResponse<GetAccountInfoResponse>> getAccountInfo();

  /// Check if the API is working
  @GET(AuthApiClientUrls.getOk)
  Future<HttpResponse<GetOkResponse>> getOk();

  /// Displays an error page
  @GET(AuthApiClientUrls.getError)
  Future<HttpResponse<String>> getError();
}


abstract class AuthApiClientUrls {
	/// /sign-in/social
	static const postSignInSocial = "/sign-in/social";
	/// /callback/{id}
	static const getCallbackId = "/callback/{id}";
	/// /callback/{id}
	static const postCallbackId = "/callback/{id}";
	/// /get-session
	static const getGetSession = "/get-session";
	/// /get-session
	static const postGetSession = "/get-session";
	/// /sign-out
	static const postSignOut = "/sign-out";
	/// /sign-up/email
	static const postSignUpEmail = "/sign-up/email";
	/// /sign-in/email
	static const postSignInEmail = "/sign-in/email";
	/// /reset-password
	static const postResetPassword = "/reset-password";
	/// /verify-password
	static const postVerifyPassword = "/verify-password";
	/// /verify-email
	static const getVerifyEmail = "/verify-email";
	/// /send-verification-email
	static const postSendVerificationEmail = "/send-verification-email";
	/// /change-email
	static const postChangeEmail = "/change-email";
	/// /change-password
	static const postChangePassword = "/change-password";
	/// /update-session
	static const postUpdateSession = "/update-session";
	/// /update-user
	static const postUpdateUser = "/update-user";
	/// /delete-user
	static const postDeleteUser = "/delete-user";
	/// /request-password-reset
	static const postRequestPasswordReset = "/request-password-reset";
	/// /reset-password/{token}
	static const getResetPasswordToken = "/reset-password/{token}";
	/// /list-sessions
	static const getListSessions = "/list-sessions";
	/// /revoke-session
	static const postRevokeSession = "/revoke-session";
	/// /revoke-sessions
	static const postRevokeSessions = "/revoke-sessions";
	/// /revoke-other-sessions
	static const postRevokeOtherSessions = "/revoke-other-sessions";
	/// /link-social
	static const postLinkSocial = "/link-social";
	/// /list-accounts
	static const getListAccounts = "/list-accounts";
	/// /delete-user/callback
	static const getDeleteUserCallback = "/delete-user/callback";
	/// /unlink-account
	static const postUnlinkAccount = "/unlink-account";
	/// /refresh-token
	static const postRefreshToken = "/refresh-token";
	/// /get-access-token
	static const postGetAccessToken = "/get-access-token";
	/// /account-info
	static const getAccountInfo = "/account-info";
	/// /ok
	static const getOk = "/ok";
	/// /error
	static const getError = "/error";
}

