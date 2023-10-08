// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'vtse51.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublicBodyVtse51TsunamiImpl _$$PublicBodyVtse51TsunamiImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PublicBodyVtse51TsunamiImpl',
      json,
      ($checkedConvert) {
        final val = _$PublicBodyVtse51TsunamiImpl(
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

Map<String, dynamic> _$$PublicBodyVtse51TsunamiImplToJson(
        _$PublicBodyVtse51TsunamiImpl instance) =>
    <String, dynamic>{
      'forecasts': instance.forecasts,
      'observations': instance.observations,
    };
