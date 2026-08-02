// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameters_manifest_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParametersManifestResponse _$ParametersManifestResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ParametersManifestResponse', json, ($checkedConvert) {
  final val = _ParametersManifestResponse(
    parameters: $checkedConvert(
      'parameters',
      (v) => (v as List<dynamic>)
          .map((e) => ParameterManifestItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ParametersManifestResponseToJson(
  _ParametersManifestResponse instance,
) => <String, dynamic>{'parameters': instance.parameters};
