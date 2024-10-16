// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'shake_detection_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShakeDetectionWebSocketTelegramImpl
    _$$ShakeDetectionWebSocketTelegramImplFromJson(Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$ShakeDetectionWebSocketTelegramImpl',
          json,
          ($checkedConvert) {
            final val = _$ShakeDetectionWebSocketTelegramImpl(
              events: $checkedConvert(
                  'events',
                  (v) => (v as List<dynamic>)
                      .map((e) => ShakeDetectionEvent.fromJson(
                          e as Map<String, dynamic>))
                      .toList()),
            );
            return val;
          },
        );

Map<String, dynamic> _$$ShakeDetectionWebSocketTelegramImplToJson(
        _$ShakeDetectionWebSocketTelegramImpl instance) =>
    <String, dynamic>{
      'events': instance.events,
    };

_$ShakeDetectionEventImpl _$$ShakeDetectionEventImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ShakeDetectionEventImpl',
      json,
      ($checkedConvert) {
        final val = _$ShakeDetectionEventImpl(
          id: $checkedConvert('id', (v) => (v as num?)?.toInt() ?? -1),
          eventId: $checkedConvert('event_id', (v) => v as String),
          serialNo:
              $checkedConvert('serial_no', (v) => (v as num?)?.toInt() ?? -1),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
          insertedAt: $checkedConvert(
              'inserted_at', (v) => DateTime.parse(v as String)),
          maxIntensity: $checkedConvert(
              'max_intensity',
              (v) =>
                  $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v,
                      unknownValue: JmaForecastIntensity.unknown) ??
                  JmaForecastIntensity.unknown),
          regions: $checkedConvert(
              'regions',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      ShakeDetectionRegion.fromJson(e as Map<String, dynamic>))
                  .toList()),
          topLeft: $checkedConvert('top_left',
              (v) => ShakeDetectionLatLng.fromJson(v as Map<String, dynamic>)),
          bottomRight: $checkedConvert('bottom_right',
              (v) => ShakeDetectionLatLng.fromJson(v as Map<String, dynamic>)),
          pointCount: $checkedConvert('point_count', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'serialNo': 'serial_no',
        'createdAt': 'created_at',
        'insertedAt': 'inserted_at',
        'maxIntensity': 'max_intensity',
        'topLeft': 'top_left',
        'bottomRight': 'bottom_right',
        'pointCount': 'point_count'
      },
    );

Map<String, dynamic> _$$ShakeDetectionEventImplToJson(
        _$ShakeDetectionEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'serial_no': instance.serialNo,
      'created_at': instance.createdAt.toIso8601String(),
      'inserted_at': instance.insertedAt.toIso8601String(),
      'max_intensity': _$JmaForecastIntensityEnumMap[instance.maxIntensity]!,
      'regions': instance.regions,
      'top_left': instance.topLeft,
      'bottom_right': instance.bottomRight,
      'point_count': instance.pointCount,
    };

const _$JmaForecastIntensityEnumMap = {
  JmaForecastIntensity.zero: '0',
  JmaForecastIntensity.one: '1',
  JmaForecastIntensity.two: '2',
  JmaForecastIntensity.three: '3',
  JmaForecastIntensity.four: '4',
  JmaForecastIntensity.fiveLower: '5-',
  JmaForecastIntensity.fiveUpper: '5+',
  JmaForecastIntensity.sixLower: '6-',
  JmaForecastIntensity.sixUpper: '6+',
  JmaForecastIntensity.seven: '7',
  JmaForecastIntensity.unknown: '不明',
};

_$ShakeDetectionRegionImpl _$$ShakeDetectionRegionImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ShakeDetectionRegionImpl',
      json,
      ($checkedConvert) {
        final val = _$ShakeDetectionRegionImpl(
          name: $checkedConvert('name', (v) => v as String),
          maxIntensity: $checkedConvert(
              'maxIntensity',
              (v) =>
                  $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v,
                      unknownValue: JmaForecastIntensity.unknown) ??
                  JmaForecastIntensity.unknown),
          points: $checkedConvert(
              'points',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      ShakeDetectionPoint.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$ShakeDetectionRegionImplToJson(
        _$ShakeDetectionRegionImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'maxIntensity': _$JmaForecastIntensityEnumMap[instance.maxIntensity]!,
      'points': instance.points,
    };

_$ShakeDetectionPointImpl _$$ShakeDetectionPointImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ShakeDetectionPointImpl',
      json,
      ($checkedConvert) {
        final val = _$ShakeDetectionPointImpl(
          intensity: $checkedConvert(
              'intensity',
              (v) =>
                  $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v,
                      unknownValue: JmaForecastIntensity.unknown) ??
                  JmaForecastIntensity.unknown),
          code: $checkedConvert('code', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$ShakeDetectionPointImplToJson(
        _$ShakeDetectionPointImpl instance) =>
    <String, dynamic>{
      'intensity': _$JmaForecastIntensityEnumMap[instance.intensity]!,
      'code': instance.code,
    };

_$ShakeDetectionLatLngImpl _$$ShakeDetectionLatLngImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ShakeDetectionLatLngImpl',
      json,
      ($checkedConvert) {
        final val = _$ShakeDetectionLatLngImpl(
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$ShakeDetectionLatLngImplToJson(
        _$ShakeDetectionLatLngImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
