// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'get_get_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetGetSessionResponse _$GetGetSessionResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_GetGetSessionResponse', json, ($checkedConvert) {
  final val = _GetGetSessionResponse(
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

Map<String, dynamic> _$GetGetSessionResponseToJson(
  _GetGetSessionResponse instance,
) => <String, dynamic>{'session': instance.session, 'user': instance.user};
