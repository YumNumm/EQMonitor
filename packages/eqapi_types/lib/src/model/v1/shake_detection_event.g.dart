// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'shake_detection_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShakeDetectionWebSocketTelegram _$ShakeDetectionWebSocketTelegramFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ShakeDetectionWebSocketTelegram', json, (
  $checkedConvert,
) {
  final val = _ShakeDetectionWebSocketTelegram(
    events: $checkedConvert(
      'events',
      (v) => (v as List<dynamic>)
          .map((e) => ShakeDetectionEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ShakeDetectionWebSocketTelegramToJson(
  _ShakeDetectionWebSocketTelegram instance,
) => <String, dynamic>{'events': instance.events};

_ShakeDetectionEvent _$ShakeDetectionEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_ShakeDetectionEvent',
      json,
      ($checkedConvert) {
        final val = _ShakeDetectionEvent(
          id: $checkedConvert('id', (v) => (v as num?)?.toInt() ?? -1),
          eventId: $checkedConvert('event_id', (v) => v as String),
          serialNo: $checkedConvert(
            'serial_no',
            (v) => (v as num?)?.toInt() ?? -1,
          ),
          createdAt: $checkedConvert(
            'created_at',
            (v) => DateTime.parse(v as String),
          ),
          insertedAt: $checkedConvert(
            'inserted_at',
            (v) => DateTime.parse(v as String),
          ),
          maxIntensity: $checkedConvert(
            'max_intensity',
            (v) =>
                $enumDecodeNullable(
                  _$JmaForecastIntensityEnumMap,
                  v,
                  unknownValue: JmaForecastIntensity.unknown,
                ) ??
                JmaForecastIntensity.unknown,
          ),
          regions: $checkedConvert(
            'regions',
            (v) => (v as List<dynamic>)
                .map(
                  (e) =>
                      ShakeDetectionRegion.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
          topLeft: $checkedConvert(
            'top_left',
            (v) => ShakeDetectionLatLng.fromJson(v as Map<String, dynamic>),
          ),
          bottomRight: $checkedConvert(
            'bottom_right',
            (v) => ShakeDetectionLatLng.fromJson(v as Map<String, dynamic>),
          ),
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
        'pointCount': 'point_count',
      },
    );

Map<String, dynamic> _$ShakeDetectionEventToJson(
  _ShakeDetectionEvent instance,
) => <String, dynamic>{
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

_ShakeDetectionRegion _$ShakeDetectionRegionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ShakeDetectionRegion', json, ($checkedConvert) {
  final val = _ShakeDetectionRegion(
    name: $checkedConvert('name', (v) => v as String),
    maxIntensity: $checkedConvert(
      'maxIntensity',
      (v) =>
          $enumDecodeNullable(
            _$JmaForecastIntensityEnumMap,
            v,
            unknownValue: JmaForecastIntensity.unknown,
          ) ??
          JmaForecastIntensity.unknown,
    ),
    points: $checkedConvert(
      'points',
      (v) => (v as List<dynamic>)
          .map((e) => ShakeDetectionPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ShakeDetectionRegionToJson(
  _ShakeDetectionRegion instance,
) => <String, dynamic>{
  'name': instance.name,
  'maxIntensity': _$JmaForecastIntensityEnumMap[instance.maxIntensity]!,
  'points': instance.points,
};

_ShakeDetectionPoint _$ShakeDetectionPointFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ShakeDetectionPoint', json, ($checkedConvert) {
      final val = _ShakeDetectionPoint(
        intensity: $checkedConvert(
          'intensity',
          (v) =>
              $enumDecodeNullable(
                _$JmaForecastIntensityEnumMap,
                v,
                unknownValue: JmaForecastIntensity.unknown,
              ) ??
              JmaForecastIntensity.unknown,
        ),
        code: $checkedConvert('code', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ShakeDetectionPointToJson(
  _ShakeDetectionPoint instance,
) => <String, dynamic>{
  'intensity': _$JmaForecastIntensityEnumMap[instance.intensity]!,
  'code': instance.code,
};

_ShakeDetectionLatLng _$ShakeDetectionLatLngFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ShakeDetectionLatLng', json, ($checkedConvert) {
  final val = _ShakeDetectionLatLng(
    latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
    longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
  );
  return val;
});

Map<String, dynamic> _$ShakeDetectionLatLngToJson(
  _ShakeDetectionLatLng instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
