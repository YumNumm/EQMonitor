// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_latest_service_unavailable_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewLatestServiceUnavailableResponse
_$EewLatestServiceUnavailableResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EewLatestServiceUnavailableResponse', json, (
      $checkedConvert,
    ) {
      final val = _EewLatestServiceUnavailableResponse(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$EewLatestServiceUnavailableResponseToJson(
  _EewLatestServiceUnavailableResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
