// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'tsunami_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TsunamiForecastImpl _$$TsunamiForecastImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiForecastImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiForecastImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          kind: $checkedConvert('kind', (v) => v as String),
          lastKind: $checkedConvert('last_kind', (v) => v as String),
          firstHeight: $checkedConvert(
              'first_height',
              (v) => v == null
                  ? null
                  : TsunamiForecastFirstHeight.fromJson(
                      v as Map<String, dynamic>)),
          maxHeight: $checkedConvert(
              'max_height',
              (v) => v == null
                  ? null
                  : TsunamiForecastMaxHeight.fromJson(
                      v as Map<String, dynamic>)),
          stations: $checkedConvert(
              'stations',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => TsunamiForecastStation.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'lastKind': 'last_kind',
        'firstHeight': 'first_height',
        'maxHeight': 'max_height'
      },
    );

Map<String, dynamic> _$$TsunamiForecastImplToJson(
        _$TsunamiForecastImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'kind': instance.kind,
      'last_kind': instance.lastKind,
      'first_height': instance.firstHeight,
      'max_height': instance.maxHeight,
      'stations': instance.stations,
    };

_$TsunamiForecastFirstHeightImpl _$$TsunamiForecastFirstHeightImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiForecastFirstHeightImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiForecastFirstHeightImpl(
          arrivalTime: $checkedConvert('arrival_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          condition: $checkedConvert('condition',
              (v) => $enumDecodeNullable(_$TsunamiForecastConditionEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {'arrivalTime': 'arrival_time'},
    );

Map<String, dynamic> _$$TsunamiForecastFirstHeightImplToJson(
        _$TsunamiForecastFirstHeightImpl instance) =>
    <String, dynamic>{
      'arrival_time': instance.arrivalTime?.toIso8601String(),
      'condition': _$TsunamiForecastConditionEnumMap[instance.condition],
    };

const _$TsunamiForecastConditionEnumMap = {
  TsunamiForecastCondition.tsunamiArrival: '津波到達中と推測',
  TsunamiForecastCondition.tsunamiFirstArrival: '第１波の到達を確認',
  TsunamiForecastCondition.tsunamiImminent: 'ただちに津波来襲と予測',
};

_$TsunamiForecastMaxHeightImpl _$$TsunamiForecastMaxHeightImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiForecastMaxHeightImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiForecastMaxHeightImpl(
          value: $checkedConvert('value', (v) => (v as num?)?.toDouble()),
          isOver: $checkedConvert('is_over', (v) => v as bool?),
          condition: $checkedConvert(
              'condition',
              (v) => $enumDecodeNullable(
                  _$TsunamiForecastMaxHeightConditionEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {'isOver': 'is_over'},
    );

Map<String, dynamic> _$$TsunamiForecastMaxHeightImplToJson(
        _$TsunamiForecastMaxHeightImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'is_over': instance.isOver,
      'condition':
          _$TsunamiForecastMaxHeightConditionEnumMap[instance.condition],
    };

const _$TsunamiForecastMaxHeightConditionEnumMap = {
  TsunamiForecastMaxHeightCondition.high: '高い',
  TsunamiForecastMaxHeightCondition.huge: '莫大',
};

_$TsunamiForecastStationImpl _$$TsunamiForecastStationImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiForecastStationImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiForecastStationImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          highTideTime: $checkedConvert(
              'high_tide_time', (v) => DateTime.parse(v as String)),
          firstHeightTime: $checkedConvert('first_height_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          condition: $checkedConvert(
              'condition',
              (v) => $enumDecodeNullable(
                  _$TsunamiForecastStationConditionEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {
        'highTideTime': 'high_tide_time',
        'firstHeightTime': 'first_height_time'
      },
    );

Map<String, dynamic> _$$TsunamiForecastStationImplToJson(
        _$TsunamiForecastStationImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'high_tide_time': instance.highTideTime.toIso8601String(),
      'first_height_time': instance.firstHeightTime?.toIso8601String(),
      'condition': _$TsunamiForecastStationConditionEnumMap[instance.condition],
    };

const _$TsunamiForecastStationConditionEnumMap = {
  TsunamiForecastStationCondition.tsunamiArrival: '津波到達中と推測',
  TsunamiForecastStationCondition.tsunamiFirstArrival: '第１波の到達を確認',
};
