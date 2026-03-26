// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_revoke_sessions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostRevokeSessionsResponse _$PostRevokeSessionsResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostRevokeSessionsResponse', json, ($checkedConvert) {
  final val = _PostRevokeSessionsResponse(
    status: $checkedConvert('status', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$PostRevokeSessionsResponseToJson(
  _PostRevokeSessionsResponse instance,
) => <String, dynamic>{'status': instance.status};
