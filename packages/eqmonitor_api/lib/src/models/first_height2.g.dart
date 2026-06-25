// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'first_height2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FirstHeight2 _$FirstHeight2FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FirstHeight2', json, ($checkedConvert) {
      final val = _FirstHeight2(
        arrivalTime: $checkedConvert(
          'arrival_time',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        condition: $checkedConvert('condition', (v) => v as String?),
        revise: $checkedConvert('revise', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'arrivalTime': 'arrival_time'});

Map<String, dynamic> _$FirstHeight2ToJson(_FirstHeight2 instance) =>
    <String, dynamic>{
      'arrival_time': ?instance.arrivalTime?.toIso8601String(),
      'condition': ?instance.condition,
      'revise': ?instance.revise,
    };
