// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'focal_mechanism.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FocalMechanism _$FocalMechanismFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FocalMechanism', json, ($checkedConvert) {
      final val = _FocalMechanism(
        tiltAngle: $checkedConvert(
          'tiltAngle',
          (v) => AnglePair.fromJson(v as Map<String, dynamic>),
        ),
        slipAngle: $checkedConvert(
          'slipAngle',
          (v) => AnglePair.fromJson(v as Map<String, dynamic>),
        ),
        strikeAngle: $checkedConvert(
          'strikeAngle',
          (v) => AnglePair.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$FocalMechanismToJson(_FocalMechanism instance) =>
    <String, dynamic>{
      'tiltAngle': instance.tiltAngle,
      'slipAngle': instance.slipAngle,
      'strikeAngle': instance.strikeAngle,
    };
