// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'correlated_eew.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CorrelatedEew _$CorrelatedEewFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CorrelatedEew', json, ($checkedConvert) {
      final val = _CorrelatedEew(
        eventId: $checkedConvert('eventId', (v) => v as String),
        score: $checkedConvert('score', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$CorrelatedEewToJson(_CorrelatedEew instance) =>
    <String, dynamic>{'eventId': instance.eventId, 'score': instance.score};
