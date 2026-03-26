// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_link_social_response.freezed.dart';
part 'post_link_social_response.g.dart';

@Freezed()
abstract class PostLinkSocialResponse with _$PostLinkSocialResponse {
  const factory PostLinkSocialResponse({
    /// Indicates if the user should be redirected to the authorization URL
    required bool redirect,

    /// The authorization URL to redirect the user to
    @JsonKey(includeIfNull: false)
    String? url,
    @JsonKey(includeIfNull: false)
    bool? status,
  }) = _PostLinkSocialResponse;
  
  factory PostLinkSocialResponse.fromJson(Map<String, Object?> json) => _$PostLinkSocialResponseFromJson(json);
}
