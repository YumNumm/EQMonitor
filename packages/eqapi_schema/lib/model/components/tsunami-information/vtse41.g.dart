// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'vtse41.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublicBodyVtse41TsunamiImpl _$$PublicBodyVtse41TsunamiImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PublicBodyVtse41TsunamiImpl',
      json,
      ($checkedConvert) {
        final val = _$PublicBodyVtse41TsunamiImpl(
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

Map<String, dynamic> _$$PublicBodyVtse41TsunamiImplToJson(
        _$PublicBodyVtse41TsunamiImpl instance) =>
    <String, dynamic>{
      'forecasts': instance.forecasts,
    };
