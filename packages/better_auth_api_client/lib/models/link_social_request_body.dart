// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'id_token2.dart';

part 'link_social_request_body.freezed.dart';
part 'link_social_request_body.g.dart';

@Freezed()
abstract class LinkSocialRequestBody with _$LinkSocialRequestBody {
  const factory LinkSocialRequestBody({
    required String provider,

    /// The URL to redirect to after the user has signed in
    @JsonKey(includeIfNull: false,name: 'callbackURL')
    String? callbackUrl,
    @JsonKey(includeIfNull: false)
    IdToken2? idToken,
    @JsonKey(includeIfNull: false)
    bool? requestSignUp,

    /// Additional scopes to request from the provider
    @JsonKey(includeIfNull: false)
    List<dynamic>? scopes,

    /// The URL to redirect to if there is an error during the link process
    @JsonKey(includeIfNull: false,name: 'errorCallbackURL')
    String? errorCallbackUrl,

    /// Disable automatic redirection to the provider. Useful for handling the redirection yourself
    @JsonKey(includeIfNull: false)
    bool? disableRedirect,
    @JsonKey(includeIfNull: false)
    String? additionalData,
  }) = _LinkSocialRequestBody;
  
  factory LinkSocialRequestBody.fromJson(Map<String, Object?> json) => _$LinkSocialRequestBodyFromJson(json);
}
