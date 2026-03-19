// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_sign_in_anonymous_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostSignInAnonymousResponse _$PostSignInAnonymousResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostSignInAnonymousResponse', json, ($checkedConvert) {
  final val = _PostSignInAnonymousResponse(
    user: $checkedConvert(
      'user',
      (v) => User.fromJson(v as Map<String, dynamic>),
    ),
    session: $checkedConvert(
      'session',
      (v) => Session.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$PostSignInAnonymousResponseToJson(
  _PostSignInAnonymousResponse instance,
) => <String, dynamic>{'user': instance.user, 'session': instance.session};
