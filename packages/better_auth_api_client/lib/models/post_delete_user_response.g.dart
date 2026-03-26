// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_delete_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostDeleteUserResponse _$PostDeleteUserResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostDeleteUserResponse', json, ($checkedConvert) {
  final val = _PostDeleteUserResponse(
    success: $checkedConvert('success', (v) => v as bool),
    message: $checkedConvert(
      'message',
      (v) => $enumDecode(_$Message2EnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$PostDeleteUserResponseToJson(
  _PostDeleteUserResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};

const _$Message2EnumMap = {
  Message2.userDeleted: 'User deleted',
  Message2.verificationEmailSent: 'Verification email sent',
};
