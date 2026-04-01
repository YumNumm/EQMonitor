// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeState _$RealtimeStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_RealtimeState', json, ($checkedConvert) {
      final val = _RealtimeState(
        revision: $checkedConvert('revision', (v) => v as num),
        updatedAt: $checkedConvert(
          'updated_at',
          (v) => DateTime.parse(v as String),
        ),
        shakes: $checkedConvert(
          'shakes',
          (v) => (v as List<dynamic>)
              .map(
                (e) => ShakeDetectedPayload.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        eews: $checkedConvert(
          'eews',
          (v) => (v as List<dynamic>)
              .map((e) => EventMessage.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        earthquakes: $checkedConvert(
          'earthquakes',
          (v) => (v as List<dynamic>)
              .map((e) => EarthquakePartial.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        tsunamis: $checkedConvert(
          'tsunamis',
          (v) => (v as List<dynamic>)
              .map((e) => TsunamiListItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'updatedAt': 'updated_at'});

Map<String, dynamic> _$RealtimeStateToJson(_RealtimeState instance) =>
    <String, dynamic>{
      'revision': instance.revision,
      'updated_at': instance.updatedAt.toIso8601String(),
      'shakes': instance.shakes,
      'eews': instance.eews,
      'earthquakes': instance.earthquakes,
      'tsunamis': instance.tsunamis,
    };
