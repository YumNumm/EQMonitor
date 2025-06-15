// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'replay_file_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReplayFileHeader _$ReplayFileHeaderFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_ReplayFileHeader',
      json,
      ($checkedConvert) {
        final val = _ReplayFileHeader(
          version: $checkedConvert('version', (v) => (v as num).toInt()),
          softwareName: $checkedConvert('software_name', (v) => v as String),
          startTime: $checkedConvert(
            'start_time',
            (v) => DateTime.parse(v as String),
          ),
          endTime: $checkedConvert(
            'end_time',
            (v) => DateTime.parse(v as String),
          ),
          compressionMode: $checkedConvert(
            'compression_mode',
            (v) => $enumDecode(_$ReplayFileCompressionModeEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'softwareName': 'software_name',
        'startTime': 'start_time',
        'endTime': 'end_time',
        'compressionMode': 'compression_mode',
      },
    );

Map<String, dynamic> _$ReplayFileHeaderToJson(_ReplayFileHeader instance) =>
    <String, dynamic>{
      'version': instance.version,
      'software_name': instance.softwareName,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'compression_mode':
          _$ReplayFileCompressionModeEnumMap[instance.compressionMode]!,
    };

const _$ReplayFileCompressionModeEnumMap = {
  ReplayFileCompressionMode.none: 'none',
  ReplayFileCompressionMode.messagePackCSharpLz4BlockArray:
      'messagePackCSharpLz4BlockArray',
  ReplayFileCompressionMode.gzip: 'gzip',
  ReplayFileCompressionMode.brotli: 'brotli',
};
