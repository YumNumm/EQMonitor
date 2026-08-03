// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter_service_unavailable_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HypocenterServiceUnavailableResponse
_$HypocenterServiceUnavailableResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_HypocenterServiceUnavailableResponse', json, (
      $checkedConvert,
    ) {
      final val = _HypocenterServiceUnavailableResponse(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$HypocenterServiceUnavailableResponseToJson(
  _HypocenterServiceUnavailableResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
