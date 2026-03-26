// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'id_token.dart';

part 'sign_in_social_request_body.freezed.dart';
part 'sign_in_social_request_body.g.dart';

@Freezed()
abstract class SignInSocialRequestBody with _$SignInSocialRequestBody {
  const factory SignInSocialRequestBody({
    required String provider,

    /// Callback URL to redirect to after the user has signed in
    @JsonKey(includeIfNull: false,name: 'callbackURL')
    String? callbackUrl,
    @JsonKey(includeIfNull: false,name: 'newUserCallbackURL')
    String? newUserCallbackUrl,

    /// Callback URL to redirect to if an error happens
    @JsonKey(includeIfNull: false,name: 'errorCallbackURL')
    String? errorCallbackUrl,

    /// Disable automatic redirection to the provider. Useful for handling the redirection yourself
    @JsonKey(includeIfNull: false)
    bool? disableRedirect,
    @JsonKey(includeIfNull: false)
    IdToken? idToken,

    /// Array of scopes to request from the provider. This will override the default scopes passed.
    @JsonKey(includeIfNull: false)
    List<dynamic>? scopes,

    /// Explicitly request sign-up. Useful when disableImplicitSignUp is true for this provider
    @JsonKey(includeIfNull: false)
    bool? requestSignUp,

    /// The login hint to use for the authorization code request
    @JsonKey(includeIfNull: false)
    String? loginHint,
    @JsonKey(includeIfNull: false)
    String? additionalData,
  }) = _SignInSocialRequestBody;
  
  factory SignInSocialRequestBody.fromJson(Map<String, Object?> json) => _$SignInSocialRequestBodyFromJson(json);
}
