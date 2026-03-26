// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_link_social_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostLinkSocialResponse _$PostLinkSocialResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostLinkSocialResponse', json, ($checkedConvert) {
  final val = _PostLinkSocialResponse(
    redirect: $checkedConvert('redirect', (v) => v as bool),
    url: $checkedConvert('url', (v) => v as String?),
    status: $checkedConvert('status', (v) => v as bool?),
  );
  return val;
});

Map<String, dynamic> _$PostLinkSocialResponseToJson(
  _PostLinkSocialResponse instance,
) => <String, dynamic>{
  'redirect': instance.redirect,
  'url': ?instance.url,
  'status': ?instance.status,
};
