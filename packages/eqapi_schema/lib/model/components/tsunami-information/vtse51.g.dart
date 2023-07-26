// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'vtse51.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PublicBodyVtse51Tsunami _$$_PublicBodyVtse51TsunamiFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_PublicBodyVtse51Tsunami',
      json,
      ($checkedConvert) {
        final val = _$_PublicBodyVtse51Tsunami(
          forecasts: $checkedConvert(
              'forecasts',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      TsunamiForecast.fromJson(e as Map<String, dynamic>))
                  .toList()),
          observations: $checkedConvert(
              'observations',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      TsunamiObservation.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_PublicBodyVtse51TsunamiToJson(
        _$_PublicBodyVtse51Tsunami instance) =>
    <String, dynamic>{
      'forecasts': instance.forecasts,
      'observations': instance.observations,
    };
