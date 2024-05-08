// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'earthquake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarthquakeImpl _$$EarthquakeImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeImpl(
          originTime:
              $checkedConvert('originTime', (v) => DateTime.parse(v as String)),
          arrivalTime: $checkedConvert(
              'arrivalTime', (v) => DateTime.parse(v as String)),
          hypocenter: $checkedConvert('hypocenter',
              (v) => EarthquakeHypocenter.fromJson(v as Map<String, dynamic>)),
          magnitude: $checkedConvert('magnitude',
              (v) => EarthquakeMagnitude.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeImplToJson(_$EarthquakeImpl instance) =>
    <String, dynamic>{
      'originTime': instance.originTime.toIso8601String(),
      'arrivalTime': instance.arrivalTime.toIso8601String(),
      'hypocenter': instance.hypocenter,
      'magnitude': instance.magnitude,
    };

_$EarthquakeHypocenterImpl _$$EarthquakeHypocenterImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeHypocenterImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeHypocenterImpl(
          name: $checkedConvert('name', (v) => v as String),
          code: $checkedConvert('code', (v) => v as String),
          depth: $checkedConvert('depth', (v) => (v as num?)?.toInt()),
          detailed: $checkedConvert(
              'detailed',
              (v) => v == null
                  ? null
                  : EarthquakeHypocenterDetailed.fromJson(
                      v as Map<String, dynamic>)),
          coordinate: $checkedConvert(
              'coordinate',
              (v) => v == null
                  ? null
                  : LatLng.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeHypocenterImplToJson(
        _$EarthquakeHypocenterImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'depth': instance.depth,
      'detailed': instance.detailed,
      'coordinate': instance.coordinate,
    };

_$EarthquakeHypocenterDetailedImpl _$$EarthquakeHypocenterDetailedImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeHypocenterDetailedImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeHypocenterDetailedImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeHypocenterDetailedImplToJson(
        _$EarthquakeHypocenterDetailedImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

_$EarthquakeMagnitudeImpl _$$EarthquakeMagnitudeImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeMagnitudeImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeMagnitudeImpl(
          value: $checkedConvert('value', (v) => (v as num?)?.toDouble()),
          condition: $checkedConvert('condition', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeMagnitudeImplToJson(
        _$EarthquakeMagnitudeImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'condition': instance.condition,
    };
