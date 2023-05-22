// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tsunami_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TsunamiForecast _$$_TsunamiForecastFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TsunamiForecast',
      json,
      ($checkedConvert) {
        final val = _$_TsunamiForecast(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          kind: $checkedConvert('kind', (v) => v as String),
          lastKind: $checkedConvert('lastKind', (v) => v as String),
          firstHeight: $checkedConvert(
              'firstHeight',
              (v) => v == null
                  ? null
                  : TsunamiForecastFirstHeight.fromJson(
                      v as Map<String, dynamic>)),
          maxHeight: $checkedConvert(
              'maxHeight',
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
    );

Map<String, dynamic> _$$_TsunamiForecastToJson(_$_TsunamiForecast instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'kind': instance.kind,
      'lastKind': instance.lastKind,
      'firstHeight': instance.firstHeight,
      'maxHeight': instance.maxHeight,
      'stations': instance.stations,
    };

_$_TsunamiForecastFirstHeight _$$_TsunamiForecastFirstHeightFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TsunamiForecastFirstHeight',
      json,
      ($checkedConvert) {
        final val = _$_TsunamiForecastFirstHeight(
          arrivalTime: $checkedConvert('arrivalTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          condition: $checkedConvert('condition',
              (v) => $enumDecodeNullable(_$TsunamiForecastConditionEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TsunamiForecastFirstHeightToJson(
        _$_TsunamiForecastFirstHeight instance) =>
    <String, dynamic>{
      'arrivalTime': instance.arrivalTime?.toIso8601String(),
      'condition': _$TsunamiForecastConditionEnumMap[instance.condition],
    };

const _$TsunamiForecastConditionEnumMap = {
  TsunamiForecastCondition.tsunamiArrival: '津波到達中と推測',
  TsunamiForecastCondition.tsunamiFirstArrival: '第１波の到達を確認',
  TsunamiForecastCondition.tsunamiImminent: 'ただちに津波来襲と予測',
};

_$_TsunamiForecastMaxHeight _$$_TsunamiForecastMaxHeightFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TsunamiForecastMaxHeight',
      json,
      ($checkedConvert) {
        final val = _$_TsunamiForecastMaxHeight(
          value: $checkedConvert('value', (v) => (v as num?)?.toDouble()),
          isOver: $checkedConvert('isOver', (v) => v as bool?),
          condition: $checkedConvert(
              'condition',
              (v) => $enumDecodeNullable(
                  _$TsunamiForecastMaxHeightConditionEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TsunamiForecastMaxHeightToJson(
        _$_TsunamiForecastMaxHeight instance) =>
    <String, dynamic>{
      'value': instance.value,
      'isOver': instance.isOver,
      'condition':
          _$TsunamiForecastMaxHeightConditionEnumMap[instance.condition],
    };

const _$TsunamiForecastMaxHeightConditionEnumMap = {
  TsunamiForecastMaxHeightCondition.high: '高い',
  TsunamiForecastMaxHeightCondition.huge: '莫大',
};

_$_TsunamiForecastStation _$$_TsunamiForecastStationFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TsunamiForecastStation',
      json,
      ($checkedConvert) {
        final val = _$_TsunamiForecastStation(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          highTideTime: $checkedConvert(
              'highTideTime', (v) => DateTime.parse(v as String)),
          firstHeightTime: $checkedConvert('firstHeightTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          condition: $checkedConvert(
              'condition',
              (v) => $enumDecodeNullable(
                  _$TsunamiForecastStationConditionEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TsunamiForecastStationToJson(
        _$_TsunamiForecastStation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'highTideTime': instance.highTideTime.toIso8601String(),
      'firstHeightTime': instance.firstHeightTime?.toIso8601String(),
      'condition': _$TsunamiForecastStationConditionEnumMap[instance.condition],
    };

const _$TsunamiForecastStationConditionEnumMap = {
  TsunamiForecastStationCondition.tsunamiArrival: '津波到達中と推測',
  TsunamiForecastStationCondition.tsunamiFirstArrival: '第１波の到達を確認',
};
