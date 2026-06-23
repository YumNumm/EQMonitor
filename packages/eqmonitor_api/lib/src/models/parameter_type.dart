// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum ParameterType {
  @JsonValue('JMA_CODE_TABLE')
  jmaCodeTable('JMA_CODE_TABLE'),
  @JsonValue('KYOSHIN_OBSERVATION_POINTS')
  kyoshinObservationPoints('KYOSHIN_OBSERVATION_POINTS'),
  @JsonValue('EARTHQUAKE_STATIONS')
  earthquakeStations('EARTHQUAKE_STATIONS'),
  @JsonValue('TSUNAMI_STATIONS')
  tsunamiStations('TSUNAMI_STATIONS');

  const ParameterType(this.json);

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError(
        'Cannot convert enum value with null JSON representation to String. '
        'This usually happens for \$unknown or @JsonValue(null) entries.',
      );
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
