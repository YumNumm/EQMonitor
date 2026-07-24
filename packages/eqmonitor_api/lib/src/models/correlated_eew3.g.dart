// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'correlated_eew3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CorrelatedEew3 _$CorrelatedEew3FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CorrelatedEew3', json, ($checkedConvert) {
      final val = _CorrelatedEew3(
        eventId: $checkedConvert('eventId', (v) => v as String),
        score: $checkedConvert('score', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$CorrelatedEew3ToJson(_CorrelatedEew3 instance) =>
    <String, dynamic>{'eventId': instance.eventId, 'score': instance.score};
