// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_sign_out_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostSignOutResponse _$PostSignOutResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PostSignOutResponse', json, ($checkedConvert) {
      final val = _PostSignOutResponse(
        success: $checkedConvert('success', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$PostSignOutResponseToJson(
  _PostSignOutResponse instance,
) => <String, dynamic>{'success': instance.success};
