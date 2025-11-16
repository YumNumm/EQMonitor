// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'fnet_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FnetEvent _$FnetEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FnetEvent', json, ($checkedConvert) {
      final val = _FnetEvent(
        originTime: $checkedConvert(
          'originTime',
          (v) => DateTime.parse(v as String),
        ),
        latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
        longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        jmaDepth: $checkedConvert('jmaDepth', (v) => (v as num).toDouble()),
        jmaMagnitude: $checkedConvert(
          'jmaMagnitude',
          (v) => (v as num).toDouble(),
        ),
        regionName: $checkedConvert('regionName', (v) => v as String),
        strike: $checkedConvert(
          'strike',
          (v) => FnetAnglePair.fromJson(v as Map<String, dynamic>),
        ),
        dip: $checkedConvert(
          'dip',
          (v) => FnetAnglePair.fromJson(v as Map<String, dynamic>),
        ),
        rake: $checkedConvert(
          'rake',
          (v) => FnetAnglePair.fromJson(v as Map<String, dynamic>),
        ),
        seismicMoment: $checkedConvert(
          'seismicMoment',
          (v) => (v as num).toDouble(),
        ),
        mtDepth: $checkedConvert('mtDepth', (v) => (v as num).toDouble()),
        momentMagnitude: $checkedConvert(
          'momentMagnitude',
          (v) => (v as num).toDouble(),
        ),
        varianceReduction: $checkedConvert(
          'varianceReduction',
          (v) => (v as num).toDouble(),
        ),
        momentTensor: $checkedConvert(
          'momentTensor',
          (v) => FnetMomentTensor.fromJson(v as Map<String, dynamic>),
        ),
        unit: $checkedConvert('unit', (v) => (v as num).toDouble()),
        numberOfStations: $checkedConvert(
          'numberOfStations',
          (v) => (v as num).toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$FnetEventToJson(_FnetEvent instance) =>
    <String, dynamic>{
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
      'momentMagnitude': instance.momentMagnitude,
      'varianceReduction': instance.varianceReduction,
      'momentTensor': instance.momentTensor,
      'unit': instance.unit,
      'numberOfStations': instance.numberOfStations,
    };

_FnetAnglePair _$FnetAnglePairFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FnetAnglePair', json, ($checkedConvert) {
      final val = _FnetAnglePair(
        plane1: $checkedConvert('plane1', (v) => (v as num).toDouble()),
        plane2: $checkedConvert('plane2', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$FnetAnglePairToJson(_FnetAnglePair instance) =>
    <String, dynamic>{'plane1': instance.plane1, 'plane2': instance.plane2};

_FnetMomentTensor _$FnetMomentTensorFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FnetMomentTensor', json, ($checkedConvert) {
      final val = _FnetMomentTensor(
        mxx: $checkedConvert('mxx', (v) => (v as num).toDouble()),
        mxy: $checkedConvert('mxy', (v) => (v as num).toDouble()),
        mxz: $checkedConvert('mxz', (v) => (v as num).toDouble()),
        myy: $checkedConvert('myy', (v) => (v as num).toDouble()),
        myz: $checkedConvert('myz', (v) => (v as num).toDouble()),
        mzz: $checkedConvert('mzz', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$FnetMomentTensorToJson(_FnetMomentTensor instance) =>
    <String, dynamic>{
      'mxx': instance.mxx,
      'mxy': instance.mxy,
      'mxz': instance.mxz,
      'myy': instance.myy,
      'myz': instance.myz,
      'mzz': instance.mzz,
    };
