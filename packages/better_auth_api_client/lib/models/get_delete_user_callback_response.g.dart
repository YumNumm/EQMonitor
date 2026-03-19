// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'get_delete_user_callback_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetDeleteUserCallbackResponse _$GetDeleteUserCallbackResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_GetDeleteUserCallbackResponse', json, ($checkedConvert) {
  final val = _GetDeleteUserCallbackResponse(
    success: $checkedConvert('success', (v) => v as bool),
    message: $checkedConvert(
      'message',
      (v) => $enumDecode(_$Message3EnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$GetDeleteUserCallbackResponseToJson(
  _GetDeleteUserCallbackResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};

const _$Message3EnumMap = {Message3.userDeleted: 'User deleted'};
