// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vtse52.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PublicBodyVtse52Tsunami _$$_PublicBodyVtse52TsunamiFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_PublicBodyVtse52Tsunami',
      json,
      ($checkedConvert) {
        final val = _$_PublicBodyVtse52Tsunami(
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

Map<String, dynamic> _$$_PublicBodyVtse52TsunamiToJson(
        _$_PublicBodyVtse52Tsunami instance) =>
    <String, dynamic>{
      'observations': instance.observations,
      'estimations': instance.estimations,
    };
