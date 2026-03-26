// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_delete_anonymous_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostDeleteAnonymousUserResponse _$PostDeleteAnonymousUserResponseFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('_PostDeleteAnonymousUserResponse', json, ($checkedConvert) {
      final val = _PostDeleteAnonymousUserResponse(
        success: $checkedConvert('success', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$PostDeleteAnonymousUserResponseToJson(
  _PostDeleteAnonymousUserResponse instance,
) => <String, dynamic>{'success': instance.success};
