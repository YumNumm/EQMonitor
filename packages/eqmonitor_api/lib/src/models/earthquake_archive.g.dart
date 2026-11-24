// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_archive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeArchive _$EarthquakeArchiveFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EarthquakeArchive', json, ($checkedConvert) {
      final val = _EarthquakeArchive(
        eventId: $checkedConvert('eventId', (v) => v as String),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$EarthquakeArchiveTypeEnumMap, v),
        ),
        objectKey: $checkedConvert('objectKey', (v) => v as String),
        originTime: $checkedConvert('originTime', (v) => v as String),
        startTime: $checkedConvert('startTime', (v) => v as String),
        endTime: $checkedConvert('endTime', (v) => v as String),
        magnitude: $checkedConvert('magnitude', (v) => v as num?),
        hypocenterName: $checkedConvert('hypocenterName', (v) => v as String?),
        fileSizeBytes: $checkedConvert('fileSizeBytes', (v) => v as num),
        waveformStatus: $checkedConvert(
          'waveformStatus',
          (v) => $enumDecode(_$EarthquakeArchiveWaveformStatusEnumMap, v),
        ),
        waveformCheckedAt: $checkedConvert(
          'waveformCheckedAt',
          (v) => v as String?,
        ),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
        updatedAt: $checkedConvert('updatedAt', (v) => v as String),
        frames: $checkedConvert(
          'frames',
          (v) => (v as List<dynamic>)
              .map(
                (e) =>
                    EarthquakeArchiveFrame.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EarthquakeArchiveToJson(_EarthquakeArchive instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'type': instance.type,
      'objectKey': instance.objectKey,
      'originTime': instance.originTime,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'magnitude': instance.magnitude,
      'hypocenterName': instance.hypocenterName,
      'fileSizeBytes': instance.fileSizeBytes,
      'waveformStatus': instance.waveformStatus,
      'waveformCheckedAt': instance.waveformCheckedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'frames': instance.frames,
    };

const _$EarthquakeArchiveTypeEnumMap = {
  EarthquakeArchiveType.eew: 'EEW',
  EarthquakeArchiveType.earthquake: 'EARTHQUAKE',
  EarthquakeArchiveType.eewEarthquake: 'EEW_EARTHQUAKE',
};

const _$EarthquakeArchiveWaveformStatusEnumMap = {
  EarthquakeArchiveWaveformStatus.pending: 'PENDING',
  EarthquakeArchiveWaveformStatus.attached: 'ATTACHED',
  EarthquakeArchiveWaveformStatus.notPublished: 'NOT_PUBLISHED',
};
