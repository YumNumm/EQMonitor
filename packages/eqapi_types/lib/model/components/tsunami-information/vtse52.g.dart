// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'vtse52.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublicBodyVtse52TsunamiImpl _$$PublicBodyVtse52TsunamiImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PublicBodyVtse52TsunamiImpl',
      json,
      ($checkedConvert) {
        final val = _$PublicBodyVtse52TsunamiImpl(
          observations: $checkedConvert(
              'observations',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      TsunamiObservation.fromJson(e as Map<String, dynamic>))
                  .toList()),
          estimations: $checkedConvert(
              'estimations',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      TsunamiEstimation.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$PublicBodyVtse52TsunamiImplToJson(
        _$PublicBodyVtse52TsunamiImpl instance) =>
    <String, dynamic>{
      'observations': instance.observations,
      'estimations': instance.estimations,
    };
