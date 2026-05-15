// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'challenge_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChallengeResponse _$ChallengeResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ChallengeResponse', json, ($checkedConvert) {
      final val = _ChallengeResponse(
        challengeCode: $checkedConvert('challengeCode', (v) => v as String),
        expiresAt: $checkedConvert(
          'expiresAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ChallengeResponseToJson(_ChallengeResponse instance) =>
    <String, dynamic>{
      'challengeCode': instance.challengeCode,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };
