// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_sign_up_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostSignUpEmailResponse _$PostSignUpEmailResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostSignUpEmailResponse', json, ($checkedConvert) {
  final val = _PostSignUpEmailResponse(
    user: $checkedConvert(
      'user',
      (v) => User2.fromJson(v as Map<String, dynamic>),
    ),
    token: $checkedConvert('token', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$PostSignUpEmailResponseToJson(
  _PostSignUpEmailResponse instance,
) => <String, dynamic>{'user': instance.user, 'token': ?instance.token};
