// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'correlated_eew2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CorrelatedEew2 _$CorrelatedEew2FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CorrelatedEew2', json, ($checkedConvert) {
      final val = _CorrelatedEew2(
        eventId: $checkedConvert('eventId', (v) => v as String),
        score: $checkedConvert('score', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$CorrelatedEew2ToJson(_CorrelatedEew2 instance) =>
    <String, dynamic>{'eventId': instance.eventId, 'score': instance.score};
