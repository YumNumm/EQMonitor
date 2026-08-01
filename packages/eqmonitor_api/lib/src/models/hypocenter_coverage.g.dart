// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter_coverage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HypocenterCoverage _$HypocenterCoverageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_HypocenterCoverage', json, ($checkedConvert) {
      final val = _HypocenterCoverage(
        from: $checkedConvert('from', (v) => DateTime.parse(v as String)),
        to: $checkedConvert('to', (v) => DateTime.parse(v as String)),
      );
      return val;
    });

Map<String, dynamic> _$HypocenterCoverageToJson(_HypocenterCoverage instance) =>
    <String, dynamic>{
      'from': instance.from.toIso8601String(),
      'to': instance.to.toIso8601String(),
    };
