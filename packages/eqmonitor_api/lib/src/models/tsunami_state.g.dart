// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiState _$TsunamiStateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiState',
  json,
  ($checkedConvert) {
    final val = _TsunamiState(
      id: $checkedConvert('id', (v) => v as String),
      eventIds: $checkedConvert(
        'event_ids',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
      isActive: $checkedConvert('is_active', (v) => v as bool),
      isCanceled: $checkedConvert('is_canceled', (v) => v as bool),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
      earthquakes: $checkedConvert(
        'earthquakes',
        (v) => (v as List<dynamic>)
            .map(
              (e) => TsunamiStateEarthquake.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      latestTelegrams: $checkedConvert(
        'latest_telegrams',
        (v) => (v as List<dynamic>)
            .map((e) => LatestTelegram.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      regions: $checkedConvert(
        'regions',
        (v) => (v as List<dynamic>)
            .map((e) => TsunamiRegion.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      offshoreStations: $checkedConvert(
        'offshore_stations',
        (v) => (v as List<dynamic>)
            .map(
              (e) => TsunamiOffshoreStation.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventIds': 'event_ids',
    'isActive': 'is_active',
    'isCanceled': 'is_canceled',
    'updatedAt': 'updated_at',
    'latestTelegrams': 'latest_telegrams',
    'offshoreStations': 'offshore_stations',
  },
);

Map<String, dynamic> _$TsunamiStateToJson(_TsunamiState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_ids': instance.eventIds,
      'is_active': instance.isActive,
      'is_canceled': instance.isCanceled,
      'updated_at': instance.updatedAt.toIso8601String(),
      'earthquakes': instance.earthquakes,
      'latest_telegrams': instance.latestTelegrams,
      'regions': instance.regions,
      'offshore_stations': instance.offshoreStations,
    };
