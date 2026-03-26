// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_update_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostUpdateUserResponse _$PostUpdateUserResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostUpdateUserResponse', json, ($checkedConvert) {
  final val = _PostUpdateUserResponse(
    user: $checkedConvert(
      'user',
      (v) => User.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$PostUpdateUserResponseToJson(
  _PostUpdateUserResponse instance,
) => <String, dynamic>{'user': instance.user};
