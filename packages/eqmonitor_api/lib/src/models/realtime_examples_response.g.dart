// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_examples_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeExamplesResponse _$RealtimeExamplesResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_RealtimeExamplesResponse', json, ($checkedConvert) {
  final val = _RealtimeExamplesResponse(
    examples: $checkedConvert('examples', (v) => v as List<dynamic>),
  );
  return val;
});

Map<String, dynamic> _$RealtimeExamplesResponseToJson(
  _RealtimeExamplesResponse instance,
) => <String, dynamic>{'examples': instance.examples};
