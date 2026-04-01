// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'admin_replay_file_download_url_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminReplayFileDownloadUrlResponse
_$AdminReplayFileDownloadUrlResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AdminReplayFileDownloadUrlResponse', json, (
      $checkedConvert,
    ) {
      final val = _AdminReplayFileDownloadUrlResponse(
        url: $checkedConvert('url', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$AdminReplayFileDownloadUrlResponseToJson(
  _AdminReplayFileDownloadUrlResponse instance,
) => <String, dynamic>{'url': instance.url};
