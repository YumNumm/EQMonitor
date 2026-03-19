// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_revoke_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostRevokeSessionResponse _$PostRevokeSessionResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostRevokeSessionResponse', json, ($checkedConvert) {
  final val = _PostRevokeSessionResponse(
    status: $checkedConvert('status', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$PostRevokeSessionResponseToJson(
  _PostRevokeSessionResponse instance,
) => <String, dynamic>{'status': instance.status};
