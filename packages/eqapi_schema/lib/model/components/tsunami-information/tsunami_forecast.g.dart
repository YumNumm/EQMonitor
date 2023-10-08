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

Map<String, dynamic> _$$TsunamiForecastImplToJson(
        _$TsunamiForecastImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'kind': instance.kind,
      'lastKind': instance.lastKind,
      'firstHeight': instance.firstHeight,
      'maxHeight': instance.maxHeight,
      'stations': instance.stations,
    };

_$TsunamiForecastFirstHeightImpl _$$TsunamiForecastFirstHeightImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiForecastFirstHeightImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiForecastFirstHeightImpl(
          arrivalTime: $checkedConvert('arrivalTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          condition: $checkedConvert('condition',
              (v) => $enumDecodeNullable(_$TsunamiForecastConditionEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiForecastFirstHeightImplToJson(
        _$TsunamiForecastFirstHeightImpl instance) =>
    <String, dynamic>{
      'arrivalTime': instance.arrivalTime?.toIso8601String(),
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
          isOver: $checkedConvert('isOver', (v) => v as bool?),
          condition: $checkedConvert(
              'condition',
              (v) => $enumDecodeNullable(
                  _$TsunamiForecastMaxHeightConditionEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiForecastMaxHeightImplToJson(
        _$TsunamiForecastMaxHeightImpl instance) =>
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

Map<String, dynamic> _$$TsunamiForecastStationImplToJson(
        _$TsunamiForecastStationImpl instance) =>
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
