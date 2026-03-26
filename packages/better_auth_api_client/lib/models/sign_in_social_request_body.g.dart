// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'sign_in_social_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignInSocialRequestBody _$SignInSocialRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_SignInSocialRequestBody',
  json,
  ($checkedConvert) {
    final val = _SignInSocialRequestBody(
      provider: $checkedConvert('provider', (v) => v as String),
      callbackUrl: $checkedConvert('callbackURL', (v) => v as String?),
      newUserCallbackUrl: $checkedConvert(
        'newUserCallbackURL',
        (v) => v as String?,
      ),
      errorCallbackUrl: $checkedConvert(
        'errorCallbackURL',
        (v) => v as String?,
      ),
      disableRedirect: $checkedConvert('disable_redirect', (v) => v as bool?),
      idToken: $checkedConvert(
        'id_token',
        (v) => v == null ? null : IdToken.fromJson(v as Map<String, dynamic>),
      ),
      scopes: $checkedConvert('scopes', (v) => v as List<dynamic>?),
      requestSignUp: $checkedConvert('request_sign_up', (v) => v as bool?),
      loginHint: $checkedConvert('login_hint', (v) => v as String?),
      additionalData: $checkedConvert('additional_data', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'callbackUrl': 'callbackURL',
    'newUserCallbackUrl': 'newUserCallbackURL',
    'errorCallbackUrl': 'errorCallbackURL',
    'disableRedirect': 'disable_redirect',
    'idToken': 'id_token',
    'requestSignUp': 'request_sign_up',
    'loginHint': 'login_hint',
    'additionalData': 'additional_data',
  },
);

Map<String, dynamic> _$SignInSocialRequestBodyToJson(
  _SignInSocialRequestBody instance,
) => <String, dynamic>{
  'provider': instance.provider,
  'callbackURL': ?instance.callbackUrl,
  'newUserCallbackURL': ?instance.newUserCallbackUrl,
  'errorCallbackURL': ?instance.errorCallbackUrl,
  'disable_redirect': ?instance.disableRedirect,
  'id_token': ?instance.idToken,
  'scopes': ?instance.scopes,
  'request_sign_up': ?instance.requestSignUp,
  'login_hint': ?instance.loginHint,
  'additional_data': ?instance.additionalData,
};
