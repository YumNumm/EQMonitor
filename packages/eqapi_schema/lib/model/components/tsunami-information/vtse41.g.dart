// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'vtse41.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PublicBodyVtse41Tsunami _$$_PublicBodyVtse41TsunamiFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_PublicBodyVtse41Tsunami',
      json,
      ($checkedConvert) {
        final val = _$_PublicBodyVtse41Tsunami(
          forecasts: $checkedConvert(
              'forecasts',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      TsunamiForecast.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_PublicBodyVtse41TsunamiToJson(
        _$_PublicBodyVtse41Tsunami instance) =>
    <String, dynamic>{
      'forecasts': instance.forecasts,
    };
