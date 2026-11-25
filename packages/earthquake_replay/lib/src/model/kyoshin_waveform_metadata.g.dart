// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'kyoshin_waveform_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinWaveformMetadata _$KyoshinWaveformMetadataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_KyoshinWaveformMetadata', json, ($checkedConvert) {
  final val = _KyoshinWaveformMetadata(
    network: $checkedConvert('network', (v) => v as String),
    component: $checkedConvert('component', (v) => v as String),
    stationCode: $checkedConvert('stationCode', (v) => v as String),
    stationLatitude: $checkedConvert(
      'stationLatitude',
      (v) => (v as num).toDouble(),
    ),
    stationLongitude: $checkedConvert(
      'stationLongitude',
      (v) => (v as num).toDouble(),
    ),
    stationHeightMeters: $checkedConvert(
      'stationHeightMeters',
      (v) => (v as num).toDouble(),
    ),
    recordTime: $checkedConvert(
      'recordTime',
      (v) => DateTime.parse(v as String),
    ),
    startTime: $checkedConvert('startTime', (v) => DateTime.parse(v as String)),
    samplingHz: $checkedConvert('samplingHz', (v) => (v as num).toInt()),
    direction: $checkedConvert('direction', (v) => v as String),
    scaleNumeratorGal: $checkedConvert(
      'scaleNumeratorGal',
      (v) => (v as num).toDouble(),
    ),
    scaleDenominator: $checkedConvert(
      'scaleDenominator',
      (v) => (v as num).toDouble(),
    ),
    maxAccelerationGal: $checkedConvert(
      'maxAccelerationGal',
      (v) => (v as num).toDouble(),
    ),
  );
  return val;
});

Map<String, dynamic> _$KyoshinWaveformMetadataToJson(
  _KyoshinWaveformMetadata instance,
) => <String, dynamic>{
  'network': instance.network,
  'component': instance.component,
  'stationCode': instance.stationCode,
  'stationLatitude': instance.stationLatitude,
  'stationLongitude': instance.stationLongitude,
  'stationHeightMeters': instance.stationHeightMeters,
  'recordTime': instance.recordTime.toIso8601String(),
  'startTime': instance.startTime.toIso8601String(),
  'samplingHz': instance.samplingHz,
  'direction': instance.direction,
  'scaleNumeratorGal': instance.scaleNumeratorGal,
  'scaleDenominator': instance.scaleDenominator,
  'maxAccelerationGal': instance.maxAccelerationGal,
};
