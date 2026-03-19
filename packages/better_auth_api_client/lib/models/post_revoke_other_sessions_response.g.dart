// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_revoke_other_sessions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostRevokeOtherSessionsResponse _$PostRevokeOtherSessionsResponseFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('_PostRevokeOtherSessionsResponse', json, ($checkedConvert) {
      final val = _PostRevokeOtherSessionsResponse(
        status: $checkedConvert('status', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$PostRevokeOtherSessionsResponseToJson(
  _PostRevokeOtherSessionsResponse instance,
) => <String, dynamic>{'status': instance.status};
