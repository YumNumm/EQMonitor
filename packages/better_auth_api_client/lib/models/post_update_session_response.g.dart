// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_update_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostUpdateSessionResponse _$PostUpdateSessionResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostUpdateSessionResponse', json, ($checkedConvert) {
  final val = _PostUpdateSessionResponse(
    session: $checkedConvert(
      'session',
      (v) => Session.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$PostUpdateSessionResponseToJson(
  _PostUpdateSessionResponse instance,
) => <String, dynamic>{'session': instance.session};
