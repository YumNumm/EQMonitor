// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_sign_in_social_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostSignInSocialResponse _$PostSignInSocialResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostSignInSocialResponse', json, ($checkedConvert) {
  final val = _PostSignInSocialResponse(
    token: $checkedConvert('token', (v) => v as String),
    user: $checkedConvert(
      'user',
      (v) => User.fromJson(v as Map<String, dynamic>),
    ),
    redirect: $checkedConvert(
      'redirect',
      (v) => $enumDecode(_$RedirectEnumMap, v),
    ),
    url: $checkedConvert('url', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$PostSignInSocialResponseToJson(
  _PostSignInSocialResponse instance,
) => <String, dynamic>{
  'token': instance.token,
  'user': instance.user,
  'redirect': instance.redirect,
  'url': ?instance.url,
};

const _$RedirectEnumMap = {Redirect.valueFalse: 'false'};
