// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';
import 'session.dart';

part 'post_sign_in_anonymous_response.freezed.dart';
part 'post_sign_in_anonymous_response.g.dart';

@Freezed()
abstract class PostSignInAnonymousResponse with _$PostSignInAnonymousResponse {
  const factory PostSignInAnonymousResponse({
    required User user,
    required Session session,
  }) = _PostSignInAnonymousResponse;
  
  factory PostSignInAnonymousResponse.fromJson(Map<String, Object?> json) => _$PostSignInAnonymousResponseFromJson(json);
}
