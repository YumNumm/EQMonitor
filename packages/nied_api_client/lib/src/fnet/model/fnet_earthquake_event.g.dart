// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'fnet_earthquake_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FnetEarthquakeEvent _$FnetEarthquakeEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_FnetEarthquakeEvent', json, ($checkedConvert) {
  final val = _FnetEarthquakeEvent(
    originTime: $checkedConvert(
      'originTime',
      (v) => DateTime.parse(v as String),
    ),
    latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
    longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
    jmaDepth: $checkedConvert('jmaDepth', (v) => (v as num).toDouble()),
    jmaMagnitude: $checkedConvert('jmaMagnitude', (v) => (v as num).toDouble()),
    regionName: $checkedConvert('regionName', (v) => v as String),
    strike: $checkedConvert(
      'strike',
      (v) => FaultParameterPair.fromJson(v as Map<String, dynamic>),
    ),
    dip: $checkedConvert(
      'dip',
      (v) => FaultParameterPair.fromJson(v as Map<String, dynamic>),
    ),
    rake: $checkedConvert(
      'rake',
      (v) => FaultParameterPair.fromJson(v as Map<String, dynamic>),
    ),
    seismicMoment: $checkedConvert(
      'seismicMoment',
      (v) => (v as num).toDouble(),
    ),
    mtDepth: $checkedConvert('mtDepth', (v) => (v as num).toDouble()),
    mtMagnitude: $checkedConvert('mtMagnitude', (v) => (v as num).toDouble()),
    varianceReduction: $checkedConvert(
      'varianceReduction',
      (v) => (v as num).toDouble(),
    ),
    momentTensor: $checkedConvert(
      'momentTensor',
      (v) => MomentTensor.fromJson(v as Map<String, dynamic>),
    ),
    unit: $checkedConvert('unit', (v) => (v as num).toDouble()),
    numberOfStations: $checkedConvert(
      'numberOfStations',
      (v) => (v as num).toInt(),
    ),
  );
  return val;
});

Map<String, dynamic> _$FnetEarthquakeEventToJson(
  _FnetEarthquakeEvent instance,
) => <String, dynamic>{
  'originTime': instance.originTime.toIso8601String(),
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'jmaDepth': instance.jmaDepth,
  'jmaMagnitude': instance.jmaMagnitude,
  'regionName': instance.regionName,
  'strike': instance.strike,
  'dip': instance.dip,
  'rake': instance.rake,
  'seismicMoment': instance.seismicMoment,
  'mtDepth': instance.mtDepth,
  'mtMagnitude': instance.mtMagnitude,
  'varianceReduction': instance.varianceReduction,
  'momentTensor': instance.momentTensor,
  'unit': instance.unit,
  'numberOfStations': instance.numberOfStations,
};

_FaultParameterPair _$FaultParameterPairFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FaultParameterPair', json, ($checkedConvert) {
      final val = _FaultParameterPair(
        plane1: $checkedConvert('plane1', (v) => (v as num).toDouble()),
        plane2: $checkedConvert('plane2', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$FaultParameterPairToJson(_FaultParameterPair instance) =>
    <String, dynamic>{'plane1': instance.plane1, 'plane2': instance.plane2};

_MomentTensor _$MomentTensorFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MomentTensor', json, ($checkedConvert) {
      final val = _MomentTensor(
        mxx: $checkedConvert('mxx', (v) => (v as num).toDouble()),
        mxy: $checkedConvert('mxy', (v) => (v as num).toDouble()),
        mxz: $checkedConvert('mxz', (v) => (v as num).toDouble()),
        myy: $checkedConvert('myy', (v) => (v as num).toDouble()),
        myz: $checkedConvert('myz', (v) => (v as num).toDouble()),
        mzz: $checkedConvert('mzz', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$MomentTensorToJson(_MomentTensor instance) =>
    <String, dynamic>{
      'mxx': instance.mxx,
      'mxy': instance.mxy,
      'mxz': instance.mxz,
      'myy': instance.myy,
      'myz': instance.myz,
      'mzz': instance.mzz,
    };
