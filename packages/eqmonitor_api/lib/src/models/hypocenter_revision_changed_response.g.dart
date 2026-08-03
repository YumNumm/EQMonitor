// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter_revision_changed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HypocenterRevisionChangedResponse _$HypocenterRevisionChangedResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_HypocenterRevisionChangedResponse', json, (
  $checkedConvert,
) {
  final val = _HypocenterRevisionChangedResponse(
    code: $checkedConvert('code', (v) => v as String),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$HypocenterRevisionChangedResponseToJson(
  _HypocenterRevisionChangedResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
