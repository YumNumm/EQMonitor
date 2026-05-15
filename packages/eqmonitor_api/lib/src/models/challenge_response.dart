// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_response.freezed.dart';
part 'challenge_response.g.dart';

@Freezed()
abstract class ChallengeResponse with _$ChallengeResponse {
  const factory ChallengeResponse({
    required String challengeCode,
    required DateTime expiresAt,
  }) = _ChallengeResponse;
  
  factory ChallengeResponse.fromJson(Map<String, Object?> json) => _$ChallengeResponseFromJson(json);
}
