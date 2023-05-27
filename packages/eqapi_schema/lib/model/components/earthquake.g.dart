// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earthquake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Earthquake _$$_EarthquakeFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_Earthquake',
      json,
      ($checkedConvert) {
        final val = _$_Earthquake(
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

Map<String, dynamic> _$$_EarthquakeToJson(_$_Earthquake instance) =>
    <String, dynamic>{
      'originTime': instance.originTime.toIso8601String(),
      'arrivalTime': instance.arrivalTime.toIso8601String(),
      'hypocenter': instance.hypocenter,
      'magnitude': instance.magnitude,
    };

_$_EarthquakeHypocenter _$$_EarthquakeHypocenterFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_EarthquakeHypocenter',
      json,
      ($checkedConvert) {
        final val = _$_EarthquakeHypocenter(
          name: $checkedConvert('name', (v) => v as String),
          code: $checkedConvert('code', (v) => v as String),
          depth: $checkedConvert('depth', (v) => v as int?),
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

Map<String, dynamic> _$$_EarthquakeHypocenterToJson(
        _$_EarthquakeHypocenter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'depth': instance.depth,
      'detailed': instance.detailed,
      'coordinate': instance.coordinate,
    };

_$_EarthquakeHypocenterDetailed _$$_EarthquakeHypocenterDetailedFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_EarthquakeHypocenterDetailed',
      json,
      ($checkedConvert) {
        final val = _$_EarthquakeHypocenterDetailed(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_EarthquakeHypocenterDetailedToJson(
        _$_EarthquakeHypocenterDetailed instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

_$_EarthquakeMagnitude _$$_EarthquakeMagnitudeFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_EarthquakeMagnitude',
      json,
      ($checkedConvert) {
        final val = _$_EarthquakeMagnitude(
          value: $checkedConvert('value', (v) => (v as num?)?.toDouble()),
          condition: $checkedConvert('condition', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_EarthquakeMagnitudeToJson(
        _$_EarthquakeMagnitude instance) =>
    <String, dynamic>{
      'value': instance.value,
      'condition': instance.condition,
    };
