// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_download_service_unavailable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReplayDownloadServiceUnavailable _$ReplayDownloadServiceUnavailableFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ReplayDownloadServiceUnavailable', json, (
  $checkedConvert,
) {
  final val = _ReplayDownloadServiceUnavailable(
    code: $checkedConvert('code', (v) => v as String),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$ReplayDownloadServiceUnavailableToJson(
  _ReplayDownloadServiceUnavailable instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
