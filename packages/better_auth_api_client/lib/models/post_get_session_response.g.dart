// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_get_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostGetSessionResponse _$PostGetSessionResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostGetSessionResponse', json, ($checkedConvert) {
  final val = _PostGetSessionResponse(
    session: $checkedConvert(
      'session',
      (v) => Session.fromJson(v as Map<String, dynamic>),
    ),
    user: $checkedConvert(
      'user',
      (v) => User.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$PostGetSessionResponseToJson(
  _PostGetSessionResponse instance,
) => <String, dynamic>{'session': instance.session, 'user': instance.user};
