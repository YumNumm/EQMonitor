// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knet_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KnetRecord _$KnetRecordFromJson(Map<String, dynamic> json) => _KnetRecord(
  earthquakeInfo: json['earthquakeInfo'] == null
      ? null
      : KnetEarthquakeInfo.fromJson(
          json['earthquakeInfo'] as Map<String, dynamic>,
        ),
  stationInfo: KnetStationInfo.fromJson(
    json['stationInfo'] as Map<String, dynamic>,
  ),
  recordTime: DateTime.parse(json['recordTime'] as String),
  samplingFrequencyHz: (json['samplingFrequencyHz'] as num).toDouble(),
  durationTimeSec: (json['durationTimeSec'] as num).toDouble(),
  direction: $enumDecode(_$KnetChannelDirectionEnumMap, json['direction']),
  scaleFactorNumerator: (json['scaleFactorNumerator'] as num).toDouble(),
  scaleFactorDenominator: (json['scaleFactorDenominator'] as num).toDouble(),
  maxAccelerationGal: (json['maxAccelerationGal'] as num).toDouble(),
  lastCorrection: json['lastCorrection'] == null
      ? null
      : DateTime.parse(json['lastCorrection'] as String),
  memo: json['memo'] as String,
  rawData: (json['rawData'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  networkType: $enumDecode(_$KnetNetworkTypeEnumMap, json['networkType']),
);

Map<String, dynamic> _$KnetRecordToJson(_KnetRecord instance) =>
    <String, dynamic>{
      'earthquakeInfo': instance.earthquakeInfo,
      'stationInfo': instance.stationInfo,
      'recordTime': instance.recordTime.toIso8601String(),
      'samplingFrequencyHz': instance.samplingFrequencyHz,
      'durationTimeSec': instance.durationTimeSec,
      'direction': _$KnetChannelDirectionEnumMap[instance.direction]!,
      'scaleFactorNumerator': instance.scaleFactorNumerator,
      'scaleFactorDenominator': instance.scaleFactorDenominator,
      'maxAccelerationGal': instance.maxAccelerationGal,
      'lastCorrection': instance.lastCorrection?.toIso8601String(),
      'memo': instance.memo,
      'rawData': instance.rawData,
      'networkType': _$KnetNetworkTypeEnumMap[instance.networkType]!,
    };

const _$KnetChannelDirectionEnumMap = {
  KnetChannelDirection.ns: 'ns',
  KnetChannelDirection.ew: 'ew',
  KnetChannelDirection.ud: 'ud',
  KnetChannelDirection.ns2: 'ns2',
  KnetChannelDirection.ew2: 'ew2',
  KnetChannelDirection.ud2: 'ud2',
};

const _$KnetNetworkTypeEnumMap = {
  KnetNetworkType.knet: 'knet',
  KnetNetworkType.kiknet: 'kiknet',
};

_KnetEarthquakeInfo _$KnetEarthquakeInfoFromJson(Map<String, dynamic> json) =>
    _KnetEarthquakeInfo(
      originTime: DateTime.parse(json['originTime'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      depthKm: (json['depthKm'] as num).toDouble(),
      magnitude: (json['magnitude'] as num).toDouble(),
    );

Map<String, dynamic> _$KnetEarthquakeInfoToJson(_KnetEarthquakeInfo instance) =>
    <String, dynamic>{
      'originTime': instance.originTime.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'depthKm': instance.depthKm,
      'magnitude': instance.magnitude,
    };

_KnetStationInfo _$KnetStationInfoFromJson(Map<String, dynamic> json) =>
    _KnetStationInfo(
      stationCode: json['stationCode'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      heightM: (json['heightM'] as num).toDouble(),
    );

Map<String, dynamic> _$KnetStationInfoToJson(_KnetStationInfo instance) =>
    <String, dynamic>{
      'stationCode': instance.stationCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'heightM': instance.heightM,
    };
