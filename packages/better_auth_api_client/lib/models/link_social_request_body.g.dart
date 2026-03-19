// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'link_social_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LinkSocialRequestBody _$LinkSocialRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_LinkSocialRequestBody',
  json,
  ($checkedConvert) {
    final val = _LinkSocialRequestBody(
      provider: $checkedConvert('provider', (v) => v as String),
      callbackUrl: $checkedConvert('callbackURL', (v) => v as String?),
      idToken: $checkedConvert(
        'id_token',
        (v) => v == null ? null : IdToken2.fromJson(v as Map<String, dynamic>),
      ),
      requestSignUp: $checkedConvert('request_sign_up', (v) => v as bool?),
      scopes: $checkedConvert('scopes', (v) => v as List<dynamic>?),
      errorCallbackUrl: $checkedConvert(
        'errorCallbackURL',
        (v) => v as String?,
      ),
      disableRedirect: $checkedConvert('disable_redirect', (v) => v as bool?),
      additionalData: $checkedConvert('additional_data', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'callbackUrl': 'callbackURL',
    'idToken': 'id_token',
    'requestSignUp': 'request_sign_up',
    'errorCallbackUrl': 'errorCallbackURL',
    'disableRedirect': 'disable_redirect',
    'additionalData': 'additional_data',
  },
);

Map<String, dynamic> _$LinkSocialRequestBodyToJson(
  _LinkSocialRequestBody instance,
) => <String, dynamic>{
  'provider': instance.provider,
  'callbackURL': ?instance.callbackUrl,
  'id_token': ?instance.idToken,
  'request_sign_up': ?instance.requestSignUp,
  'scopes': ?instance.scopes,
  'errorCallbackURL': ?instance.errorCallbackUrl,
  'disable_redirect': ?instance.disableRedirect,
  'additional_data': ?instance.additionalData,
};
