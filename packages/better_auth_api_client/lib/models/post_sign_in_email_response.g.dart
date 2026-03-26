// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_sign_in_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostSignInEmailResponse _$PostSignInEmailResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostSignInEmailResponse', json, ($checkedConvert) {
  final val = _PostSignInEmailResponse(
    redirect: $checkedConvert(
      'redirect',
      (v) => $enumDecode(_$RedirectEnumMap, v),
    ),
    token: $checkedConvert('token', (v) => v as String),
    user: $checkedConvert(
      'user',
      (v) => User.fromJson(v as Map<String, dynamic>),
    ),
    url: $checkedConvert('url', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$PostSignInEmailResponseToJson(
  _PostSignInEmailResponse instance,
) => <String, dynamic>{
  'redirect': instance.redirect,
  'token': instance.token,
  'user': instance.user,
  'url': ?instance.url,
};

const _$RedirectEnumMap = {Redirect.valueFalse: 'false'};
